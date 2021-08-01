part of 'db_bloc.dart';

@immutable
abstract class DbEvent {}

class OnGetItemsFromDB extends DbEvent {}

class OnInsertReadItem extends DbEvent {
  OnInsertReadItem({this.item});

  final Item? item;
}
