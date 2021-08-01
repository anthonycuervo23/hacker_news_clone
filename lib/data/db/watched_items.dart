import 'package:moor_flutter/moor_flutter.dart';

//My imports
import 'package:hacker_news_clone/data/models/item.dart';

part 'watched_items.g.dart';

// typedef IntColumn = Column<int>;
// typedef TextColumn = Column<String>;

// this will generate a table called "watchedStories" for us. The rows of that table will
// be represented by a class called "WatchedStories".
class WatchedItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}

// this annotation tells moor to prepare a database class that uses the table
// we just defined. We'll see how to use that database class in a moment.
@UseMoor(tables: <Type>[WatchedItems])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite1'));

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  // loads all watchedStories entries
  Future<List<WatchedItem>> get allItems => select(watchedItems).get();

  void insertItem(Item item) {
    final WatchedItem watchedItem =
        WatchedItem(id: item.id, title: item.title!);
    into(watchedItems).insert(watchedItem);
  }
}
