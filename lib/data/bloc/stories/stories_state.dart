part of 'stories_bloc.dart';

@immutable
class StoriesState {
  const StoriesState({required this.status, this.type, this.message, this.ids});

  final NewsStatus status;
  final StoriesType? type;
  final List<int>? ids;
  final String? message;

  StoriesState copyWith(
      {NewsStatus? status,
      StoriesType? type,
      List<int>? ids,
      String? message}) {
    return StoriesState(
      status: status ?? this.status,
      type: type ?? this.type,
      ids: ids ?? this.ids,
      message: message ?? this.message,
    );
  }
}
