part of 'comment_bloc.dart';

@immutable
class CommentState {
  const CommentState({this.comments});

  final List<Story?>? comments;

  CommentState copyWith({List<Story?>? comments}) {
    return CommentState(comments: comments ?? this.comments);
  }
}
