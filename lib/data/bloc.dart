// import 'dart:async';
// import 'dart:collection';
//
// import 'package:hacker_news_clone/data/models/story.dart';
// import 'package:http/http.dart' as http;
// import 'package:rxdart/rxdart.dart';
//
// class HackerNewsApiError extends Error {
//   HackerNewsApiError(this.message);
//
//   final String message;
// }
//
// class HackerNewsBloc {
//   HackerNewsBloc() {
//     _initializeArticles();
//
//     _storiesTypeController.stream.listen((StoriesType storiesType) async {
//       _getArticlesAndUpdate(await _getIds(storiesType));
//     });
//   }
//
//   static const String _baseUrl = 'https://hacker-news.firebaseio.com/v0/';
//
//   final BehaviorSubject<bool> _isLoadingSubject =
//       BehaviorSubject<bool>.seeded(true);
//
//   final BehaviorSubject<UnmodifiableListView<Story?>> _articlesSubject =
//       BehaviorSubject<UnmodifiableListView<Story>>();
//
//   List<Story?> _articles = <Story>[];
//
//   final StreamController<StoriesType> _storiesTypeController =
//       StreamController<StoriesType>();
//
//   Stream<UnmodifiableListView<Story?>> get articles => _articlesSubject.stream;
//
//   Stream<bool> get isLoading => _isLoadingSubject.stream;
//
//   Sink<StoriesType> get storiesType => _storiesTypeController.sink;
//
//   void close() {
//     _storiesTypeController.close();
//   }
//
//   Future<Story?> _getArticle(int id) async {
//     final String storyUrl = '${_baseUrl}item/$id.json';
//     final http.Response storyRes = await http.get(Uri.parse(storyUrl));
//     if (storyRes.statusCode == 200) {
//       return Story.fromJson(storyRes.body);
//     }
//     throw HackerNewsApiError("Article $id couldn't be fetched.");
//   }
//
//   Future<List<int>> _getIds(StoriesType type) async {
//     final String partUrl = type == StoriesType.topStories ? 'top' : 'new';
//     final String url = '$_baseUrl${partUrl}stories.json';
//     final http.Response response = await http.get(Uri.parse(url));
//     if (response.statusCode != 200) {
//       throw HackerNewsApiError("Stories $type couldn't be fetched.");
//     }
//     return Story.parseStoriesId(response.body).take(10).toList();
//   }
//
//   Future<void> _initializeArticles() async {
//     _getArticlesAndUpdate(await _getIds(StoriesType.topStories));
//   }
//
//   Future<void> _getArticlesAndUpdate(List<int> ids) async {
//     _isLoadingSubject.add(true);
//     await _updateArticles(ids);
//     _articlesSubject.add(UnmodifiableListView<Story?>(_articles));
//     _isLoadingSubject.add(false);
//   }
//
//   ///Esto es lo mismo que estoy haciendo en initState
//   Future<void> _updateArticles(List<int> articleIds) async {
//     final Iterable<Future<Story?>> futureArticles =
//         articleIds.map((int id) => _getArticle(id));
//     final List<Story?> articles = await Future.wait(futureArticles);
//     _articles = articles;
//   }
// }
//
// enum StoriesType {
//   topStories,
//   newStories,
// }
