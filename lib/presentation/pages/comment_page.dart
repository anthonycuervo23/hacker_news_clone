import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//My imports
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/data/services/api_network.dart';
import 'package:hacker_news_clone/presentation/widgets/comment/comment_item.dart';
import 'package:hacker_news_clone/presentation/widgets/comment/header.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, this.item}) : super(key: key);
  final Story? item;

  @override
  State<StatefulWidget> createState() {
    return _CommentPageState();
  }
}

class _CommentPageState extends State<CommentPage> {
  ApiNetworkHelper apiNetworkHelper = ApiNetworkHelper(http.Client());
  Map<int, Story> comments = <int, Story>{};

  Future<Story> getItemWithComments(int id) async {
    List<Story?> test = <Story>[];
    //here we get the parent comment
    final Story? item = await apiNetworkHelper.getStory(id);
    //and then we get all the comments nested in the parent comment
    //and save then in a list
    test = await apiNetworkHelper.getComments(item);
    item!.comments!.addAll(test);
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments (${widget.item!.descendants})'),
      ),
      body: (widget.item!.kids!.isEmpty)
          ? ListView(
              children: <Widget>[
                HeaderWidget(item: widget.item),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  child: const Center(
                    child: Text('There are no comments available',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17.0)),
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: 1 + widget.item!.kids!.length,
              itemBuilder: (BuildContext context, int position) {
                if (position == 0) {
                  return HeaderWidget(item: widget.item);
                }

                return FutureBuilder<Story>(
                    //here we get the parent comment with all the nested comments and because we are
                    //inside ListView.builder we do the same for all the parent comments inside the story
                    future:
                        getItemWithComments(widget.item!.kids![position - 1]),
                    builder:
                        (BuildContext context, AsyncSnapshot<Story> snapshot) {
                      if (comments[position - 1] != null) {
                        final Story? item = comments[position - 1];
                        return CommentRow(
                          item: item,
                          key: Key(item!.id.toString()),
                        );
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        final Story? item = snapshot.data;
                        comments[position - 1] = item!;
                        return CommentRow(
                            item: item, key: Key(item.id.toString()));
                      } else if (snapshot.hasError) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: Text('${snapshot.error}')),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(32.0),
                          child: const Center(
                            child: CupertinoActivityIndicator(
                              animating: true,
                            ),
                          ),
                        );
                      }
                    });
              },
            ),
    );
  }
}
