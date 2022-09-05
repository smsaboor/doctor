import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key, required this.isleading}) : super(key: key);
  final isleading;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  var data;
  bool uplaodImage = true;
  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString('userDetails');
    setState(() {
      data = jsonStringToMap(user!);
      print('data----------------------------$data');
      print('data----------------------------${data['user_id']}');
    });
    _getImgeUrl(data['user_id']);
  }

  jsonStringToMap(String data) {
    List<String> str = data
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll("\"", "")
        .replaceAll("'", "")
        .split(",");
    Map<String, dynamic> result = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result;
  }



  var fetchImageData;

  void _getImgeUrl(String doctorId) async {
    fetchImageData = await ApiEditProfiles.getImgeUrl(doctorId);
    print('%%%%%%%%%%%%%%${fetchImageData}');
    if (fetchImageData[0]['image'] !='') {
      print('%%%%%%%%%%%%%%${fetchImageData}');
      setState(() {
        uplaodImage = false;
      });
    } else {
      setState(() {
        uplaodImage = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // leadingWidth: 8,
      // leading: Icon(Icons.android),
      leading: widget.isleading
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 24, // Changing Drawer Icon Size
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            )
          : null,
      backgroundColor: Colors.white,
      bottomOpacity: 0.0,
      titleSpacing: 0,
      elevation: 0.0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data == null ? 'Dr.' : 'Dr. ${data['name']} ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        uplaodImage
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: AvatarImagePD(
                  "https://www.kindpng.com/picc/m/198-1985282_doctor-profile-icon-png-transparent-png.png",
                  radius: 35,
                  height: 40,
                  width: 40,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: AvatarImagePD(
                  fetchImageData[0]['image'],
                  radius: 35,
                  height: 40,
                  width: 40,
                ),
              )
      ],
      title: Image.asset(
        'assets/img_2.png',
        width: 150,
        height: 90,
      ),
    );
  }
}
