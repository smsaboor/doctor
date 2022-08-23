// To parse this JSON data, do
//
//     final modelPills = modelPillsFromJson(jsonString);

import 'dart:convert';

List<ModelPillsRepeatTime> modelPillsFromJson(String str) => List<ModelPillsRepeatTime>.from(json.decode(str).map((x) => ModelPillsRepeatTime.fromJson(x)));

String modelPillsToJson(List<ModelPillsRepeatTime> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPillsRepeatTime {
  ModelPillsRepeatTime({
    this.repeat_time,
  });

  String? repeat_time;

  factory ModelPillsRepeatTime.fromJson(Map<String, dynamic> json) => ModelPillsRepeatTime(
    repeat_time: json["repeat_time"],
  );

  Map<String, dynamic> toJson() => {
    "repeat_time": repeat_time,
  };
}
