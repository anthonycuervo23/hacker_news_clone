// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watched_items.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class WatchedItem extends DataClass implements Insertable<WatchedItem> {
  final int id;
  final String title;
  WatchedItem({required this.id, required this.title});
  factory WatchedItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return WatchedItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  WatchedItemsCompanion toCompanion(bool nullToAbsent) {
    return WatchedItemsCompanion(
      id: Value(id),
      title: Value(title),
    );
  }

  factory WatchedItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return WatchedItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  WatchedItem copyWith({int? id, String? title}) => WatchedItem(
        id: id ?? this.id,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('WatchedItem(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, title.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WatchedItem &&
          other.id == this.id &&
          other.title == this.title);
}

class WatchedItemsCompanion extends UpdateCompanion<WatchedItem> {
  final Value<int> id;
  final Value<String> title;
  const WatchedItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
  });
  WatchedItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
  }) : title = Value(title);
  static Insertable<WatchedItem> custom({
    Expression<int>? id,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
    });
  }

  WatchedItemsCompanion copyWith({Value<int>? id, Value<String>? title}) {
    return WatchedItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WatchedItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $WatchedItemsTable extends WatchedItems
    with TableInfo<$WatchedItemsTable, WatchedItem> {
  final GeneratedDatabase _db;
  final String? _alias;
  $WatchedItemsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title];
  @override
  String get aliasedName => _alias ?? 'watched_items';
  @override
  String get actualTableName => 'watched_items';
  @override
  VerificationContext validateIntegrity(Insertable<WatchedItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WatchedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return WatchedItem.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WatchedItemsTable createAlias(String alias) {
    return $WatchedItemsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $WatchedItemsTable watchedItems = $WatchedItemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [watchedItems];
}
