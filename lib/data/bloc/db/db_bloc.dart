import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

//My imports
import 'package:hacker_news_clone/data/db/watched_stories.dart';
import 'package:hacker_news_clone/data/models/story.dart';

part 'db_event.dart';
part 'db_state.dart';

class DbBloc extends Bloc<DbEvent, DbState> {
  DbBloc(this.db) : super(const DbState());
  final MyDatabase db;

  @override
  Stream<DbState> mapEventToState(
    DbEvent event,
  ) async* {
    if (event is OnGetStoriesFromDB) {
      final List<int> ids = <int>[];
      final List<WatchedStorie> watchedStories = await db.allStories;
      watchedStories.forEach((WatchedStorie story) {
        ids.add(story.id);
      });
      yield state.copyWith(listIdsRead: ids);
    }
    if (event is OnInsertReadStory) {
      db.insertStory(event.story!);
    }
  }
}
