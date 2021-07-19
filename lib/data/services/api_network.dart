import 'package:hacker_news_clone/data/enum/hacker_news_enum.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:http/http.dart' as http;

class ApiNetworkHelper {
  ApiNetworkHelper(this.httpClient);

  final http.Client httpClient;

  static const String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

  Future<Story?> getStory(int id) async {
    final String url = '$_baseUrl/item/$id.json';
    final http.Response response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Story.fromJson(response.body);
    } else {
      return null;
    }
  }

  // Future<List<int>> getBestStories() async {
  //   const String url = 'https://hacker-news.firebaseio.com/v0/beststories.json';
  //   final http.Response response = await httpClient.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     return Story.parseStoriesId(response.body);
  //   }
  //   return <int>[];
  // }

  Future<List<int>> getIds(StoriesType? type) async {
    final String partUrl =
        type == StoriesType.topStories ? 'topstories' : 'newstories';
    final String url = '$_baseUrl/$partUrl.json';
    final http.Response response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Story.parseStoriesId(response.body);
    }
    return <int>[];
  }
}
