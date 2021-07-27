import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

//My imports
import 'package:hacker_news_clone/data/utils/hacker_news_enum.dart';
import 'package:hacker_news_clone/data/models/item.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc(this.repo) : super(const ItemState(status: NewsStatus.initial));
  final Repository repo;

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is OnGetItems) {
      yield state.copyWith(status: NewsStatus.loading);
      final List<Item> filteredItems = <Item>[];
      final List<Item?> items = await repo.getItems(state.type, 20);
      if (items.isEmpty) {
        yield state.copyWith(
            status: NewsStatus.error,
            message: 'Could not get stories, please try again');
      } else {
        for (final Item? item in items) {
          if (item!.type == 'story') {
            filteredItems.add(item);
          }
        }
        yield state.copyWith(
          items: filteredItems,
          status: NewsStatus.loaded,
        );
      }
    } else if (event is OnGetMoreItems) {
      yield state.copyWith(loadItemsOnScroll: true);
      final List<Item?> items =
          await repo.getMoreItems(state.type, 10, state.items.length);
      if (items.isEmpty) {
        yield state.copyWith(
            status: NewsStatus.error,
            message: 'Could not load more stories, please try again');
      } else {
        for (final Item? item in items) {
          if (item!.descendants != null) {
            state.items.add(item);
          }
        }
        yield state.copyWith(items: state.items, loadItemsOnScroll: false);
      }
    } else if (event is OnSelectedTab) {
      yield state.copyWith(
        type: event.type,
        itemsName: event.itemsName,
      );
    }
  }

  Future<Item?> getItemsById(int id) async {
    return repo.fetchItem(id);
  }
}
