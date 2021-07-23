import 'package:flutter/material.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, this.item}) : super(key: key);

  final Story? item;

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFFFF6600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              item!.title!,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              '${item!.by} - ${item!.timeAgo} - ${item!.score}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0),
            ),
          ),
          GestureDetector(
              onTap: () {
                launchURL(item!.url!);
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    item!.url ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                  )))
        ],
      ),
    );
  }
}
