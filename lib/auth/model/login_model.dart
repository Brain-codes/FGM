// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
