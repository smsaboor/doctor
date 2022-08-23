import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiEditProfiles{
  static var updateProfileData;

  static updateProfile({String? doctorid,String? name,String? emeNo,String? degree,String? lang,String? lic_no,
    String? exper,String? spec,String? expe,String? address
  }) async {
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/update_profile_api.php';
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
        .catchError((error) => print(" Failed to updateProfile: $error"));
    print('.......updateProfile${response.body}');
    if (response.statusCode == 200) {
      print('..updateProfile 22222222222222222222222222222222....${response.body}');
      updateProfileData = jsonDecode(response.body.toString());
      print('..updateProfile 22222222222222222222222222222222....${updateProfileData.length ?? 0}');
    } else {}
  }

static bool fetchImageF=true;
  static dynamic getImgeUrl(String doctorId)async{
    var fetchImageData;
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/fetch_image_api.php';
    Map<String, dynamic> body = {'doctor_id': doctorId};
    http.Response response = await http
        .post(Uri.parse(API),body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getAllAssitents: $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      print('..22222222222222222222222222222222....${response.body}');
      fetchImageData = jsonDecode(response.body.toString());
      fetchImageF=false;
    } else {}
    return fetchImageData;
  }
}