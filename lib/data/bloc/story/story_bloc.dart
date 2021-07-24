import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

//My imports
import 'package:hacker_news_clone/data/utils/hacker_news_enum.dart';
import 'package:hacker_news_clone/data/models/item.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  StoriesBloc(this.repo)
      : super(const StoriesState(status: NewsStatus.initial));
  final Repository repo;

  @override
  Stream<StoriesState> mapEventToState(
    StoriesEvent event,
  ) async* {
    if (event is OnGetStories) {
      final List<Item> filteredStories = <Item>[];
      yield state.copyWith(status: NewsStatus.loading);
      final List<Item?> stories = await repo.getStories(state.type, 20);
      if (stories.isEmpty) {
        yield state.copyWith(
            status: NewsStatus.error,
            message: 'Could not get stories, please try again');
      } else {
        for (final Item? story in stories) {
          if (story!.type == 'story') {
            filteredStories.add(story);
          }
        }
        yield state.copyWith(
          stories: filteredStories,
          status: NewsStatus.loaded,
        );
      }
    }
    if (event is OnGetMoreStories) {
      yield state.copyWith(loadStoriesOnScroll: true);
      final List<Item?> stories =
          await repo.getMoreStories(state.type, 10, state.stories.length);
      if (stories.isEmpty) {
        yield state.copyWith(
            status: NewsStatus.error,
            message: 'Could not load more stories, please try again');
      } else {
        for (final Item? story in stories) {
          if (story!.descendants != null) {
            state.stories.add(story);
          }
        }
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

  Future<Item?> getStoriesById(int id) async {
    return repo.fetchItem(id);
  }
}