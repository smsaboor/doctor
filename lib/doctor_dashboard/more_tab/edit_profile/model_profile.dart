// To parse this JSON data, do
//
//     final modelProfile = modelProfileFromJson(jsonString);

import 'dart:convert';

List<ModelProfile> modelProfileFromJson(String str) => List<ModelProfile>.from(json.decode(str).map((x) => ModelProfile.fromJson(x)));

String modelProfileToJson(List<ModelProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class ModelProfile {
  ModelProfile({
    this.doctor_id,
    this.name,
    this.number,
    this.language,
    this.degree,
    this.licence_no,
    this.experience,
    this.speciality,
    this.address,
  });

  String? doctor_id;
  String? name;
  String? number;
  String? language;
  String? degree;
  String? licence_no;
  String? experience;
  String? speciality;
  String? address;

  factory ModelProfile.fromJson(Map<String, dynamic> json) => ModelProfile(
    doctor_id: json["doctor_id"],
    name: json["name"],
    number: json["number"],
    language: json["language"],
    degree: json["degree"],
    licence_no: json["licence_no"],
    experience: json["experience"],
    speciality: json["speciality"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctor_id,
    "name": name,
    "number": number,
    "language": language,
    "degree": degree,
    "licence_no": licence_no,
    "experience": experience,
    "speciality": speciality,
    "address": address,
  };
}
