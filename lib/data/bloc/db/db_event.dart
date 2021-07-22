part of 'db_bloc.dart';

@immutable
abstract class DbEvent {}

class OnGetStoriesFromDB extends DbEvent {}

class OnInsertReadStory extends DbEvent {
  OnInsertReadStory({this.story});

  final Story? story;
}
