import 'package:hacker_news_clone/data/models/story.dart';
import 'package:http/http.dart' as http;

class ApiNetworkHelper {
  Future<Story?> getStory(http.Client client, int id) async {
    final String url = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final http.Response response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Story.fromJson(response.body);
    } else {
      throw Exception('Failed to load stories...');
    }
  }
}
