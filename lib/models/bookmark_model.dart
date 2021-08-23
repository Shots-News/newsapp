import 'dart:convert';

import 'package:newsapp/models/article_model.dart';

class BookmarkModel {
  BookmarkModel({
    this.userId,
    this.userName,
    this.articles,
    this.createdAt,
  });

  final String? userId;
  final String? userName;
  final List<ArticleModel>? articles;
  final int? createdAt;

  factory BookmarkModel.fromRawJson(String str) => BookmarkModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
        userId: json["userID"],
        userName: json["userName"],
        articles: List<ArticleModel>.from(json["articles"].map((x) => ArticleModel.fromJson(x))),
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "userName": userName,
        "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
        'createdAt': createdAt,
      };
}
