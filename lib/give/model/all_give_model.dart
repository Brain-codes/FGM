// To parse this JSON data, do
//
//     final allGiveModel = allGiveModelFromJson(jsonString);

import 'dart:convert';

AllGiveModel allGiveModelFromJson(String str) =>
    AllGiveModel.fromJson(json.decode(str));

String allGiveModelToJson(AllGiveModel data) => json.encode(data.toJson());

class AllGiveModel {
  String? id;
  String? accountName;
  int? accountNumber;
  String? bankName;
  String? accountPurpose;

  AllGiveModel({
    this.id,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.accountPurpose,
  });

  factory AllGiveModel.fromJson(Map<String, dynamic> json) => AllGiveModel(
        id: json["id"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bankName: json["bankName"],
        accountPurpose: json["accountPurpose"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "accountPurpose": accountPurpose,
      };
}
