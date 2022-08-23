import 'dart:convert';

import 'package:doctor/doctor_dashboard/appointments/save_consult/model_pills.dart';
import 'package:http/http.dart' as http;

class PillsApi{
  var dataPills;
  bool dataPillsFlag = true;
  List<String> pillsList = [];

 Future<List<String>> getAllPills() async {
    print('.getAllPills ..............................');
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/pills_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(" Failed to getAllPills $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      print('..getAllPills....${response.body}');
      Iterable l = jsonDecode(response.body.toString());
      List<ModelPills> pillss = List<ModelPills>.from(
          l.map((model) => ModelPills.fromJson(model)));

      for (int i = 0; i < pillss.length; i++) {
        print('////////////////////${pillsList[i]}');
      }
      for (int i = 0; i < pillss.length; i++) {
        print('////////////////////${pillsList[i]}');
        pillsList.add('${pillsList[i]}');
      }
      return pillsList;
    } else {
      return [];
    }

  }
}