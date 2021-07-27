part of 'item_bloc.dart';

@immutable
abstract class ItemEvent {}

class OnGetItems extends ItemEvent {}

class OnGetMoreItems extends ItemEvent {}

class OnSelectedTab extends ItemEvent {
  OnSelectedTab({this.type, this.itemsName});

  final String? type;
  final String? itemsName;
}

class OnRefresh extends ItemEvent {}
