import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_clone/data/bloc/db/db_bloc.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/presentation/widgets/info_with_buttons.dart';
import 'package:hacker_news_clone/presentation/widgets/title_with_url.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatefulWidget {
  const NewsItem({Key? key, required this.item, this.counter})
      : super(key: key);

  final Future<Story?> item;
  final int? counter;
  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  //URL LAUNCHER
  Future<void> _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Story?>(
        future: widget.item,
        builder: (BuildContext context, AsyncSnapshot<Story?> snapshot) {
          // if (!snapshot.hasData) {
          //   return const LoadingContainer();
          // }
          final Story? story = snapshot.data;
          if (story == null) {
            return Container();
          }
          return InkWell(
            onTap: () {
              if (story.url! != null) {
                _launchBrowser(story.url!);
                BlocProvider.of<DbBloc>(context)
                    .add(OnInsertReadStory(story: story));
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 13),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TitleWithUrl(
                    story: story,
                  ),
                  InfoWithButtons(
                      counter: widget.counter,
                      story: story,
                      launchBrowser: _launchBrowser)
                ],
              ),
            ),
          );
        });
  }
}
