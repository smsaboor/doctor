// To parse this JSON data, do
//
//     final modelPills = modelPillsFromJson(jsonString);

import 'dart:convert';

List<ModelPillsTiming> modelPillsFromJson(String str) => List<ModelPillsTiming>.from(json.decode(str).map((x) => ModelPillsTiming.fromJson(x)));

String modelPillsToJson(List<ModelPillsTiming> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPillsTiming {
  ModelPillsTiming({
    this.pills_timing,
  });

  String? pills_timing;

  factory ModelPillsTiming.fromJson(Map<String, dynamic> json) => ModelPillsTiming(
    pills_timing: json["pills_timing"],
  );

  Map<String, dynamic> toJson() => {
    "pills_timing": pills_timing,
  };
}
