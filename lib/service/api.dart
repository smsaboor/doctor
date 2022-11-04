import 'package:doctor/core/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/model/model_doctor.dart';
import 'package:doctor/model/model_otp.dart';
import 'package:doctor/model/model_patient.dart';
import 'dart:convert';

class ApiService {
  static Future<dynamic> checkUserRegistered(String mobile) async {
    var Api = '${API_BASE_URL}register_api.php';
    Map<String, dynamic> body = {'mobile': mobile};
    http.Response response = await http
        .post(Uri.parse(Api), body: body)
        .then((value) => value)
        .catchError((error) =>
            print(error));
    var data = jsonDecode(response.body);
    return data;
  }

  static Future<dynamic> checkUserRegisteredForgetPassword(String mobile) async {
    var Api = '${API_BASE_URL}for_forget_register_api.php';
    Map<String, dynamic> body = {'mobile': mobile};
    http.Response response = await http
        .post(Uri.parse(Api), body: body)
        .then((value) => value)
        .catchError((error) =>
        print(error));
    var data = jsonDecode(response.body);
    return data;
  }
  static Future<dynamic> checkUserRegisteredInner(String mobile) async {
    var Api = '${API_BASE_URL}inner_register_api.php';
    Map<String, dynamic> body = {'mobile': mobile};
    http.Response response = await http
        .post(Uri.parse(Api), body: body)
        .then((value) => value)
        .catchError((error) =>
        print(error));
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
          print(error));
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
          print(error));
      data = jsonDecode(response.body);
    }
    return data['sucess_code'];
  }
  static Future<dynamic> login({String? mobile,String? pwd}) async {
    Map<String, dynamic> body = {
      'mobile': mobile,
      'password': pwd,
    };
    var Api = '${API_BASE_URL}login_api.php';
    http.Response response = await http
        .post(Uri.parse(Api), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    var data = jsonDecode(response.body);
    return data;
  }


  static Future<String> verifyOtp(OtpModel model) async {
    var Api = '${API_BASE_URL}otp_verified.php';
    http.Response response = await http
        .post(Uri.parse(Api), body: model.toMap())
        .then((value) => value)
        .catchError(
            (error) => print(error));
    var data = jsonDecode(response.body);
    return data[0]['success_code'];
  }
}
