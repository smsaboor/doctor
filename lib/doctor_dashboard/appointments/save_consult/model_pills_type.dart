// To parse this JSON data, do
//
//     final modelPills = modelPillsFromJson(jsonString);

import 'dart:convert';

List<ModelPillsType> modelPillsFromJson(String str) => List<ModelPillsType>.from(json.decode(str).map((x) => ModelPillsType.fromJson(x)));

String modelPillsToJson(List<ModelPillsType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPillsType {
  ModelPillsType({
    this.pills_type,
  });

  String? pills_type;

  factory ModelPillsType.fromJson(Map<String, dynamic> json) => ModelPillsType(
    pills_type: json["pills_type"],
  );

  Map<String, dynamic> toJson() => {
    "pills_type": pills_type,
  };
}
