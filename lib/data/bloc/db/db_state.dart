part of 'db_bloc.dart';

@immutable
class DbState {
  const DbState({this.listIdsRead});

  final List<int>? listIdsRead;

  DbState copyWith({List<int>? listIdsRead}) {
    return DbState(listIdsRead: listIdsRead ?? this.listIdsRead);
  }
}
