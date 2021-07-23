import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hacker_news_clone/data/models/story.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(this.repo) : super(const CommentState());
  final Repository repo;

  Future<List<Story?>> getComments(Story? item) async {
    //por lo que entendi, este funcion extrae todos los comentarios padres con sus comentarios hijos
    //la funcion me retorna todos los comentarios padres y almacena los hijos en una variable dentro de Story
    if (item!.kids!.isEmpty) {
      return <Story>[];
    } else {
      final List<Story?> comments =
          await Future.wait(item.kids!.map((int id) => repo.fetchStory(id)));
      final List<List<Story?>> nestedComments = await Future.wait(
          comments.map((Story? comment) => getComments(comment)));
      for (int i = 0; i < nestedComments.length; i++) {
        //comments es una lista de comentarios padres
        //comments[i] es un comentario padre y aqui almacenamos el comentario padre con sus comentarios hijos
        comments[i]!.toBuilder().comments = nestedComments[i];
        state.copyWith(comments: nestedComments[i]);
      }
      return comments;
    }
  }

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is OnGetComments) {
      //await getComments(event.item);
    }
  }
}
