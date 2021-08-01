import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hacker_news_clone/data/models/item.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(this.repo)
      : super(const CommentState(status: CommentStatus.initial));
  final Repository repo;

  Future<Item> getItemWithComments(int id) async {
    List<Item?> nestedComments = <Item>[];
    //here we get the parent comment
    final Item? item = await repo.fetchItem(id);
    //and then we get all the comments nested in the parent comment
    //and save then in a list
    nestedComments = await repo.getComments(item);
    item!.comments!.addAll(nestedComments);
    return item;
  }

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is OnGetComments) {
      //first we fetch the parent comment
      final Future<Item?> item = repo.fetchItem(event.id!);
      yield loadComment(item, event.id!);
    }
  }

  //then we call this function to create a map where the key is the id of parent comment and the value is info inside the parent comment
  CommentState loadComment(Future<Item?> item, int id) {
    final Map<int, Future<Item?>> map =
        Map<int, Future<Item?>>.from(state.comments!);
    map.putIfAbsent(id, () => item);
    return CommentState(status: CommentStatus.loaded, comments: map);
  }
}
