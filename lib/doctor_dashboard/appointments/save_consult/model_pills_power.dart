// To parse this JSON data, do
//
//     final modelPills = modelPillsFromJson(jsonString);

import 'dart:convert';

List<ModelPillsPower> modelPillsFromJson(String str) => List<ModelPillsPower>.from(json.decode(str).map((x) => ModelPillsPower.fromJson(x)));

String modelPillsToJson(List<ModelPillsPower> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPillsPower {
  ModelPillsPower({
    this.pills_power,
  });

  String? pills_power;

  factory ModelPillsPower.fromJson(Map<String, dynamic> json) => ModelPillsPower(
    pills_power: json["pills_power"],
  );

  Map<String, dynamic> toJson() => {
    "pills_power": pills_power,
  };
}
