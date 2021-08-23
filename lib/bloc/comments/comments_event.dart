part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class CommentsEventStart extends CommentsEvent {}

class CommentsEventLoad extends CommentsEvent {
  final List<List<CommentModel>> data;

  const CommentsEventLoad(this.data);

  @override
  List<Object> get props => [data];
}

class CommentsEventUpdated extends CommentsEvent {
  final List<List<CommentModel>> data;

  const CommentsEventUpdated(this.data);

  @override
  List<Object> get props => [data];
}

class CommentsEventFetchMore extends CommentsEvent {}
