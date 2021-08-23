import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/meta/config.dart';
import 'package:newsapp/models/categories_model.dart';

abstract class CategoriesRepository {
  Future<List<CategoriesModel>> getCategoriesList();
}

class CategoryService with ChangeNotifier implements CategoriesRepository {
  CategoryService() {
    getCategoriesList();
  }

  List<CategoriesModel> _list = [];
  List<CategoriesModel> get data => [..._list];

  @override
  Future<List<CategoriesModel>> getCategoriesList() async {
    DioCacheManager _dioCacheManager;
    Dio _dio = Dio();

    _dioCacheManager = DioCacheManager(
      CacheConfig(
        baseUrl: SUPABASE_URL + CATEGORIES_TABLE,
        defaultRequestMethod: "GET",
        databaseName: "Categories",
      ),
    );
    Options _cacheOptions = buildCacheOptions(
      Duration(days: 7),
      forceRefresh: true,
      options: Options(
        headers: {
          "Authorization": "Bearer $SUPABASE_APi",
          "apikey": SUPABASE_APi,
        },
      ),
    );

    _dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      Response response = await _dio.get(
        SUPABASE_URL + CATEGORIES_TABLE,
        options: _cacheOptions,
      );
      _list = response.data.map<CategoriesModel>((json) => CategoriesModel.fromJson(json)).toList();
    } catch (e) {
      print(e);

      /// [FirebaseCrashlytics]
      FirebaseCrashlytics.instance.log("Get Categories List: ${e.toString()}");
    }

    notifyListeners();
    return data;
  }
}
