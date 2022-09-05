import 'package:doctor/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/model/model_doctor.dart';
import 'package:doctor/model/model_otp.dart';
import 'package:doctor/model/model_patient.dart';
import 'dart:convert';

import 'package:doctor/model/model_verify.dart';

class ApiService {
  static Future<dynamic> checkUserRegistered(String mobile) async {
    // Dio dio = Dio();
    // Response responce;
    // responce = await dio.post(
    //   APIURLRegistration,
    //   data: formData,
    // );
    // print("response data " + responce.toString());
    var APIURLRegistration = 'https://cabeloclinic.com/website/medlife/php_auth_api/register_api.php';
    Map<String, dynamic> body = {'mobile': mobile};
    http.Response response = await http
        .post(Uri.parse(APIURLRegistration), body: body)
        .then((value) => value)
        .catchError((error) =>
            print("Doctor app Failed to registerUserwithOtp: $error"));
    var data = jsonDecode(response.body);
    return data;
  }
  static Future<dynamic> checkUserRegisteredInner(String mobile) async {
    var APIURLRegistration = 'https://cabeloclinic.com/website/medlife/php_auth_api/inner_register_api.php';
    Map<String, dynamic> body = {'mobile': mobile};
    http.Response response = await http
        .post(Uri.parse(APIURLRegistration), body: body)
        .then((value) => value)
        .catchError((error) =>
        print("Doctor app Failed to registerUserwithOtp: $error"));
    var data = jsonDecode(response.body);
    return data;
  }
  static Future<String> signUpUser(String API,int userType, ModelDoctor modelDoctor,ModelPatient modelPatient ) async {
    var data;
    if(userType==2){
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
      http.Response response = await http.post(Uri.parse(API_BASE_URL+API), body: body)
          .then((value) => value)
          .catchError((error) =>
          print("Doctor app Failed to signUp: $error"));
      data = jsonDecode(response.body);
    }
    else if(userType==1){
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
      http.Response response = await http
          .post(Uri.parse(API_BASE_URL+API), body: body)
          .then((value) => value)
          .catchError((error) =>
          print("Doctor app Failed to registerUserwithOtp: $error"));
      data = jsonDecode(response.body);
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
    return data;
  }


  static Future<String> verifyOtp(OtpModel model) async {
    var APIURLRegistration = 'https://cabeloclinic.com/website/medlife/php_auth_api/otp_verified.php';
    http.Response response = await http
        .post(Uri.parse(APIURLRegistration), body: model.toMap())
        .then((value) => value)
        .catchError(
            (error) => print("Colorgame Failed to getRegistration: $error"));
    var data = jsonDecode(response.body);
    return data[0]['success_code'];
  }
}
