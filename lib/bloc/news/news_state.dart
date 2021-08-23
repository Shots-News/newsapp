part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {
  final List<ArticleModel>? articles;

  NewsLoading({required this.articles});
}

class NewsLoaded extends NewsState {
  final List<ArticleModel> articles;

  NewsLoaded({required this.articles});
}

class NewsError extends NewsState {
  final error;

  NewsError({this.error});
}
