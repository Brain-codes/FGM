// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  SignupModel({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  User({
    required this.name,
    required this.userId,
    required this.phoneNumber,
  });

  String name;
  String userId;
  String phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        userId: json["userId"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "userId": userId,
        "phoneNumber": phoneNumber,
      };
}
