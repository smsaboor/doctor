import 'dart:convert';
import 'package:doctor/core/constants.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/model_pills.dart';
import 'package:http/http.dart' as http;

class PillsApi{
  var dataPills;
  bool dataPillsFlag = true;
  List<String> pillsList = [];

 Future<List<String>> getAllPills() async {
    var API = '${API_BASE_URL}pills_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body.toString());
      List<ModelPills> pillss = List<ModelPills>.from(
          l.map((model) => ModelPills.fromJson(model)));

      for (int i = 0; i < pillss.length; i++) {
        print('${pillsList[i]}');
      }
      for (int i = 0; i < pillss.length; i++) {
        pillsList.add('${pillsList[i]}');
      }
      return pillsList;
    } else {
      return [];
    }

  }
}