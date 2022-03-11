// To parse this JSON data, do
//
//     final uploadImage = uploadImageFromJson(jsonString);

import 'dart:convert';

List<VIsaCard> uploadImageFromJson(String str) => List<VIsaCard>.from(json.decode(str).map((x) => VIsaCard.fromJson(x)));

String uploadImageToJson(List<VIsaCard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VIsaCard {
  VIsaCard({
    this.firstName,
    this.secondName,
    this.cardNumber,
    this.creatData,
    this.cvv,
    this.id,
  });

  String? firstName;
  String? secondName;
  String? cardNumber;
  String? creatData;
  String? cvv;
  String? id;

  factory VIsaCard.fromJson(Map<String, dynamic> json) => VIsaCard(
    firstName: json["first_name"],
    secondName: json["second_name"],
    cardNumber: json["card_number"],
    creatData: json["creat_data"],
    cvv: json["cvv"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "second_name": secondName,
    "card_number": cardNumber,
    "creat_data": creatData,
    "cvv": cvv,
    "id": id,
  };
}
