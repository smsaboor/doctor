// To parse this JSON data, do
//
//     final assistents = assistentsFromJson(jsonString);

import 'dart:convert';

List<ModelAssistent> assistentsFromJson(String str) => List<ModelAssistent>.from(json.decode(str).map((x) => ModelAssistent.fromJson(x)));

String assistentsToJson(List<ModelAssistent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelAssistent {
  ModelAssistent({
    this.assistantName,
    this.status,
    this.number,
    this.address,
    this.doctorId,
  });

  String? assistantName;
  String? status;
  String? number;
  String? address;
  String? doctorId;

  factory ModelAssistent.fromJson(Map<String, dynamic> json) => ModelAssistent(
    assistantName: json["assistant_name"],
    status: json["status"],
    number: json["number"],
    address: json["address"],
    doctorId: json["doctor_id"],
  );

  Map<String, dynamic> toJson() => {
    "assistant_name": assistantName,
    "status": status,
    "number": number,
    "address": address,
    "doctor_id": doctorId,
  };
}
