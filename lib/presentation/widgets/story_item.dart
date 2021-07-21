import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_clone/data/bloc/db/db_bloc.dart';
import 'package:hacker_news_clone/data/bloc/stories/stories_bloc.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/presentation/widgets/info_with_buttons.dart';
import 'package:hacker_news_clone/presentation/widgets/title_with_url.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatefulWidget {
  const NewsItem({Key? key, required this.item, this.counter})
      : super(key: key);

  final Story? item;
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
    final DbBloc dbBloc = BlocProvider.of<DbBloc>(context);
    final StoriesBloc bloc = BlocProvider.of<StoriesBloc>(context);
    //return
    // FutureBuilder<Story?>(
    //   future: widget.item,
    //   builder: (BuildContext context, AsyncSnapshot<Story?> snapshot) {
    //     // if (!snapshot.hasData) {
    //     //   return const LoadingContainer();
    //     // }
    //     final Story? story = snapshot.data;
    //     if (story == null) {
    //       return Container();
    //     }
    return InkWell(
      onTap: () {
        if (widget.item!.url! != null) {
          _launchBrowser(widget.item!.url!);

          //DB
          if (!widget.item!.seen!) {
            dbBloc.add(OnInsertReadStory(story: widget.item));
            dbBloc.add(OnGetStoriesFromDB());
          }
        } else {
          // IF ASK/SHOW HN
          _launchBrowser(
              'https://news.ycombinator.com/item?id=${widget.item!.id}');

          //DB
          if (!widget.item!.seen!) {
            dbBloc.add(OnInsertReadStory(story: widget.item));
            dbBloc.add(OnGetStoriesFromDB());
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 13),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TitleWithUrl(
              story: widget.item,
              //isWatched: isWatched,
            ),
            InfoWithButtons(
              counter: widget.counter,
              story: widget.item,
              launchBrowser: _launchBrowser,
              //isWatched: isWatched,
            ),
          ],
        ),
      ),
    );
    // });
  }
}
