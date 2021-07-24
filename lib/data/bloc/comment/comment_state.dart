part of 'comment_bloc.dart';

@immutable
class CommentState {
  const CommentState({this.comments});

  final List<Item?>? comments;

  CommentState copyWith({List<Item?>? comments}) {
    return CommentState(comments: comments ?? this.comments);
  }
}
