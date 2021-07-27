part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class OnGetComments extends CommentEvent {
  OnGetComments({this.id});

  //for comment display, we need id

  final int? id;
}
