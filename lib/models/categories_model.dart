import 'dart:convert';

class CategoriesModel {
  CategoriesModel({
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

  factory CategoriesModel.fromRawJson(String str) => CategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
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
