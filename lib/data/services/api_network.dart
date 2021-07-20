import 'dart:convert';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/data/services/url_helper.dart';
import 'package:http/http.dart' as http;

class ApiNetworkHelper {
  ApiNetworkHelper(this.httpClient);

  final http.Client httpClient;

  Future<Story?> getStory(dynamic id) async {
    final http.Response response =
        await httpClient.get(Uri.parse(UrlHelper.urlForStory(id)));

    if (response.statusCode == 200) {
      return Story.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Story?>> getStories(String type, int count) async {
    final http.Response response =
        await httpClient.get(Uri.parse(UrlHelper.urlStories(type)));
    if (response.statusCode == 200) {
      final dynamic storyIds = jsonDecode(response.body);
      if (storyIds is Iterable && storyIds != null)
        return Future.wait(storyIds.take(count).map((dynamic storyId) {
          return getStory(storyId);
        }));
    }
    throw Exception('Nothing');
  }
}
