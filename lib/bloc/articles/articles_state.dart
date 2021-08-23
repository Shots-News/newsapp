part of 'articles_bloc.dart';

abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {
  final List<ArticleModel>? articles;

  ArticlesLoading({required this.articles});
}

class ArticlesLoaded extends ArticlesState {
  final List<ArticleModel> articles;

  ArticlesLoaded({required this.articles});
}

class ArticlesError extends ArticlesState {
  final error;

  ArticlesError({this.error});
}
