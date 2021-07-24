part of 'story_bloc.dart';

@immutable
abstract class StoryEvent {}

class OnGetStories extends StoryEvent {}

class OnGetMoreStories extends StoryEvent {}

class OnSelectedTab extends StoryEvent {
  OnSelectedTab({this.type, this.storiesName});

  final String? type;
  final String? storiesName;
}

class OnRefresh extends StoryEvent {}
