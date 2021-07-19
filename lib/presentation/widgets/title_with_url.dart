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
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: story!.url! != null,
            child: Text(formattedUrl,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Colors.deepOrangeAccent,
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
