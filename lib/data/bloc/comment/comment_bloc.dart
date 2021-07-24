import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hacker_news_clone/data/models/item.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(this.repo) : super(CommentState());
  final Repository repo;

  Future<Item> getItemWithComments(int id) async {
    List<Item?> test = <Item>[];
    //here we get the parent comment
    final Item? item = await repo.fetchItem(id);
    //and then we get all the comments nested in the parent comment
    //and save then in a list
    test = await repo.getComments(item);
    item!.comments!.addAll(test);
    return item;
  }

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {}
}
