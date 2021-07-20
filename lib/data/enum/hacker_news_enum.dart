enum NewsStatus {
  initial,
  loading,
  loaded,
  error,
}

class ArticlePages {
  ArticlePages({this.name, this.urlType});

  final String? name;
  final String? urlType;

  List<ArticlePages> listArticlePages = <ArticlePages>[];

  List<ArticlePages> getArticlePages() {
    listArticlePages
        .add(ArticlePages(name: 'Top Stories', urlType: 'topstories'));
    listArticlePages
        .add(ArticlePages(name: 'New Stories', urlType: 'newstories'));
    listArticlePages
        .add(ArticlePages(name: 'Best Stories', urlType: 'beststories'));
    listArticlePages.add(ArticlePages(name: 'Show HN', urlType: 'showstories'));
    listArticlePages.add(ArticlePages(name: 'Ask HN', urlType: 'askstories'));
    return listArticlePages;
  }
}
