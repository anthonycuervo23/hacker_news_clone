part of 'item_bloc.dart';

@immutable
class ItemState {
  const ItemState(
      {required this.status,
      this.type = 'topstories',
      this.itemsName = 'Top Stories',
      this.items = const <Item?>[],
      this.loadItemsOnScroll = false,
      this.message,
      this.ids});

  final NewsStatus status;
  final String type;
  final List<int>? ids;
  final bool loadItemsOnScroll;
  final List<Item?> items;
  final String? message;
  final String itemsName;

  ItemState copyWith(
      {NewsStatus? status,
      String? type,
      List<Item?>? items,
      String? itemsName,
      bool? loadItemsOnScroll,
      List<int>? ids,
      String? message}) {
    return ItemState(
      status: status ?? this.status,
      type: type ?? this.type,
      items: items ?? this.items,
      loadItemsOnScroll: loadItemsOnScroll ?? this.loadItemsOnScroll,
      itemsName: itemsName ?? this.itemsName,
      ids: ids ?? this.ids,
      message: message ?? this.message,
    );
  }
}
