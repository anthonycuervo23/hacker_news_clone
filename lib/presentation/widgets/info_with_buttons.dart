import 'package:flutter/material.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:share/share.dart';

class InfoWithButtons extends StatelessWidget {
  const InfoWithButtons(
      {Key? key, this.story, this.counter, this.launchBrowser})
      : super(key: key);

  final Story? story;
  final int? counter;
  final Function(String)? launchBrowser;

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
                  const Icon(
                    Icons.article_outlined,
                    color: Colors.grey,
                    size: 16,
                  ),
                  Text(' ${1 + counter!}    ',
                      style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  const Icon(
                    Icons.arrow_upward_outlined,
                    color: Colors.grey,
                    size: 16,
                  ),
                  if (story!.score! == 1)
                    Text('${story!.score!} Point',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey))
                  else
                    Text(' ${story!.score!} Points',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: const <Widget>[
                  Icon(
                    Icons.access_time_outlined,
                    color: Colors.grey,
                    size: 16,
                  ),
                  //need to do this
                  Text(
                    '  23 minutes ago',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
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
                  launchBrowser!(
                      'https://news.ycombinator.com/item?id=${story!.id}');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.comment_outlined,
                      size: 21,
                      color: Colors.grey,
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
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  color: Colors.grey,
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
                child: const Icon(
                  Icons.share_outlined,
                  size: 21,
                  color: Colors.grey,
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
