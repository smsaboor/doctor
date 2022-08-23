// To parse this JSON data, do
//
//     final modelPills = modelPillsFromJson(jsonString);

import 'dart:convert';

List<ModelPillsDose> modelPillsFromJson(String str) => List<ModelPillsDose>.from(json.decode(str).map((x) => ModelPillsDose.fromJson(x)));

String modelPillsToJson(List<ModelPillsDose> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPillsDose {
  ModelPillsDose({
    this.pills_dose,
  });

  String? pills_dose;

  factory ModelPillsDose.fromJson(Map<String, dynamic> json) => ModelPillsDose(
    pills_dose: json["pills_dose"],
  );

  Map<String, dynamic> toJson() => {
    "pills_dose": pills_dose,
  };
}
