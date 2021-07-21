import 'package:hacker_news_clone/data/models/story.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'watched_stories.g.dart';

// this will generate a table called "watchedStories" for us. The rows of that table will
// be represented by a class called "WatchedStories".
class WatchedStories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}

// this annotation tells moor to prepare a database class that uses the table
// we just defined. We'll see how to use that database class in a moment.
@UseMoor(tables: <Type>[WatchedStories])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  // loads all watchedStories entries
  Future<List<WatchedStorie>> get allStories => select(watchedStories).get();

  // watches all stories entries in a given category. The stream will automatically
  // emit new items whenever the underlying data changes.
  Stream<bool> isAWatchedStory(int id) {
    return (select(watchedStories)
          ..where((WatchedStories story) => story.id.equals(id)))
        .watch()
        .map((List<WatchedStorie> stories) => stories.isNotEmpty);
  }

  Stream<List<WatchedStorie>> watchAllStories() =>
      select(watchedStories).watch();

  void insertStory(Story story) {
    final WatchedStorie watchedStory =
        WatchedStorie(id: story.id, title: story.title!);
    into(watchedStories).insert(watchedStory);
  }
}
