part of 'comment_bloc.dart';

enum CommentStatus { initial, loading, loaded, error }

@immutable
class CommentState {
  const CommentState(
      {required this.status,
      this.comments = const <int, Future<Item?>>{},
      this.message}); //if comments is null, empty list will be assigned

  final CommentStatus status;

  final Map<int, Future<Item?>>?
      comments; //to display comment in hierarchical order

  final String? message;
}
