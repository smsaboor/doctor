// To parse this JSON data, do
//
//     final allDoctors = allDoctorsFromJson(jsonString);

import 'dart:convert';

List<AllDoctors> allDoctorsFromJson(String str) => List<AllDoctors>.from(json.decode(str).map((x) => AllDoctors.fromJson(x)));

String allDoctorsToJson(List<AllDoctors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllDoctors {
  AllDoctors({
    this.id,
    this.specialty,
    this.doctorName,
    this.number,
    this.address,
    this.aboutUs,
    this.workingTime,
    this.service,
    this.image,
    this.doctorFee,
    this.clinicName,
  });

  String? id;
  String? specialty;
  String? doctorName;
  String? number;
  String? address;
  String? aboutUs;
  String? workingTime;
  String? service;
  String? image;
  String? doctorFee;
  String? clinicName;

  factory AllDoctors.fromJson(Map<String, dynamic> json) => AllDoctors(
    id: json["id"],
    specialty: json["specialty"],
    doctorName: json["doctor_name"],
    number: json["number"],
    address: json["address"],
    aboutUs: json["about_us"],
    workingTime: json["working_time"],
    service: json["service"],
    image: json["image"],
    doctorFee: json["doctor_fee"],
    clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "specialty": specialty,
    "doctor_name": doctorName,
    "number": number,
    "address": address,
    "about_us": aboutUs,
    "working_time": workingTime,
    "service": service,
    "image": image,
    "doctor_fee": doctorFee,
    "clinic_name": clinicName == null ? null : clinicName,
  };
}
