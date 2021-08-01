import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_clone/data/bloc/item/item_bloc.dart';

class HNAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HNAppBar({
    Key? key,
  }) : super(key: key);

  static const String _appBarTitle = 'HN';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (BuildContext context, ItemState state) {
        return AppBar(
          title: Row(
            children: <Widget>[
              Text(
                _appBarTitle,
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .headline6!
                        .color!
                        .withOpacity(0.9),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                state.itemsName,
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          elevation: 0,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40.0);
}
