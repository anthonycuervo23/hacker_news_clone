import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hacker_news_clone/presentation/pages/home_page.dart';

void main() {
  testWidgets('make sure we render ListView', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pump();
    expect(find.byType(ListView), findsOneWidget);
  });
}
