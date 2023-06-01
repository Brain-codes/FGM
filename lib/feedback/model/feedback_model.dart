// To parse this JSON data, do
//
//     final feedbackModel = feedbackModelFromJson(jsonString);

import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) =>
    FeedbackModel.fromJson(json.decode(str));

String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

class FeedbackModel {
  String? id;
  String? fullname;
  int? phoneNumber;
  String? comment;

  FeedbackModel({
    this.id,
    this.fullname,
    this.phoneNumber,
    this.comment,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        id: json["id"],
        fullname: json["fullname"],
        phoneNumber: json["phoneNumber"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phoneNumber": phoneNumber,
        "comment": comment,
      };
}
