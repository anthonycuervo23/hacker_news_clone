import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hacker_news_clone/data/db/watched_stories.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:meta/meta.dart';

part 'db_event.dart';
part 'db_state.dart';

class DbBloc extends Bloc<DbEvent, DbState> {
  DbBloc(this.db) : super(const DbState());
  final MyDatabase db;

  void insertStory(Story story) {
    final WatchedStorie watchedStory =
        WatchedStorie(id: story.id, title: story.title!);
    db.into(db.watchedStories).insert(watchedStory);
  }

  @override
  Stream<DbState> mapEventToState(
    DbEvent event,
  ) async* {
    if (event is OnGetStoriesFromDB) {
      final List<WatchedStorie> test = await db.allStories;
      print(test);
    }
    if (event is OnInsertReadStory) {
      db.insertStory(event.story!);
    }
  }
}
