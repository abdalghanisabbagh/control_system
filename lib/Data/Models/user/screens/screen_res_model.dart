import 'package:flutter/material.dart';

class ScreenResModel {
  Color? color;

  String frontId;

  int id;
  String name;
  ScreenResModel({
    required this.id,
    required this.frontId,
    required this.name,
    this.color,
  });
  factory ScreenResModel.fromJson(json) => ScreenResModel(
        id: json["ID"],
        frontId: json["Front_Id"],
        name: json["Name"],
        color: null,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Front_Id": frontId,
        "Name": name,
      };
}
