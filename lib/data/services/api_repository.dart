import 'package:http/http.dart' as http;

//My imports
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/data/services/api_network.dart';

class Repository {
  //we use the Repository as a bridge to communicate between the ApiNetwork and the BloC
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

  Future<List<Story?>> getMoreStories(
      String type, int count, int skipCount) async {
    return apiNetworkHelper.getMoreStories(type, count, skipCount);
  }
}
