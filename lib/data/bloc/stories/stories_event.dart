part of 'stories_bloc.dart';

@immutable
abstract class StoriesEvent {}

class OnGetNewStories extends StoriesEvent {}

class OnGetTopStories extends StoriesEvent {}

class OnGetStories extends StoriesEvent {}

class OnSelectedTab extends StoriesEvent {
  OnSelectedTab({this.type, this.loading, this.storiesName});

  final String? type;
  final bool? loading;
  final String? storiesName;
}

class OnRefresh extends StoriesEvent {}
