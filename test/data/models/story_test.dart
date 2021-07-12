import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockingHttp extends Mock implements http.Client {}

void main() {
  test('parses a story', () {
    const String jsonString =
        """{"by":"dhouston","descendants":71,"id":8863,"kids":[9224,8917,8952,8958,8884,8887,8869,8940,8908,9005,8873,9671,9067,9055,8865,8881,8872,8955,10403,8903,8928,9125,8998,8901,8902,8907,8894,8870,8878,8980,8934,8943,8876],"score":104,"time":1175714200,"title":"My YC app: Dropbox - Throw away your USB drive","type":"story","url":"http://www.getdropbox.com/u/2/screencast.html"}""";
    expect(Story.fromJson(jsonString)!.by, 'dhouston');
    expect(Story.fromJson(jsonString)!.id, 8863);
  });

  // test('parses a story from API', () async {
  //   const String jsonString =
  //       """{"by":"dhouston","descendants":71,"id":8863,"kids":[9224,8917,8952,8958,8884,8887,8869,8940,8908,9005,8873,9671,9067,9055,8865,8881,8872,8955,10403,8903,8928,9125,8998,8901,8902,8907,8894,8870,8878,8980,8934,8943,8876],"score":104,"time":1175714200,"title":"My YC app: Dropbox - Throw away your USB drive","type":"story","url":"http://www.getdropbox.com/u/2/screencast.html"}""";
  //   final http.Client mockingHttp = MockingHttp();
  //   const String url = 'https://hacker-news.firebaseio.com/v0/item/8863.json';
  //   when(mockingHttp.get(Uri.parse(url)))
  //       .thenAnswer((Invocation value) async => http.Response(jsonString, 200));
  //   expect(Story.fromJson(jsonString)!.by, 'dhouston');
  //   expect(Story.fromJson(jsonString)!.id, 8863);
  // });
}
