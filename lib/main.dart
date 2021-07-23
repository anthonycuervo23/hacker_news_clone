import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//My imports
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:hacker_news_clone/presentation/pages/story_page.dart';
import 'package:hacker_news_clone/presentation/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Repository>(
      create: (_) => Repository(),
      child: MaterialApp(
        home: const HomePage(),
        theme: dark,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
