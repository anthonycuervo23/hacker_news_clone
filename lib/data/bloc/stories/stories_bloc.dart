import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hacker_news_clone/data/enum/hacker_news_enum.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'stories_event.dart';
part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  StoriesBloc(this.repo)
      : super(const StoriesState(status: NewsStatus.initial));
  final Repository repo;

  @override
  Stream<StoriesState> mapEventToState(
    StoriesEvent event,
  ) async* {
    if (event is OnGetStories) {
      final List<Story> filteredStories = <Story>[];
      yield state.copyWith(status: NewsStatus.loading);
      final List<Story?> stories = await repo.getStories(state.type, 30);
      if (stories.isEmpty) {
        yield state.copyWith(
            status: NewsStatus.error,
            message: 'Could not get stories, please try again');
      } else {
        // for (final Story? story in stories) {
        //   if (story!.type != 'story') {
        //     return;
        //   }
        //   filteredStories.add(story);
        // }
        stories.forEach((Story? story) {
          if (story!.type != 'story') {
            return;
          }
          filteredStories.add(story);
        });
        yield state.copyWith(
          stories: filteredStories,
          status: NewsStatus.loaded,
        );
      }
    }
    if (event is OnSelectedTab) {
      yield state.copyWith(
        type: event.type,
        storiesName: event.storiesName,
      );
    }
  }

  Future<Story?> getStoriesById(int id) async {
    return repo.fetchStory(id);
  }
}
