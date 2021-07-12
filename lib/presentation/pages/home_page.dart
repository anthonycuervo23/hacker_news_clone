import 'package:flutter/material.dart';
import 'package:hacker_news_clone/data/services/api_network.dart';
import 'package:http/http.dart' as http;
//My imports
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<int> _ids = <int>[
    9129911,
    9129199,
    9127761,
    9128141,
    9128264,
    9127792,
    9129248,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Hacker News Clone'),
        ),
        body: ListView(
          children: _ids
              .map((int i) => FutureBuilder<Story?>(
                    future: ApiNetworkHelper().getStory(http.Client(), i),
                    builder:
                        (BuildContext context, AsyncSnapshot<Story?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return _buildItem(snapshot.data!);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ))
              .toList(),
        ));
  }

  Widget _buildItem(Story story) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExpansionTile(
          title: Text(story.title!),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('by ${story.by}'),
                IconButton(
                    onPressed: () async {
                      await canLaunch(story.url!)
                          ? await launch(story.url!)
                          : print("can't launch url");
                    },
                    icon: const Icon(Icons.launch))
              ],
            )
          ],
        ));
  }
}
