part of 'stories_bloc.dart';

@immutable
abstract class StoriesEvent {}

class OnGetStories extends StoriesEvent {}

class OnGetMoreStories extends StoriesEvent {}

class OnSelectedTab extends StoriesEvent {
  OnSelectedTab({this.type, this.storiesName});

  final String? type;
  final String? storiesName;
}

class OnRefresh extends StoriesEvent {}
