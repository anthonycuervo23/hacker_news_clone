import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({Key? key}) : super(key: key);
  Future<void> _launchGithub() async {
    const String url = 'https://github.com/anthonycuervo23/hacker_news_clone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Info'),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.green,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/coco_image.JPG'),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text('HackerNews Reader v1.0.0',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor)),
          ),
          const SizedBox(height: 15),
          const Divider(),
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text('About'.toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor)),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              'Application created using Flutter and Dart language.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text('Source Code'.toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor)),
          ),
          ListTile(
            onTap: () {
              _launchGithub();
            },
            leading: const Icon(Icons.open_in_new_outlined),
            title: const Text('View on GitHub',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
