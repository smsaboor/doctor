// To parse this JSON data, do
//
//     final modelPills = modelPillsFromJson(jsonString);

import 'dart:convert';

List<ModelPills> modelPillsFromJson(String str) => List<ModelPills>.from(json.decode(str).map((x) => ModelPills.fromJson(x)));

String modelPillsToJson(List<ModelPills> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPills {
  ModelPills({
    this.pills,
  });

  String? pills;

  factory ModelPills.fromJson(Map<String, dynamic> json) => ModelPills(
    pills: json["pills"],
  );

  Map<String, dynamic> toJson() => {
    "pills": pills,
  };
}
