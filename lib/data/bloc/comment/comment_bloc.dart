import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hacker_news_clone/data/models/item.dart';
import 'package:hacker_news_clone/data/services/api_repository.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(this.repo) : super(const CommentState());
  final Repository repo;

  Future<List<Item?>> getComments(Item? item) async {
    //por lo que entendi, este funcion extrae todos los comentarios padres con sus comentarios hijos
    //la funcion me retorna todos los comentarios padres y almacena los hijos en una variable dentro de Story
    if (item!.kids!.isEmpty) {
      return <Item>[];
    } else {
      final List<Item?> comments =
          await Future.wait(item.kids!.map((int id) => repo.fetchItem(id)));
      final List<List<Item?>> nestedComments = await Future.wait(
          comments.map((Item? comment) => getComments(comment)));
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
