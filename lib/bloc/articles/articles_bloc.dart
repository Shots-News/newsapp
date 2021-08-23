import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/repository/article_repo.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticleService articleRepository;
  late List<ArticleModel> articleList;

  List<ArticleModel>? _list = [];

  List<ArticleModel>? get data {
    return [..._list!];
  }

  ArticlesBloc({required this.articleRepository}) : super(ArticlesInitial());

  @override
  Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
    switch (event) {
      case ArticlesEvent.fetchArticles:
        yield ArticlesLoading(articles: _list);
        try {
          articleList = await articleRepository.getArticlesList();
          yield ArticlesLoaded(articles: articleList);
        } on SocketException {
          yield ArticlesError(error: 'No Internet');
        } on HttpException {
          yield ArticlesError(error: 'No Service');
        } on FormatException {
          yield ArticlesError(error: 'No Formate Exception');
        } catch (e) {
          print(e.toString());
          yield ArticlesError(error: 'Un Known Error ${e.toString()}');
        }
        break;
    }
  }
}
