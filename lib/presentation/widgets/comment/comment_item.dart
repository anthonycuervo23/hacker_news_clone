import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news_clone/data/models/story.dart';

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
    //esto esta vacio y por eso no agrega los comentarios hijos
    if (item!.comments!.isNotEmpty) {
      final List<Widget> comments = item!.comments!
          .map(
            (Story? item) => CommentRow(
              item: item,
              key: Key('${item!.id}'),
            ),
          )
          .toList();
      //print(comments);
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Container(
                  width: 15.0,
                  color: const Color(0xFFFF6600),
                ),
                Column(children: comments),
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
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
                  Container(
                    child: Text(
                      // timeago.format(date),
                      item!.timeAgo,
                      style: const TextStyle(
                          color: Color(0xFFFF6600),
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 6.0),
              child: Html(
                data: item!.text != null
                    ? item!.text!
                    : '(This comment was deleted)',
                // style: const TextStyle(
                //     fontWeight: FontWeight.w300, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
