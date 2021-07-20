part of 'stories_bloc.dart';

@immutable
class StoriesState {
  const StoriesState(
      {required this.status,
      this.type = 'topstories',
      this.loading,
      this.storiesName = 'Top Stories',
      this.stories,
      this.message,
      this.ids});

  final NewsStatus status;
  final String type;
  final List<int>? ids;
  final List<Story?>? stories;
  final String? message;
  final bool? loading;
  final String storiesName;

  StoriesState copyWith(
      {NewsStatus? status,
      String? type,
      List<Story?>? stories,
      String? storiesName,
      bool? loading,
      List<int>? ids,
      String? message}) {
    return StoriesState(
      status: status ?? this.status,
      type: type ?? this.type,
      stories: stories ?? this.stories,
      loading: loading ?? this.loading,
      storiesName: storiesName ?? this.storiesName,
      ids: ids ?? this.ids,
      message: message ?? this.message,
    );
  }
}
