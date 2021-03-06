import 'dart:convert';
import 'package:http/http.dart' as http;

//My imports
import 'package:hacker_news_clone/data/models/item.dart';
import 'package:hacker_news_clone/data/services/url_helper.dart';

class ApiNetworkHelper {
  ApiNetworkHelper(this.httpClient);

  final http.Client httpClient;

  //We get one story or comment
  Future<Item?> getItem(dynamic id) async {
    final http.Response response =
        await httpClient.get(Uri.parse(UrlHelper.urlForItem(id)));

    if (response.statusCode == 200) {
      return Item.fromJson(response.body);
    } else {
      return null;
    }
  }

  // we get a list of stories ids from the selected type (top, best, news...)
  Future<List<Item?>> getItems(String type, int count) async {
    final http.Response response =
        await httpClient.get(Uri.parse(UrlHelper.urlItems(type)));
    if (response.statusCode == 200) {
      final dynamic itemsIds = jsonDecode(response.body);
      if (itemsIds is Iterable && itemsIds != null)
        //we take just a certain amount of stories to retrieve
        return Future.wait(itemsIds.take(count).map((dynamic itemId) {
          return getItem(itemId);
        }));
    }
    throw Exception('Nothing');
  }

  // after scroll to bottom we fetch more stories
  Future<List<Item?>> getMoreItems(
      String type, int count, int skipCount) async {
    final http.Response response =
        await httpClient.get(Uri.parse(UrlHelper.urlItems(type)));
    if (response.statusCode == 200) {
      final dynamic itemIds = jsonDecode(response.body);
      if (itemIds is Iterable && itemIds != null)
        //we skip the current length of stories and take a new amount of stories
        return Future.wait(
            itemIds.skip(skipCount).take(count).map((dynamic itemId) {
          return getItem(itemId);
        }));
    }
    throw Exception('Nothing');
  }

  // to get all the comments for a single story
  Future<List<Item?>> getComments(Item? item) async {
    List<Item?> nestedCommentsList = <Item>[];
    if (item!.kids!.isEmpty) {
      return <Item>[];
    } else {
      //first we get the parent comments
      final List<Item?> comments =
          await Future.wait(item.kids!.map((int id) => getItem(id)));
      //then we get the comments inside parent comments and if there are
      // more comments nested we call again getComments()
      final List<List<Item?>> nestedComments = await Future.wait(
          comments.map((Item? comment) => getComments(comment)));
      for (int i = 0; i < nestedComments.length; i++) {
        //we save all the nested comments in the list of comments that we have
        //inside each principal comment.
        nestedCommentsList = nestedComments[i];
        comments[i]!.comments!.addAll(nestedCommentsList);
      }
      return comments;
    }
  }
}
