import 'dart:async';
import 'package:dio/dio.dart';
import 'package:doctor/core/constants/apis.dart';

class ProfileServices {
  static Future<bool> create(FormData data) async {
    try {
      Response response =
      await Dio().post("${API_BASE_URL}update_image_api.php",
        data: data,
      );
      if(response.statusCode==200){
        return true;
      }
      return false;
    } catch(e){

      return false;
    }
  }

  static Future<dynamic> fetch() async {
    try{
      var response = await Dio().get(
          "${API_BASE_URL}profiles"
      ).timeout(const Duration(seconds: 10));
      if(response.statusCode == 200) {
        return response.data;
      }
      else{
        // AppSnack.showSnack('Login fail','Invalid pin');
        return null;
      }
    } catch(e){
      return null;
    }
  }
}
