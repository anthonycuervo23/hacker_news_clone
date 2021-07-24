import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

//My imports
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentRow extends StatelessWidget {
  const CommentRow({Key? key, this.item}) : super(key: key);
  final Story? item;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    children.add(
      CommentItem(
        key: Key('${item!.id}'),
        item: item,
      ),
    );
    //item.comments is the list with all the nested comments
    if (item!.comments!.isNotEmpty) {
      final List<Widget> comments = item!.comments!
          .map(
            (Story? item) => CommentRow(
              item: item,
              key: Key('${item!.id}'),
            ),
          )
          .toList();
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Container(
                  width: 15.0,
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
                ),
                Flexible(child: Column(children: comments)),
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: children);
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, this.item}) : super(key: key);
  final Story? item;

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Text(
                    item!.by != null ? item!.by! : 'unknown',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 17.0),
                  ),
                ),
                Text(
                  item!.timeAgo,
                  style: TextStyle(
                      color: Theme.of(context).accentColor.withOpacity(0.9),
                      fontWeight: FontWeight.w700,
                      fontSize: 17.0),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 6.0),
              child: Html(
                  data: item!.text != null
                      ? item!.text!
                      : '(This comment was deleted)',
                  onLinkTap: (String? url, RenderContext context, _, __) {
                    launchURL(url!);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
