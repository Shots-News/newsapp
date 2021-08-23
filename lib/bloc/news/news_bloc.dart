import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/repository/article_repo.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required this.articleRepository, this.categoriesID = 0}) : super(NewsInitial());

  final ArticleService articleRepository;
  late List<ArticleModel> articleList;
  final int categoriesID;

  List<ArticleModel>? _list = [];

  List<ArticleModel>? get data {
    return [..._list!];
  }

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (categoriesID != 0) {
      switch (event) {
        case NewsEvent.fetchNews:
          yield NewsLoading(articles: _list);
          try {
            articleList = await articleRepository.getArticlesByCategories(categoriesID);
            yield NewsLoaded(articles: articleList);
          } on SocketException {
            yield NewsError(error: 'No Internet');
          } on HttpException {
            yield NewsError(error: 'No Service');
          } on FormatException {
            yield NewsError(error: 'No Formate Exception');
          } catch (e) {
            print(e.toString());
            yield NewsError(error: 'Un Known Error ${e.toString()}');
          }
          break;
      }
    }
  }
}
