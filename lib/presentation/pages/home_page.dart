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
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoriesBloc>(create: (_) {
      final StoriesBloc bloc =
          StoriesBloc(RepositoryProvider.of<Repository>(context));
      bloc.add(OnGetTopStories());
      return bloc;
    }, child: Builder(builder: (BuildContext context) {
      final StoriesBloc bloc = BlocProvider.of<StoriesBloc>(context);
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
            // if is first time => we fetch
            // if is not => we do nothing
            //
            if (index == _currentIndex || _isFetched) {
              return;
            }
            if (index == 0) {
              bloc.add(OnGetTopStories());
            } else {
              bloc.add(OnGetNewStories());
            }
            _isFetched = true;
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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
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
            if (_currentIndex == 0) {
              bloc.add(OnGetTopStories()); //this will rebuild build function
            } else {
              bloc.add(OnGetNewStories()); //this will rebuild build function
            }
          },
          child: ListView.builder(
            itemCount: state.ids!.length,
            itemBuilder: (BuildContext context, int index) {
              print('Item id ${state.ids![index]} and $index');
              final Future<Story?> item =
                  bloc.getStoriesById(state.ids![index]);
              return NewsItem(item: item);
            },
          ),
        );
      },
    );
  }
}
