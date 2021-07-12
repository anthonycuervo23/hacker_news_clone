import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hacker_news_clone/data/models/serializers.dart';

part 'story.g.dart';

abstract class Story implements Built<Story, StoryBuilder> {
  factory Story([void Function(StoryBuilder) updates]) = _$Story;
  Story._();

  int get id;

  /// 	true if the item is deleted.
  bool? get deleted;

  /// The type of item "job", "story", "comment", "poll", or "pollopt"
  String get type;

  /// 	The username of the item's author.
  String get by;

  /// 	Creation date of the item, in Unix Time.
  int get time;

  /// 	The comment, story or poll text. HTML.
  String? get text;

  /// true if the item is dead.
  bool? get dead;

  /// The comment's parent: either another comment or the relevant story.
  int? get parent;

  /// The pollopt's associated poll.
  int? get poll;

  /// The ids of the item's comments, in ranked display order.
  BuiltList<int>? get kids;

  /// The URL of the story.
  String? get url;

  /// 	The story's score, or the votes for a pollopt.
  int? get score;

  /// 	The title of the story, poll or job. HTML.
  String? get title;

  /// 	A list of related pollopts, in display order.
  BuiltList<int>? get parts;

  /// In the case of stories or polls, the total comment count.
  int? get descendants;

  // Map<String, dynamic> toJson() {
  //   return serializers.serializeWith(Story.serializer, this);
  // }

  static Story? fromJson(String jsonStr) {
    final dynamic parsed = json.decode(jsonStr);
    return serializers.deserializeWith(Story.serializer, parsed);
  }

  static Serializer<Story> get serializer => _$storySerializer;
}
