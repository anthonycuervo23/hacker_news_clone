part of 'stories_bloc.dart';

@immutable
abstract class StoriesEvent {}

class OnGetNewStories extends StoriesEvent {}

class OnGetTopStories extends StoriesEvent {}

class OnSelectedTab extends StoriesEvent {
  OnSelectedTab({this.type});

  final StoriesType? type;
}

class OnRefresh extends StoriesEvent {}
