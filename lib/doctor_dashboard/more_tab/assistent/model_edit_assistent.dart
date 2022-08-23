// To parse this JSON data, do
//
//     final assistents = assistentsFromJson(jsonString);

import 'dart:convert';

List<ModelEditAssistent> assistentsFromJson(String str) => List<ModelEditAssistent>.from(json.decode(str).map((x) => ModelEditAssistent.fromJson(x)));

String assistentsToJson(List<ModelEditAssistent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelEditAssistent {

  ModelEditAssistent({
    this.status,
    this.message,
    this.assistant_name,
    this.assistant_id,
    this.number,
    this.address,
    this.status_order,
  });
  String? status;
  String? message;
  String? assistant_id;
  String? assistant_name;
  String? number;
  String? address;
  String? status_order;

  factory ModelEditAssistent.fromJson(Map<String, dynamic> json) => ModelEditAssistent(
    status:json["status"],
    message:json["message"],
    assistant_id: json["assistant_id"],
    assistant_name: json["assistant_name"],
    status_order: json["status_order"],
    number: json["number"],
    address: json["address"],

  );

  Map<String, dynamic> toJson() => {
    "message":message,
    "status":status,
    "assistant_name": assistant_name,
    "status": status_order,
    "number": number,
    "address": address,
    "assistant_id": assistant_id,
  };
}
