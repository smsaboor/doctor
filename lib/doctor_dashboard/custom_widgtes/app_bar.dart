import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
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

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString('userDetails');
    setState(() {
      data = jsonStringToMap(user!);
      print('data----------------------------$data');
      print('data----------------------------${data['user_id']}');
    });
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
      leading: widget.isleading?Builder(
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
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ):null,
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
              // Text(
              //   'MBBS',
              //   style: TextStyle(
              //     fontSize: 14.0,
              //     color: Colors.black,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AvatarImagePD(
            "https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
            radius: 35,
            height: 40,
            width: 40,
          ),
        ),
      ],
      title: Image.asset(
        'assets/img_2.png',
        width: 150,
        height: 90,
      ),
    );
  }
}
