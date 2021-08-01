import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

//My imports
import 'package:hacker_news_clone/data/db/watched_items.dart';
import 'package:hacker_news_clone/data/models/item.dart';

part 'db_event.dart';
part 'db_state.dart';

class DbBloc extends Bloc<DbEvent, DbState> {
  DbBloc(this.db) : super(const DbState());
  final MyDatabase db;

  @override
  Stream<DbState> mapEventToState(
    DbEvent event,
  ) async* {
    if (event is OnGetItemsFromDB) {
      // we get stories from DB and save ids in a list
      final List<int> ids = <int>[];
      final List<WatchedItem> watchedItems = await db.allItems;
      for (final WatchedItem item in watchedItems) {
        ids.add(item.id);
      }
      yield state.copyWith(listIdsRead: ids);
    }
    if (event is OnInsertReadItem) {
      db.insertItem(event.item!);
    }
  }
}
