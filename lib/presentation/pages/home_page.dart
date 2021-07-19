import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_clone/data/bloc/stories/stories_bloc.dart';
import 'package:hacker_news_clone/data/enum/hacker_news_enum.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:hacker_news_clone/presentation/widgets/story_item.dart';
//My imports
import 'package:hacker_news_clone/data/models/story.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoriesBloc>(
        create: (_) => StoriesBloc(RepositoryProvider.of<Repository>(context)),
        child: Builder(builder: (BuildContext context) {
          final StoriesBloc bloc = BlocProvider.of<StoriesBloc>(context);
          //bloc.add(OnGetTopStories());
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('HackerNews!'),
            ),
            body: _buildStoriesList(context, bloc),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.keyboard_arrow_up), label: 'Top Stories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.new_releases), label: 'New Stories')
              ],
              onTap: (int index) {
                if (index == 0) {
                  bloc.add(OnGetTopStories());
                } else {
                  bloc.add(OnGetNewStories());
                }
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          );
        }));
  }

  Widget _buildStoriesList(BuildContext context, StoriesBloc bloc) {
    return BlocConsumer<StoriesBloc, StoriesState>(
      listener: (BuildContext context, StoriesState state) {
        if (state.status == NewsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state
                  .message!))); //is not recommended to use inside bloc builder
        }
      },
      builder: (BuildContext context, StoriesState state) {
        print('News state is${state.status}');
        if (state.status == NewsStatus.initial ||
            state.status == NewsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == NewsStatus.error) {
          return Center(child: Text(state.message!));
        }
        return RefreshIndicator(
          onRefresh: () async {
            //bloc.add(OnRefresh());
            if (_currentIndex == 0) {
              bloc.add(OnGetTopStories()); //this will rebuild build function
            } else {
              bloc.add(OnGetNewStories()); //this will rebuild build function
            }
          },
          child: ListView.builder(
            itemCount: state.ids!.length,
            itemBuilder: (BuildContext context, int index) {
              //we displayed ids previously. so We can display ids with this method?
              print('Item id ${state.ids![index]} and $index');
              final Future<Story?> item =
                  bloc.getStoriesById(state.ids![index]);
              return NewsItem(
                  item:
                      item); //we provide future to NewsItem since getItemByID is future
            },
          ),
        );
      },
    );
  }

  // Widget _buildItem(Story story) {
  //   return Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: ExpansionTile(
  //         title: Text(story.title!),
  //         children: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //               Text('by ${story.by}'),
  //               IconButton(
  //                   onPressed: () async {
  //                     await canLaunch(story.url!)
  //                         ? await launch(story.url!)
  //                         : print("can't launch url");
  //                   },
  //                   icon: const Icon(Icons.launch))
  //             ],
  //           )
  //         ],
  //       ));
  // }
}
