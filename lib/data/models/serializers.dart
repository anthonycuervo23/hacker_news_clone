import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

//My imports
import 'package:hacker_news_clone/data/models/item.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[Item])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
