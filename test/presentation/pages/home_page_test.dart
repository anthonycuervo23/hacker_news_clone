import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hacker_news_clone/presentation/pages/feed_page.dart';

void main() {
  testWidgets('make sure ExpansionTile expands and find an icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    expect(find.byIcon(Icons.launch), findsNothing);

    await tester.tap(find.byType(ExpansionTile).first);
    await tester.pump();

    expect(find.byIcon(Icons.launch), findsOneWidget);
  });

  testWidgets('make sure ListView renders 7 stories ',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pump();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ExpansionTile), findsNWidgets(7));
  }, skip: true);
}
