import 'package:flutter/material.dart';

//My imports
import 'package:hacker_news_clone/data/models/article.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Article> _articles = articles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Hacker News Clone'),
        ),
        body: ListView(
          children: _articles.map(_buildItem).toList(),
        ));
  }

  Widget _buildItem(Article article) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExpansionTile(
          title: Text(article.title),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('${article.score} points | '),
                Text('by ${article.by} | '),
                Text('${article.age} ago | '),
                Text('${article.commentsCount} comments'),
              ],
            )
          ],
        ));
  }
}
