import 'dart:convert';

class ArticleModel {
  ArticleModel({
    this.id,
    this.title,
    this.description,
    this.thumnail,
    this.videoUrl,
    this.sourceUrl,
    this.draft,
    this.createdAt,
    this.updatedAt,
    this.isVideo,
    this.categoryId,
    this.caregories,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? thumnail;
  final String? videoUrl;
  final String? sourceUrl;
  final bool? draft;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isVideo;
  final int? categoryId;
  final Caregories? caregories;

  factory ArticleModel.fromRawJson(String str) => ArticleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        thumnail: json["thumnail"],
        videoUrl: json["video_url"],
        sourceUrl: json["source_url"],
        draft: json["draft"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isVideo: json["is_video"],
        categoryId: json["category_id"],
        caregories: Caregories.fromJson(json["caregories"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "thumnail": thumnail,
        "video_url": videoUrl,
        "source_url": sourceUrl,
        "draft": draft,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_video": isVideo,
        "category_id": categoryId,
        "caregories": caregories!.toJson(),
      };
}

class Caregories {
  Caregories({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Caregories.fromRawJson(String str) => Caregories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Caregories.fromJson(Map<String, dynamic> json) => Caregories(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
