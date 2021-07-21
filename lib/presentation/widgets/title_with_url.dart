import 'package:flutter/material.dart';
import 'package:hacker_news_clone/data/models/story.dart';

class TitleWithUrl extends StatelessWidget {
  const TitleWithUrl({Key? key, this.story}) : super(key: key);

  final Story? story;
  @override
  Widget build(BuildContext context) {
    String formattedUrl = ' ';

    if (story!.url != null) {
      formattedUrl = Uri.parse(story!.url!).host;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(13, 14, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(story!.title!,
              style: TextStyle(
                fontSize: 20,
                color: story!.seen!
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).textTheme.headline6!.color!,
              )),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: story!.url != null,
            child: Text(formattedUrl,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12.5,
                  color: story!.seen!
                      ? Theme.of(context).accentColor.withOpacity(0.3)
                      : Theme.of(context).accentColor.withOpacity(0.9),
                )),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
