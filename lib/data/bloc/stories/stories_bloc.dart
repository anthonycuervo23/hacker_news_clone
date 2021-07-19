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
    if (event is OnGetNewStories) {
      yield state.copyWith(status: NewsStatus.loading);
      final List<int> id = await repo.fetchBestIDs(StoriesType.newStories);
      if (id.isEmpty) {
        yield state.copyWith(
            status: NewsStatus.error,
            message: 'Could not get stories, please try again');
      } else {
        yield state.copyWith(status: NewsStatus.loaded, ids: id);
      }
    }
    if (event is OnGetTopStories) {
      yield state.copyWith(status: NewsStatus.loading);
      final List<int> id = await repo.fetchBestIDs(StoriesType.topStories);
      if (id.isEmpty) {
        yield state.copyWith(
            status: NewsStatus.error,
            message: 'Could not get stories, please try again');
      } else {
        yield state.copyWith(status: NewsStatus.loaded, ids: id);
      }
    }
    // if (event is OnSelectedTab) {
    //   yield state.copyWith(type: event.type);
    // }
    if (event is OnRefresh) {
      // for database
    }
  }

  Future<Story?> getStoriesById(int id) async {
    return repo.fetchStory(id);
  }
}
