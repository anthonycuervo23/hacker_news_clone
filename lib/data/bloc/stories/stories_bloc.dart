import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hacker_news_clone/data/enum/hacker_news_enum.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:meta/meta.dart';

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
    if (event is OnGetMoreStories) {
      //List<Story> test = <Story>[];
      //test = state.stories;
      yield state.copyWith(loadStoriesOnScroll: true);
      final List<Story?> stories =
          await repo.getMoreStories(state.type, 10, state.stories!.length);
      if (stories.isEmpty) {
        yield state.copyWith(
            status: NewsStatus.error,
            message: 'Could not load more stories, please try again');
      } else {
        // final testStory = Story((b) => b
        //   ..id = 123
        //   ..type = 'story'
        //   ..title = 'PRUEBA'
        //   ..by = 'jeancuervo'
        //   ..time = 123455);
        //test!.add(testStory);
        //test!.addAll(stories);
        state.stories!.addAll(stories);

        //REMOVE DUPLICATES
        // final Set<int> ids = test.map((Story? story) => story!.id).toSet();
        // test.retainWhere((Story? story) => ids.remove(story!.id));

        yield state.copyWith(
            stories: state.stories, loadStoriesOnScroll: false);
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
