import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_clone/presentation/pages/webview_page.dart';

//My imports
import 'package:hacker_news_clone/data/bloc/db/db_bloc.dart';
import 'package:hacker_news_clone/data/models/item.dart';
import 'package:hacker_news_clone/presentation/widgets/item/info_with_buttons.dart';
import 'package:hacker_news_clone/presentation/widgets/item/title_with_url.dart';

class NewsItem extends StatefulWidget {
  const NewsItem({Key? key, required this.item, this.counter})
      : super(key: key);

  final Item? item;
  final int? counter;
  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  //URL LAUNCHER
  // Future<void> _launchBrowser(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Error';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final DbBloc dbBloc = BlocProvider.of<DbBloc>(context);
    return InkWell(
      onTap: () {
        if (widget.item!.url != null) {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) => WebViewPage(
                title: widget.item!.title!,
                url: widget.item!.url!,
              ),
            ),
          );
          //DB
          if (!widget.item!.seen!) {
            dbBloc.add(OnInsertReadItem(item: widget.item));
            dbBloc.add(OnGetItemsFromDB());
          }
        } else {
          // IF ASK/SHOW HN
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) => WebViewPage(
                title: 'widget.item!.title!',
                url: 'https://news.ycombinator.com/item?id=${widget.item!.id}',
              ),
            ),
          );

          // _launchBrowser(
          //     'https://news.ycombinator.com/item?id=${widget.item!.id}');

          //DB
          if (!widget.item!.seen!) {
            dbBloc.add(OnInsertReadItem(item: widget.item));
            dbBloc.add(OnGetItemsFromDB());
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 13),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TitleWithUrl(
              item: widget.item,
            ),
            InfoWithButtons(
              counter: widget.counter,
              item: widget.item,
            ),
          ],
        ),
      ),
    );
  }
}
