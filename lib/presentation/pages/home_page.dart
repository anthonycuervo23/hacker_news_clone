import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_clone/data/bloc/db/db_bloc.dart';
import 'package:hacker_news_clone/data/bloc/stories/stories_bloc.dart';
import 'package:hacker_news_clone/data/db/watched_stories.dart';
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
  String? pageName;
  List<ArticlePages> listArticlePages = ArticlePages().getArticlePages();

  @override
  void initState() {
    super.initState();
  }

  void openBottomSheet(StoriesBloc bloc) {
    showModalBottomSheet<Widget>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Column(
                children: <Widget>[
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
                          if (listArticlePages[index].name! ==
                              bloc.state.storiesName) {
                            return;
                          }
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoriesBloc>(
          create: (_) {
            final StoriesBloc bloc =
                StoriesBloc(RepositoryProvider.of<Repository>(context));
            bloc.add(OnGetStories());
            return bloc;
          },
        ),
        BlocProvider<DbBloc>(
          create: (_) {
            final DbBloc bloc = DbBloc(MyDatabase());
            bloc.add(OnGetStoriesFromDB());
            return bloc;
          },
        )
      ],
      child: BlocBuilder<StoriesBloc, StoriesState>(
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
            bottomNavigationBar: BottomAppBar(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                        // setState(() {});
                        BlocProvider.of<DbBloc>(context)
                            .add(OnGetStoriesFromDB());
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
                        // TODO(jean): add change theme color and other options.
                      }),
                ],
              ),
            )),
          );
        },
      ),
    );
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
        if (state.status == NewsStatus.error) {
          return Center(
            child: Text(state.message!),
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: state.status == NewsStatus.initial ||
                  state.status == NewsStatus.loading
              ? LoadingContainer(
                  key: UniqueKey(),
                )
              : LazyLoadScrollView(
                  onEndOfPage: () => bloc.add(OnGetMoreStories()),
                  isLoading: state.loadStoriesOnScroll,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      bloc.add(OnGetStories());
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.stories!.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(
                                'Item id ${state.stories![index]} and $index');
                            final Future<Story?> item =
                                bloc.getStoriesById(state.stories![index]!.id);
                            return NewsItem(
                                key: UniqueKey(),
                                item: Story((StoryBuilder b) => b
                                  ..id = state.stories![index]!.id
                                  ..title = state.stories![index]!.title
                                  ..url = state.stories![index]!.url
                                  ..score = state.stories![index]!.score
                                  ..descendants =
                                      state.stories![index]!.descendants
                                  ..time = state.stories![index]!.time
                                  ..type = state.stories![index]!.type
                                  ..by = state.stories![index]!.by
                                  ..seen = BlocProvider.of<DbBloc>(context)
                                          .state
                                          .listIdsRead!
                                          .contains(
                                              state.stories![index]!.id) ||
                                      false),
                                counter: index);
                          },
                        ),
                        Visibility(
                          visible: state.loadStoriesOnScroll,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: PreferredSize(
                              preferredSize: const Size.fromHeight(2),
                              child: LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.8)),
                                backgroundColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
