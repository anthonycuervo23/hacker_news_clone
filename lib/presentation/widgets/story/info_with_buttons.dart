import 'package:flutter/material.dart';
import 'package:hacker_news_clone/presentation/pages/comment_page.dart';
import 'package:share/share.dart';

//My imports
import 'package:hacker_news_clone/data/models/story.dart';

class InfoWithButtons extends StatelessWidget {
  const InfoWithButtons(
      {Key? key, this.story, this.counter, this.launchBrowser, this.isWatched})
      : super(key: key);

  final Story? story;
  final int? counter;
  final Function(String)? launchBrowser;
  final bool? isWatched;

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
                    color: story!.seen!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  Text(' ${1 + counter!}    ',
                      style: TextStyle(
                          fontSize: 13,
                          color: story!.seen!
                              ? Theme.of(context).disabledColor.withOpacity(0.2)
                              : Theme.of(context).hintColor.withOpacity(0.6))),
                  Icon(
                    Icons.arrow_upward_outlined,
                    color: story!.seen!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  if (story!.score! == 1)
                    Text('${story!.score!} Point',
                        style: TextStyle(
                            fontSize: 13,
                            color: story!.seen!
                                ? Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.2)
                                : Theme.of(context).hintColor.withOpacity(0.6)))
                  else
                    Text(' ${story!.score!} Points',
                        style: TextStyle(
                            fontSize: 13,
                            color: story!.seen!
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
                    color: story!.seen!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  Text(
                    '  ${story!.timeAgo}',
                    style: TextStyle(
                        fontSize: 13,
                        color: story!.seen!
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
            Container(
              width: story!.descendants == 0
                  ? 50
                  : story!.descendants!.toDouble() > 99
                      ? (story!.descendants!.toDouble() > 999 ? 95 : 85)
                      : 75,
              height: 40,
              child: TextButton(
                onLongPress: () {
                  Share.share(
                      'https://news.ycombinator.com/item?id=${story!.id}');
                },
                onPressed: () {
                  // launchBrowser!(
                  //     'https://news.ycombinator.com/item?id=${story!.id}');
                  Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (_) => CommentPage(item: story)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.comment_outlined,
                      size: 21,
                      color: story!.seen!
                          ? Theme.of(context).disabledColor.withOpacity(0.2)
                          : Theme.of(context)
                              .textTheme
                              .headline6!
                              .color!
                              .withOpacity(0.7),
                    ),
                    Visibility(
                      visible: story!.descendants! == null,
                      child: const SizedBox(
                        width: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                      child: Visibility(
                        visible: story!.descendants! != null,
                        maintainState: true,
                        child: story!.descendants! != 0
                            ? Text('  ${story!.descendants!}',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: story!.seen!
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
            Container(
              width: 50,
              height: 40,
              child: TextButton(
                onPressed: () {
                  if (story!.url != null) {
                    Share.share(story!.url!);
                  } else {
                    // ASK/SHOW HN
                    Share.share(
                        'https://news.ycombinator.com/item?id=${story!.id}');
                  }
                },
                child: Icon(
                  Icons.share_outlined,
                  size: 21,
                  color: story!.seen!
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
