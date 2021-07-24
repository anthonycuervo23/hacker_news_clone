import 'package:http/http.dart' as http;

//My imports
import 'package:hacker_news_clone/data/models/item.dart';
import 'package:hacker_news_clone/data/services/api_network.dart';

class Repository {
  //we use the Repository as a bridge to communicate between the ApiNetwork and the BloC
  final ApiNetworkHelper apiNetworkHelper = ApiNetworkHelper(http.Client());

  Future<Item?> fetchItem(int id) async {
    final Item? story = await apiNetworkHelper.getItem(id);
    if (story != null) {
      return story;
    }
  }

  Future<List<Item?>> getStories(String type, int count) async {
    return apiNetworkHelper.getStories(type, count);
  }

  Future<List<Item?>> getMoreStories(
      String type, int count, int skipCount) async {
    return apiNetworkHelper.getMoreStories(type, count, skipCount);
  }

  Future<List<Item?>> getComments(Item? item) async {
    return apiNetworkHelper.getComments(item);
  }
}
