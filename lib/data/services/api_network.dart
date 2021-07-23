import 'dart:convert';
import 'package:http/http.dart' as http;

//My imports
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/data/services/url_helper.dart';

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

  Future<List<Story?>> getMoreStories(
      String type, int count, int skipCount) async {
    final http.Response response =
        await httpClient.get(Uri.parse(UrlHelper.urlStories(type)));
    if (response.statusCode == 200) {
      final dynamic storyIds = jsonDecode(response.body);
      if (storyIds is Iterable && storyIds != null)
        return Future.wait(
            storyIds.skip(skipCount).take(count).map((dynamic storyId) {
          return getStory(storyId);
        }));
    }
    throw Exception('Nothing');
  }

  Future<List<Story?>> getComments(Story? item) async {
    List<Story?> test = <Story>[];
    if (item!.kids!.isEmpty) {
      return <Story>[];
    } else {
      final List<Story?> comments =
          await Future.wait(item.kids!.map((int id) => getStory(id)));
      final List<List<Story?>> nestedComments = await Future.wait(
          comments.map((Story? comment) => getComments(comment)));
      for (int i = 0; i < nestedComments.length; i++) {
        test = nestedComments[i];

        comments[i]!.comments!.addAll(test);
      }
      //print(comments);
      return comments;
    }
  }
}
