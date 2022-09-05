import 'dart:async';

import 'package:dio/dio.dart';
const baseURL = 'https://cabeloclinic.com/website/medlife/php_auth_api';
class ProfileServices {
  static Future<bool> create(FormData data) async {
    print('/8/8/8/8/8/8/8/8//8/8//8/8/8/8/8//8 ');
    try {
      Response response =
      await Dio().post(
        "https://cabeloclinic.com/website/medlife/php_auth_api/update_image_api.php",
        data: data,
      );
      if(response.statusCode==200){
        print('/8/8/8/8/8/8/8/8//8/8//8/8/8/8/8//8         Successfully');
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
          "$baseURL/profiles"
      ).timeout(Duration(seconds: 10));
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
