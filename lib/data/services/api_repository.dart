import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/data/services/api_network.dart';
import 'package:http/http.dart' as http;

class Repository {
  final ApiNetworkHelper apiNetworkHelper = ApiNetworkHelper(http.Client());

  Future<Story?> fetchStory(int id) async {
    final Story? story = await apiNetworkHelper.getStory(id);
    if (story != null) {
      return story;
    }
  }

  Future<List<Story?>> getStories(String type, int count) async {
    return apiNetworkHelper.getStories(type, count);
  }
}
