// To parse this JSON data, do
//
//     final allDevotionalModel = allDevotionalModelFromJson(jsonString);

import 'dart:convert';

import '../../media/model/all_media_model.dart';

AllDevotionalModel allDevotionalModelFromJson(String str) =>
    AllDevotionalModel.fromJson(json.decode(str));

String allDevotionalModelToJson(AllDevotionalModel data) =>
    json.encode(data.toJson());

class AllDevotionalModel {
  AllDevotionalModel({
   required this.title,
   required this.image,
   required this.content,
   required this.id,
   required this.date,
  });

  String title;
  ImageClass? image;
  String content;
  String id;
  String date;

  factory AllDevotionalModel.fromJson(Map<String, dynamic> json) =>
      AllDevotionalModel(
        title: json["title"],
        image: json["image"] == null ? null : ImageClass.fromJson(json["image"]),
        content: json["content"],
        id: json["id"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image?.toJson(),
        "content": content,
        "id": id,
        "date": date,
      };
}

