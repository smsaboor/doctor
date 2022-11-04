import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:http/http.dart' as http;
class ApiEditProfiles{
  static var updateProfileData;

  static updateProfile({String? doctorid,String? name,String? emeNo,String? degree,String? lang,String? lic_no,
    String? exper,String? spec,String? expe,String? address
  }) async {
    var API = '${API_BASE_URL}update_profile_api.php';
    Map<String, dynamic> body = {
      'doctor_id': doctorid,
      'name': name,
      'emergency_number': emeNo,
      'degree': degree,
      'language': lang,
      'experience': expe,
      'speciality': spec,
      'licence_no': lic_no,
      'address': address,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      updateProfileData = jsonDecode(response.body.toString());
    } else {}
  }

  static bool fetchImageF=true;
  static dynamic getImageUrl(String doctorId)async{
    var fetchImageData;
    var API = '${API_BASE_URL}fetch_image_api.php';
    Map<String, dynamic> body = {'doctor_id': doctorId};
    http.Response response = await http
        .post(Uri.parse(API),body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      fetchImageData = jsonDecode(response.body.toString());
      fetchImageF=false;
    } else {}
    return fetchImageData;
  }
}