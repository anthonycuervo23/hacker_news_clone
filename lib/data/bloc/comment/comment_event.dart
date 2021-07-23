part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class OnGetComments extends CommentEvent {
  OnGetComments({this.item});

  final int? item;
}
