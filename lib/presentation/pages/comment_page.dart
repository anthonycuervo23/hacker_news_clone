import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//My imports
import 'package:hacker_news_clone/data/bloc/comment/comment_bloc.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:hacker_news_clone/data/models/item.dart';
import 'package:hacker_news_clone/presentation/widgets/comment/comment_item.dart';
import 'package:hacker_news_clone/presentation/widgets/comment/header.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, this.item}) : super(key: key);
  final Item? item;

  @override
  State<StatefulWidget> createState() {
    return _CommentPageState();
  }
}

class _CommentPageState extends State<CommentPage> {
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
          : BlocProvider<CommentBloc>(
              create: (BuildContext context) =>
                  CommentBloc(RepositoryProvider.of<Repository>(context)),
              child: ListView.builder(
                itemCount: 1 + widget.item!.kids!.length,
                itemBuilder: (BuildContext context, int position) {
                  if (position == 0) {
                    return HeaderWidget(item: widget.item);
                  }

                  return FutureBuilder<Item>(
                      //here we get the parent comment with all the nested comments and because we are
                      //inside ListView.builder we do the same for all the parent comments inside the story
                      future: BlocProvider.of<CommentBloc>(context)
                          .getItemWithComments(
                              widget.item!.kids![position - 1]),
                      builder:
                          (BuildContext context, AsyncSnapshot<Item> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final Item? item = snapshot.data;
                          return CommentRow(
                              item: item, key: Key(item!.id.toString()));
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
            ),
    );
  }
}
