import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/model/model_doctor.dart';
import 'package:doctor/model/model_otp.dart';
import 'package:doctor/model/model_patient.dart';
import 'dart:convert';

import 'package:doctor/model/model_verify.dart';

class ApiService {
  static Future<dynamic> checkUserRegistered(String mobile) async {
    var APIURLRegistration = 'https://cabeloclinic.com/website/medlife/php_auth_api/register_api.php';
    Map<String, dynamic> body = {'mobile': mobile};
    http.Response response = await http
        .post(Uri.parse(APIURLRegistration), body: body)
        .then((value) => value)
        .catchError((error) =>
            print("Doctor app Failed to registerUserwithOtp: $error"));
    print('.............${response.body}');
    var data = jsonDecode(response.body);
    print("$mobile getRegistration DATA: ${data}");
    print("getRegistration DATA: ${data['message']}");
    print(data['status']);
    return data;
  }

  static Future<String> signUpUser(int userType, ModelDoctor modelDoctor,ModelPatient modelPatient ) async {
    var APIURLRegistr = 'https://cabeloclinic.com/website/medlife/php_auth_api/sign_up_api.php';
    print(',,,,usertype: $userType,,,,,,,,,,,,,,,,,,,,,,,,,,${modelDoctor.mobile},,,,,,,,,,,,,,,,${modelDoctor.password}');
    print(',,,,usertype: $userType,,,,,,,,,,,,,,,,,,,,,,,,,,${modelPatient.mobile},,,,,,,,,,,,,,,,${modelPatient.password}');
    var data;
    if(userType==2){
      print('@@@@@@@@@@@@@@@@@@${modelDoctor.mobile}, ${modelDoctor.password}');
      Map<String, dynamic> body = {
        'user_type': modelDoctor.userType,
        'name': modelDoctor.name,
        'mobile': modelDoctor.mobile,
        'emergency_number': modelDoctor.emergencyNumber,
        'phone': modelDoctor.phone,
        'clinic_name': modelDoctor.clinicName,
        'specialist': modelDoctor.specialist,
        'address': modelDoctor.address,
        'state': modelDoctor.state,
        'city': modelDoctor.city,
        'district': modelDoctor.district,
        'pincode': modelDoctor.pincode,
        'password': modelDoctor.password,
      };
      print('@@@@@@@@@@@@@@@@@@${body}');
      http.Response response = await http.post(Uri.parse(APIURLRegistr), body: body)
          .then((value) => value)
          .catchError((error) =>
          print("Doctor app Failed to signUp: $error"));
      print('.............${response.body}');
      data = jsonDecode(response.body);
      print("getRegistration DATA: ${data}");
      print("getRegistration DATA: ${data['message']}");
      print(data['sucess_code']);
    }
    else if(userType==1){
      print('@@@@@@@@@@@@@@@@@@${modelPatient.mobile}, ${modelPatient.password}');
      Map<String, dynamic> body = {
        'user_type': modelPatient.userType,
        'name': modelPatient.name,
        'mobile': modelPatient.mobile,
        'address': modelPatient.address,
        'state': modelPatient.state,
        'city': modelPatient.city,
        'district': modelPatient.district,
        'pincode': modelPatient.pincode,
        'password': modelPatient.password,
      };
      print('Model : @@@@@@@@@@@@@@@@@@${body}');
      http.Response response = await http
          .post(Uri.parse(APIURLRegistr), body: body)
          .then((value) => value)
          .catchError((error) =>
          print("Doctor app Failed to registerUserwithOtp: $error"));
      print('Responce  :.............${response.body}');
      data = jsonDecode(response.body);
      print("getRegistration DATA: ${data}");
      print("getRegistration DATA: ${data['message']}");
      print('..........................................................${data['sucess_code']}');
    }
    return data['sucess_code'];
  }
  static Future<dynamic> login({String? mobile,String? pwd}) async {
    Map<String, dynamic> body = {
      'mobile': mobile,
      'password': pwd,
    };
    var APIURLRegistration =
        'https://cabeloclinic.com/website/medlife/php_auth_api/login_api.php';
    http.Response response = await http
        .post(Uri.parse(APIURLRegistration), body: body)
        .then((value) => value)
        .catchError(
            (error) => print("medelif Failed to login: $error"));
    var data = jsonDecode(response.body);
    print("logindata----------------------------------- DATA: ${data}");
    return data;
  }


  static Future<String> verifyOtp(OtpModel model) async {
    print('${model.mobile}');
    print('${model.otp}');
    var APIURLRegistration =
        'https://cabeloclinic.com/website/medlife/php_auth_api/otp_verified.php';
    http.Response response = await http
        .post(Uri.parse(APIURLRegistration), body: model.toMap())
        .then((value) => value)
        .catchError(
            (error) => print("Colorgame Failed to getRegistration: $error"));
    var data = jsonDecode(response.body);
    print("getRegistration DATA: ${data[0]}");
    return data[0]['success_code'];
  }
}
