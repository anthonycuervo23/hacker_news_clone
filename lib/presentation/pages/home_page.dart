import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//My imports
import 'package:hacker_news_clone/data/services/api_network.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> _ids = <int>[];
  List<Story?> _stories = <Story>[];

  @override
  void initState() {
    ApiNetworkHelper()
        .getBestStories(http.Client())
        .then((List<int> value) async {
      List<Story?> listOfStories = await Future.wait(_ids.map((int id) {
        return ApiNetworkHelper().getStory(http.Client(), id);
      }).toList());
      setState(() {
        _ids = value;
        _stories = listOfStories;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Story> bestStories = <Story>[];
    _stories.forEach((Story? story) {
      if (story != null) {
        bestStories.add(story);
      }
    });
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Hacker News Clone'),
        ),
        body: bestStories.isNotEmpty
            ? ListView(
                children: bestStories
                    .map((Story story) => _buildItem(story))
                    .toList())
            : Center(child: const CircularProgressIndicator()));
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
