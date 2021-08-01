import 'package:flutter/material.dart';

//My imports
import 'package:hacker_news_clone/data/models/item.dart';

class TitleWithUrl extends StatelessWidget {
  const TitleWithUrl({Key? key, this.item}) : super(key: key);

  final Item? item;
  @override
  Widget build(BuildContext context) {
    String formattedUrl = ' ';

    if (item!.url != null) {
      formattedUrl = Uri.parse(item!.url!).host;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(13, 14, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(item!.title!,
              style: TextStyle(
                fontSize: 20,
                color: item!.seen!
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).textTheme.headline6!.color!,
              )),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: item!.url != null,
            child: Text(formattedUrl,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12.5,
                  color: item!.seen!
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
