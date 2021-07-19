import 'package:hacker_news_clone/data/enum/hacker_news_enum.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/data/services/api_network.dart';
import 'package:http/http.dart' as http;

class Repository {
  final ApiNetworkHelper apiNetworkHelper = ApiNetworkHelper(http.Client());

  Future<List<int>> fetchBestIDs(StoriesType? type) async {
    //return apiNetworkHelper.getBestStories();
    return apiNetworkHelper.getIds(type);
  }

  Future<Story?> fetchStory(int id) async {
    final Story? story = await apiNetworkHelper.getStory(id);
    if (story != null) {
      return story;
    }
  }
}
