// To parse this JSON data, do
//
//     final signUp = signUpFromJson(jsonString);

import 'dart:convert';

ModelPatient signUpFromJson(String str) => ModelPatient.fromJson(json.decode(str));

String signUpToJson(ModelPatient data) => json.encode(data.toJson());

class ModelPatient {
  ModelPatient({
    this.sucessCode,
    this.message,
    this.name,
    this.mobile,
    this.address,
    this.state,
    this.city,
    this.district,
    this.pincode,
    this.password,
    this.userType,
  });

  String? sucessCode;
  String? message;
  String? name;
  String? mobile;
  String? address;
  String? state;
  String? city;
  String? district;
  String? pincode;
  String? password;
  String? userType;

  factory ModelPatient.fromJson(Map<String, dynamic> json) => ModelPatient(
    sucessCode: json["sucess_code"],
    message: json["message"],
    name: json["name"],
    mobile: json["mobile"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    district: json["district"],
    pincode: json["pincode"],
    password: json["password"],
    userType: json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "sucess_code": sucessCode,
    "message": message,
    "name": name,
    "mobile": mobile,
    "address": address,
    "state": state,
    "city": city,
    "district": district,
    "pincode": pincode,
    "password": password,
    "user_type": userType,
  };
}
