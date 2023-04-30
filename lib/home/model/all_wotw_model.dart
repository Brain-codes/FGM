// To parse this JSON data, do
//
//     final allWotwModel = allWotwModelFromJson(jsonString);

import 'dart:convert';

import 'package:FGM/media/model/all_media_model.dart';

AllWotwModel allWotwModelFromJson(String str) =>
    AllWotwModel.fromJson(json.decode(str));

String allWotwModelToJson(AllWotwModel data) => json.encode(data.toJson());

class AllWotwModel {
  ImageClass? image;
  String? content;
  String? id;

  AllWotwModel({
    this.image,
    this.content,
    this.id,
  });

  factory AllWotwModel.fromJson(Map<String, dynamic> json) => AllWotwModel(
        image:
            json["image"] == null ? null : ImageClass.fromJson(json["image"]),
        content: json["content"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image?.toJson(),
        "content": content,
        "id": id,
      };
}
