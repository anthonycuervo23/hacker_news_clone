import 'package:flutter_test/flutter_test.dart';

import 'package:hacker_news_clone/main.dart';

void main() {
  testWidgets('check text is render', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('This is a Hacker News Clone app'), findsOneWidget);

    await tester.pump();
  });
}
