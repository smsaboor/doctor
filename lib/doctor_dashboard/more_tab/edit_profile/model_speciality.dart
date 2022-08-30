// To parse this JSON data, do
//
//     final degrees = degreesFromJson(jsonString);

import 'dart:convert';

List<ModelSpeciality> degreesFromJson(String str) => List<ModelSpeciality>.from(json.decode(str).map((x) => ModelSpeciality.fromJson(x)));

String degreesToJson(List<ModelSpeciality> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSpeciality {
  ModelSpeciality({
    this.doctor_speciality,
  });

  String? doctor_speciality;

  factory ModelSpeciality.fromJson(Map<String, dynamic> json) => ModelSpeciality(
    doctor_speciality: json["doctor_speciality"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_speciality": doctor_speciality,
  };
}

class ModelSpeciality2{
  ModelSpeciality2({
    this.speciality,
    this.index
  });
  String? speciality;
  String? index;
  Map toJson() => {
    'speciality': speciality,
    'index': index,
  };
}
