import 'package:flutter/material.dart';
import 'package:hacker_news_clone/presentation/pages/comment_page.dart';
import 'package:share/share.dart';

//My imports
import 'package:hacker_news_clone/data/models/item.dart';

class InfoWithButtons extends StatelessWidget {
  const InfoWithButtons({Key? key, this.item, this.counter}) : super(key: key);

  final Item? item;
  final int? counter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.article_outlined,
                    color: item!.seen!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  Text(' ${1 + counter!}    ',
                      style: TextStyle(
                          fontSize: 13,
                          color: item!.seen!
                              ? Theme.of(context).disabledColor.withOpacity(0.2)
                              : Theme.of(context).hintColor.withOpacity(0.6))),
                  Icon(
                    Icons.arrow_upward_outlined,
                    color: item!.seen!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  if (item!.score! == 1)
                    Text('${item!.score!} Point',
                        style: TextStyle(
                            fontSize: 13,
                            color: item!.seen!
                                ? Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.2)
                                : Theme.of(context).hintColor.withOpacity(0.6)))
                  else
                    Text(' ${item!.score!} Points',
                        style: TextStyle(
                            fontSize: 13,
                            color: item!.seen!
                                ? Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.2)
                                : Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.6))),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time_outlined,
                    color: item!.seen!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  Text(
                    '  ${item!.timeAgo}',
                    style: TextStyle(
                        fontSize: 13,
                        color: item!.seen!
                            ? Theme.of(context).disabledColor.withOpacity(0.2)
                            : Theme.of(context).hintColor.withOpacity(0.6)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: item!.descendants == 0
                  ? 50
                  : item!.descendants!.toDouble() > 99
                      ? (item!.descendants!.toDouble() > 999 ? 95 : 85)
                      : 75,
              height: 40,
              child: TextButton(
                onLongPress: () {
                  Share.share(
                      'https://news.ycombinator.com/item?id=${item!.id}');
                },
                onPressed: () {
                  Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (_) => CommentPage(item: item)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.comment_outlined,
                      size: 21,
                      color: item!.seen!
                          ? Theme.of(context).disabledColor.withOpacity(0.2)
                          : Theme.of(context)
                              .textTheme
                              .headline6!
                              .color!
                              .withOpacity(0.7),
                    ),
                    Visibility(
                      visible: item!.descendants! == null,
                      child: const SizedBox(
                        width: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                      child: Visibility(
                        visible: item!.descendants! != null,
                        maintainState: true,
                        child: item!.descendants! != 0
                            ? Text('  ${item!.descendants!}',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: item!.seen!
                                      ? Theme.of(context)
                                          .disabledColor
                                          .withOpacity(0.2)
                                      : Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color!
                                          .withOpacity(0.7),
                                ))
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).cardTheme.color,
                  onPrimary: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 50,
              height: 40,
              child: TextButton(
                onPressed: () {
                  if (item!.url != null) {
                    Share.share(item!.url!);
                  } else {
                    // ASK/SHOW HN
                    Share.share(
                        'https://news.ycombinator.com/item?id=${item!.id}');
                  }
                },
                child: Icon(
                  Icons.share_outlined,
                  size: 21,
                  color: item!.seen!
                      ? Theme.of(context).disabledColor.withOpacity(0.2)
                      : Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.7),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).cardTheme.color,
                  onPrimary: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ],
    );
  }
}
