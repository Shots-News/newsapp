import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:newsapp/meta/config.dart';
import 'package:newsapp/models/article_model.dart';

// abstract class ArticlesRepository {
//   Future<List<ArticleModel>> getArticlesList();
//   Future<List<ArticleModel>> getArticlesByCategories();
// }

class ArticleService with ChangeNotifier {
  // ArticleService() {
  //   getArticlesList();
  // }

  List<ArticleModel> _list = [];
  List<ArticleModel> get data {
    return [..._list];
  }

  DioCacheManager? _dioCacheManager;
  Dio _dio = Dio();

  Options _cacheOptions = buildCacheOptions(
    Duration(days: 7),
    forceRefresh: true,
    options: Options(
      method: "GET",
      headers: {
        "Authorization": "Bearer $SUPABASE_APi",
        "apikey": SUPABASE_APi,
      },
    ),
  );

  Future<List<ArticleModel>> getArticlesList() async {
    String _url = SUPABASE_URL + ARTICLES_TABLE;

    _dioCacheManager = DioCacheManager(
      CacheConfig(baseUrl: _url, databaseName: "Articles"),
    );
    _dio.interceptors.add(_dioCacheManager!.interceptor);

    try {
      Response response = await _dio.get(_url, options: _cacheOptions);
      _list = response.data.map<ArticleModel>((json) => ArticleModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return data;
  }

  Future<List<ArticleModel>> getArticlesByCategories(categoriesID) async {
    String _url = SUPABASE_URL + ARTICLES_TABLE + "&category_id=eq.$categoriesID";
    _dioCacheManager = DioCacheManager(
      CacheConfig(
        baseUrl: _url,
        databaseName: "Articles_$categoriesID",
      ),
    );
    _dio.interceptors.add(_dioCacheManager!.interceptor);

    try {
      Response response = await _dio.get(_url, options: _cacheOptions);
      _list = response.data.map<ArticleModel>((json) => ArticleModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return data;
  }

  notifyListeners();
}
