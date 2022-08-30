// To parse this JSON data, do
//
//     final degrees = degreesFromJson(jsonString);

import 'dart:convert';

List<ModelDegrees> degreesFromJson(String str) => List<ModelDegrees>.from(json.decode(str).map((x) => ModelDegrees.fromJson(x)));

String degreesToJson(List<ModelDegrees> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDegrees {
  ModelDegrees({
    this.degree,
  });

  String? degree;

  factory ModelDegrees.fromJson(Map<String, dynamic> json) => ModelDegrees(
    degree: json["degree"],
  );

  Map<String, dynamic> toJson() => {
    "degree": degree,
  };
}


class ModelDegree2{
  ModelDegree2({
    this.degree,
    this.index
  });
  String? degree;
  String? index;
  Map toJson() => {
    'degree': degree,
    'index': index,
  };
}


