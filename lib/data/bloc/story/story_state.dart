part of 'story_bloc.dart';

@immutable
class StoriesState {
  const StoriesState(
      {required this.status,
      this.type = 'topstories',
      this.storiesName = 'Top Stories',
      this.stories = const <Item?>[],
      this.loadStoriesOnScroll = false,
      this.message,
      this.ids});

  final NewsStatus status;
  final String type;
  final List<int>? ids;
  final bool loadStoriesOnScroll;
  final List<Item?> stories;
  final String? message;
  final String storiesName;

  StoriesState copyWith(
      {NewsStatus? status,
      String? type,
      List<Item?>? stories,
      String? storiesName,
      bool? loadStoriesOnScroll,
      List<int>? ids,
      String? message}) {
    return StoriesState(
      status: status ?? this.status,
      type: type ?? this.type,
      stories: stories ?? this.stories,
      loadStoriesOnScroll: loadStoriesOnScroll ?? this.loadStoriesOnScroll,
      storiesName: storiesName ?? this.storiesName,
      ids: ids ?? this.ids,
      message: message ?? this.message,
    );
  }
}
