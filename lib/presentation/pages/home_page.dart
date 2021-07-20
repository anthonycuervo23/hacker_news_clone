import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_clone/data/bloc/stories/stories_bloc.dart';
import 'package:hacker_news_clone/data/enum/hacker_news_enum.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:hacker_news_clone/presentation/widgets/loading_container.dart';
import 'package:hacker_news_clone/presentation/widgets/story_item.dart';
//My imports
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  bool _isFetched = false;
  String? pageName;
  List<ArticlePages> listArticlePages = ArticlePages().getArticlePages();

  void openBottomSheet(StoriesBloc bloc) {
    // final StoriesBloc bloc = BlocProvider.of<StoriesBloc>(context);
    showModalBottomSheet<Widget>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Column(
                children: [
                  Center(
                    child: ListTile(
                      title: const Text(
                        'Hacker News Reader', //
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                      subtitle: Text(
                        'news.ycombinator.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, color: Theme.of(context).hintColor),
                      ),
                    ),
                  ),
                  const Divider(),
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listArticlePages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          bloc.add(OnSelectedTab(
                              type: listArticlePages[index].urlType,
                              storiesName: listArticlePages[index].name));
                          bloc.add(OnGetStories());
                        },
                        leading: Icon(
                          Icons.article_outlined,
                          color: listArticlePages[index]
                                  .name!
                                  .compareTo(bloc.state.storiesName)
                                  .isEven
                              ? Theme.of(context).accentColor.withOpacity(0.9)
                              : Theme.of(context).hintColor,
                        ),
                        title: Text(
                          listArticlePages[index].name!,
                          style: TextStyle(
                              color: listArticlePages[index]
                                      .name!
                                      .compareTo(bloc.state.storiesName)
                                      .isEven
                                  ? Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.9)
                                  : Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .color,
                              fontSize: 17),
                        ),
                        trailing: Visibility(
                          visible: listArticlePages[index]
                              .name!
                              .compareTo(bloc.state.storiesName)
                              .isOdd,
                          child: Icon(Icons.keyboard_arrow_right,
                              color: Theme.of(context).hintColor),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoriesBloc>(create: (_) {
      final StoriesBloc bloc =
          StoriesBloc(RepositoryProvider.of<Repository>(context));
      bloc.add(OnGetStories());
      return bloc;
    }, child: BlocBuilder<StoriesBloc, StoriesState>(
        builder: (BuildContext context, StoriesState state) {
      final StoriesBloc bloc = BlocProvider.of<StoriesBloc>(context);
      return Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'HN  ',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.9),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: state.storiesName,
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          elevation: 0,
        ),
        body: _buildStoriesList(context, bloc),
        // AnimatedSwitcher(
        //   duration: const Duration(milliseconds: 600),
        //   child:
        //       // state.loading
        //       //     ?
        //       //     LoadingContainer(
        //       //   key: UniqueKey(),
        //       //   pageName: state.storiesName,
        //       // )
        //       // :
        //       LazyLoadScrollView(
        //     onEndOfPage: () => _getMoreStoriesScrolling(),
        //     isLoading: loadStoriesOnScroll,
        //     child: RefreshIndicator(
        //       onRefresh: _getStoriesOnStartup,
        //       color: Theme.of(context).accentColor,
        //       child: ListView(
        //         physics: AlwaysScrollableScrollPhysics(),
        //         children: [
        //           ListView.separated(
        //             separatorBuilder: (BuildContext context, int index) =>
        //                 const Divider(),
        //             physics: NeverScrollableScrollPhysics(),
        //             shrinkWrap: true,
        //             itemCount: _stories.length,
        //             itemBuilder: (context, index) {
        //               return ContainerStory(
        //                   key: UniqueKey(),
        //                   contador: index,
        //                   refreshIdLidos: refreshIdLidos,
        //                   story: new Story(
        //                     storyId: _stories[index].storyId,
        //                     title: _stories[index].title,
        //                     url: _stories[index].url,
        //                     score: _stories[index].score,
        //                     commentsCount: _stories[index].commentsCount == null
        //                         ? 0
        //                         : _stories[index].commentsCount,
        //                     time: _stories[index].time,
        //                     lido: listIdsRead.contains(_stories[index].storyId)
        //                         ? true
        //                         : false,
        //                   ));
        //             },
        //           ),
        //           Visibility(
        //               visible: loadStoriesOnScroll,
        //               child: Align(
        //                 alignment: Alignment.bottomCenter,
        //                 child: PreferredSize(
        //                   preferredSize: Size.fromHeight(2),
        //                   child: LinearProgressIndicator(
        //                     valueColor: new AlwaysStoppedAnimation<Color>(
        //                         Theme.of(context).accentColor.withOpacity(0.8)),
        //                     backgroundColor:
        //                         Theme.of(context).accentColor.withOpacity(0.3),
        //                   ),
        //                 ),
        //               ))
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        //_buildStoriesList(context, bloc),
        bottomNavigationBar: BottomAppBar(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.refresh_outlined,
                    color: Theme.of(context)
                        .textTheme
                        .headline6!
                        .color!
                        .withOpacity(0.8),
                  ),
                  onPressed: () {
                    //START ANIMATION
                    setState(() {
                      // loading = true;
                    });

                    bloc.add(OnGetStories());
                  }),
              IconButton(
                  icon: Icon(
                    Icons.menu_outlined,
                    color: Theme.of(context)
                        .textTheme
                        .headline6!
                        .color!
                        .withOpacity(0.8),
                  ),
                  onPressed: () {
                    openBottomSheet(bloc);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Theme.of(context)
                        .textTheme
                        .headline6!
                        .color!
                        .withOpacity(0.8),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute<void>(
                    //       builder: (BuildContext context) => SettingsPage(),
                    //       fullscreenDialog: true,
                    //     ));
                  }),
            ],
          ),
        )),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _currentIndex,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.keyboard_arrow_up), label: 'Top Stories'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.new_releases), label: 'New Stories')
        //   ],
        //   onTap: (int index) {
        //     // if is first time => we fetch
        //     // if is not => we do nothing
        //     //
        //     if (index == _currentIndex) {
        //       return;
        //     }
        //     if (index == 0) {
        //       bloc.add(OnSelectedTab(
        //           type: listArticlePages[0].urlType,
        //           storiesName: listArticlePages[0].name));
        //       bloc.add(OnGetStories());
        //     } else {
        //       bloc.add(OnSelectedTab(
        //           type: listArticlePages[1].urlType,
        //           storiesName: listArticlePages[1].name));
        //       bloc.add(OnGetStories());
        //       //bloc.add(OnGetStoriesScrolling());
        //     }
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        // ),
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
              //bloc.add(OnGetTopStories()); //this will rebuild build function
            } else {
              //bloc.add(OnGetNewStories()); //this will rebuild build function
            }
          },
          child: ListView.builder(
            itemCount: state.stories!.length,
            itemBuilder: (BuildContext context, int index) {
              print('Item id ${state.stories![index]} and $index');
              final Future<Story?> item =
                  bloc.getStoriesById(state.stories![index]!.id);
              return NewsItem(item: item);
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
