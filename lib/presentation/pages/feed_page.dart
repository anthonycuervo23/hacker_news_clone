import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

//My imports
import 'package:hacker_news_clone/presentation/pages/settings_page.dart';
import 'package:hacker_news_clone/presentation/widgets/item/item_container.dart';
import 'package:hacker_news_clone/data/bloc/db/db_bloc.dart';
import 'package:hacker_news_clone/data/bloc/item/item_bloc.dart';
import 'package:hacker_news_clone/data/db/watched_items.dart';
import 'package:hacker_news_clone/data/utils/hacker_news_enum.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:hacker_news_clone/presentation/widgets/item/loading_container.dart';
import 'package:hacker_news_clone/data/models/item.dart';

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

  void openBottomSheet(ItemBloc bloc) {
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
                              bloc.state.itemsName) {
                            return;
                          }
                          Navigator.of(context).pop();
                          bloc.add(OnSelectedTab(
                              type: listArticlePages[index].urlType,
                              itemsName: listArticlePages[index].name));
                          bloc.add(OnGetItems());
                        },
                        leading: Icon(
                          Icons.article_outlined,
                          color: listArticlePages[index]
                                  .name!
                                  .compareTo(bloc.state.itemsName)
                                  .isEven
                              ? Theme.of(context).accentColor.withOpacity(0.9)
                              : Theme.of(context).hintColor,
                        ),
                        title: Text(
                          listArticlePages[index].name!,
                          style: TextStyle(
                              color: listArticlePages[index]
                                      .name!
                                      .compareTo(bloc.state.itemsName)
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
                              .compareTo(bloc.state.itemsName)
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
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ItemBloc>(
          create: (_) {
            final ItemBloc bloc =
                ItemBloc(RepositoryProvider.of<Repository>(context));
            bloc.add(OnGetItems());
            return bloc;
          },
        ),
        BlocProvider<DbBloc>(
          create: (_) {
            final DbBloc bloc = DbBloc(MyDatabase());
            bloc.add(OnGetItemsFromDB());
            return bloc;
          },
        )
      ],
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (BuildContext context, ItemState itemState) {
          final ItemBloc itemBloc = BlocProvider.of<ItemBloc>(context);
          return BlocBuilder<DbBloc, DbState>(
              builder: (BuildContext context, DbState dbState) {
            final DbBloc dbBloc = BlocProvider.of<DbBloc>(context);

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
                        text: itemState.itemsName,
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
              body: _buildItemsList(context, itemBloc, dbBloc),
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
                          dbBloc.add(OnGetItemsFromDB());
                          itemBloc.add(OnGetItems());
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
                          openBottomSheet(itemBloc);
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
                          Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (_) => const SettingsPage()));
                          //ADD AN OPTION TO CHANGE THE THEME OF THE APP
                        }),
                  ],
                ),
              )),
            );
          });
        },
      ),
    );
  }

  Widget _buildItemsList(BuildContext context, ItemBloc bloc, DbBloc dbBloc) {
    return BlocConsumer<ItemBloc, ItemState>(
      listener: (BuildContext context, ItemState state) {
        if (state.status == NewsStatus.error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      builder: (BuildContext context, ItemState state) {
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
                  onEndOfPage: () => bloc.add(OnGetMoreItems()),
                  isLoading: state.loadItemsOnScroll,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      bloc.add(OnGetItems());
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            //print('Item id ${state.items[index]} and $index');
                            final Item item = Item((ItemBuilder b) => b
                              ..id = state.items[index]!.id
                              ..title = state.items[index]!.title
                              ..deleted = state.items[index]!.deleted
                              ..kids.update((ListBuilder<int> b) =>
                                  b..addAll(state.items[index]!.kids!))
                              ..url = state.items[index]!.url
                              ..score = state.items[index]!.score
                              ..descendants = state.items[index]!.descendants
                              ..time = state.items[index]!.time
                              ..type = state.items[index]!.type
                              ..by = state.items[index]!.by
                              ..seen = dbBloc.state.listIdsRead!
                                      .contains(state.items[index]!.id) ||
                                  false);
                            return NewsItem(
                                key: UniqueKey(), item: item, counter: index);
                          },
                        ),
                        Visibility(
                          visible: state.loadItemsOnScroll,
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
