import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(this.repo) : super(CommentState());
  final Repository repo;

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
