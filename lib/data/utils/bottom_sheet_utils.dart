import 'package:flutter/material.dart';
import 'package:hacker_news_clone/data/bloc/item/item_bloc.dart';
import 'package:hacker_news_clone/data/utils/hacker_news_enum.dart';

void openBottomSheet(BuildContext context, Widget content) {
  showModalBottomSheet<Widget>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => content);
}

void openFeedPageBottomSheet(
    {required BuildContext context,
    required List<ArticlePages> listArticlePages,
    required ItemBloc bloc}) {
  openBottomSheet(
      context,
      Wrap(children: <Widget>[
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
                              ? Theme.of(context).accentColor.withOpacity(0.9)
                              : Theme.of(context).textTheme.headline6!.color,
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
      ]));
}
