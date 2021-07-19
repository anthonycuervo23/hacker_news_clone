import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:hacker_news_clone/presentation/pages/home_page.dart';

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
        theme: ThemeData(
            primaryColor: const Color(0xFF212121),
            scaffoldBackgroundColor: const Color(0xFF212121)),
      ),
    );
  }
}
