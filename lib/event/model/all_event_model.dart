// To parse this JSON data, do
//
//     final allEventModel = allEventModelFromJson(jsonString);

import 'dart:convert';

import 'package:FGM/media/model/all_media_model.dart';

AllEventModel allEventModelFromJson(String str) =>
    AllEventModel.fromJson(json.decode(str));

String allEventModelToJson(AllEventModel data) => json.encode(data.toJson());

class AllEventModel {
  AllEventModel({
    this.startDateTime,
    this.endDateTime,
    this.title,
    this.id,
    this.live,
    this.image,
    this.pastEvent,
    this.venue,
  });

  String? startDateTime;
  String? endDateTime;
  String? title;
  String? id;
  bool? live;
  ImageClass? image;
  bool? pastEvent;
  String? venue;

  factory AllEventModel.fromJson(Map<String, dynamic> json) => AllEventModel(
        startDateTime: json["startDateTime"],
        endDateTime: json["endDateTime"],
        title: json["title"],
        id: json["id"],
        live: json["live"],
        image:
            json["image"] == null ? null : ImageClass.fromJson(json["image"]),
        pastEvent: json["pastEvent"],
        venue: json["venue"],
      );

  Map<String, dynamic> toJson() => {
        "startDateTime": startDateTime,
        "endDateTime": endDateTime,
        "title": title,
        "id": id,
        "live": live,
        "image": image?.toJson(),
        "pastEvent": pastEvent,
        "venue": venue,
      };
}
