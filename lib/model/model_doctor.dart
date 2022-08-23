// To parse this JSON data, do
//
//     final modelDoctor = modelDoctorFromJson(jsonString);

import 'dart:convert';

ModelDoctor modelDoctorFromJson(String str) => ModelDoctor.fromJson(json.decode(str));

String modelDoctorToJson(ModelDoctor data) => json.encode(data.toJson());

class ModelDoctor {
  ModelDoctor({
    this.sucessCode,
    this.message,
    this.clinicName,
    this.name,
    this.specialist,
    this.emergencyNumber,
    this.mobile,
    this.phone,
    this.address,
    this.state,
    this.city,
    this.district,
    this.password,
    this.pincode,
    this.userType,
  });

  String? sucessCode;
  String? message;
  String? clinicName;
  String? name;
  String? specialist;
  String? emergencyNumber;
  String? mobile;
  String? phone;
  String? address;
  String? state;
  String? city;
  String? district;
  String? password;
  String? pincode;
  String? userType;

  factory ModelDoctor.fromJson(Map<String, dynamic> json) => ModelDoctor(
    sucessCode: json["sucess_code"],
    message: json["message"],
    clinicName: json["clinic_name"],
    name: json["name"],
    specialist: json["specialist"],
    emergencyNumber: json["emergency_number"],
    mobile: json["mobile"],
    phone: json["phone"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    district: json["district"],
    password: json["password"],
    pincode: json["pincode"],
    userType: json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "sucess_code": sucessCode,
    "message": message,
    "clinic_name": clinicName,
    "name": name,
    "specialist": specialist,
    "emergency_number": emergencyNumber,
    "mobile": mobile,
    "phone": phone,
    "address": address,
    "state": state,
    "city": city,
    "district": district,
    "password": password,
    "pincode": pincode,
    "user_type": userType,
  };
}
