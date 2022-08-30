import 'dart:convert';
import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/api/api.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:doctor/doctor_dashboard/more_tab/about.dart';
import 'package:doctor/doctor_dashboard/more_tab/assistent/display_assistent.dart';
import 'package:doctor/doctor_dashboard/more_tab/change_password.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/edit_profile.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_degree.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_lang.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_speciality.dart';
import 'package:doctor/doctor_dashboard/more_tab/privacy_policy.dart';
import 'package:doctor/doctor_dashboard/more_tab/settings/setting.dart';
import 'package:doctor/doctor_dashboard/more_tab/terms_notes.dart';
import 'package:doctor/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'package:doctor/doctor_dashboard/more_tab/widget/profile_list_item.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class MoreTabDD extends StatefulWidget {
  MoreTabDD({required this.userData, required this.userID});

  final userID;
  final userData;

  @override
  State<MoreTabDD> createState() => _MoreTabDDState();
}

class _MoreTabDDState extends State<MoreTabDD> {
  var data;
  bool uplaodImage = true;
  var jsonLanguage;
  var jsonDegrees;
  var jsonSpeciality;

  bool flagAccess = true;
  List<dynamic>? modelLanguages2 = [];
  List<dynamic>? modelLanguages3 = [];
  List<dynamic>? modelDegree3 = [];
  List<dynamic>? modelSpeciality3 = [];
  List<dynamic>? modelDegree2 = [];
  List<dynamic>? modelSpeciality2 = [];

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString('userDetails');
    setState(() {
      data = jsonStringToMap(user!);
      print('data----------------------------$data');
      print('data----------------------------${data['user_id']}');
    });
    _getImgeUrl(data == null ? '' : data['user_id']);
  }

  var fetchUserData;
  String? textLanguages;
  String? textDegree;
  String? textSpeciality;

  void getUserData() async {
    _getImgeUrl(widget.userID);
    setState(() {});
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/fetch_profile_api.php';
    Map<String, dynamic> body = {
      'doctor_id': widget.userID,
    };
    modelLanguages3!.clear();
    modelSpeciality3!.clear();
    modelDegree3!.clear();
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to fetchProfileData: $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      fetchUserData = jsonDecode(response.body.toString());

      textLanguages = fetchUserData[0]['languages'].toString();
      textDegree = fetchUserData[0]['degree'].toString();
      textSpeciality = fetchUserData[0]['specialty'].toString();

      String firstTextL = textLanguages!;
      String firstTextD = textDegree!;
      String firstTextS = textSpeciality!;

      String finalStringL = firstTextL
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll(" ", "");
      String finalStringD = firstTextD
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll(" ", "");
      String finalStringS = firstTextS
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll(" ", "");

      final splitedTextL = finalStringL.split(',');
      final splitedTextD = finalStringD.split(',');
      final splitedTextS = finalStringS.split(',');
      for (int i = 0; i < splitedTextL.length; i++) {
        print('77777getUserData777777755$i--${splitedTextL[i].toString()}');
        modelLanguages3!.add(splitedTextL[i].toString());
      }
      for (int i = 0; i < splitedTextD.length; i++) {
        print('77777getUserData777777755$i--${splitedTextD[i].toString()}');
        modelDegree3!.add(splitedTextD[i].toString());
      }
      for (int i = 0; i < splitedTextS.length; i++) {
        print('77777getUserData777777755$i--${splitedTextS[i].toString()}');
        modelSpeciality3!.add(splitedTextS[i].toString());
      }
    } else {}
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
    if (fetchImageData[0]['image'] != '') {
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

  Future<dynamic> getLanguages() async {
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/languages_api.php';
    try {
      final response = await http.post(Uri.parse(API));
      if (response.statusCode == 200) {
        print('saboor---${response.body}');
        Iterable l = json.decode(response.body);
        List<ModelLanguages> posts = List<ModelLanguages>.from(
            l.map((model) => ModelLanguages.fromJson(model)));
        for (int i = 0; i < posts.length; i++) {
          modelLanguages2!.add({
            'index': i.toString(),
            'language': posts[i].language.toString()
          });
        }
        print('/modelLanguages2///////////////${modelLanguages2}');
        for (int i = 0; i < modelLanguages2!.length; i++) {
          print('========${modelLanguages2![i].language}');
        }
        jsonLanguage =
            jsonEncode(modelLanguages2!.map((e) => e.toJson()).toList());
        print('=jsonLanguage=======${jsonLanguage}');
        setState(() {
          flagAccess = false;
        });
      }
    } catch (e) {
      debugPrint('$e');
      return <ModelLanguages2>[];
    }
  }

  Future<dynamic> getDegrees() async {
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/degree_api.php';
    try {
      final response = await http.post(Uri.parse(API));
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<ModelDegrees> posts = List<ModelDegrees>.from(
            l.map((model) => ModelDegrees.fromJson(model)));
        for (int i = 0; i < posts.length; i++) {
          modelDegree2!.add(
              {'index': i.toString(), 'degree': posts[i].degree.toString()});
        }
        setState(() {
          flagAccess = false;
        });
      }
    } catch (e) {
      debugPrint('$e');
      return <ModelDegrees>[];
    }
  }

  Future<dynamic> getSpecialtyc() async {
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/specialist_profile_api.php';
    try {
      final response = await http.post(Uri.parse(API));
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<ModelSpeciality> posts = List<ModelSpeciality>.from(
            l.map((model) => ModelSpeciality.fromJson(model)));
        for (int i = 0; i < posts.length; i++) {
          modelSpeciality2!.add({
            'index': i.toString(),
            'speciality': posts[i].doctor_speciality.toString()
          });
        }
        print('/modelSpeciality2///////////////${modelSpeciality2}');
        for (int i = 0; i < modelSpeciality2!.length; i++) {
          print('========${modelSpeciality2![i].speciality}');
        }
        jsonSpeciality =
            jsonEncode(modelSpeciality2!.map((e) => e.toJson()).toList());
        print('=jsonSpeciality=======${jsonSpeciality}');

        setState(() {
          flagAccess = false;
        });
      }
    } catch (e) {
      debugPrint('$e');
      return <ModelSpeciality>[];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getUserData();
    getLanguages();
    getDegrees();
    getSpecialtyc();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );
    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (_) => EditProfileDD(
                                  intialValueLang: modelLanguages3,
                                  intialValueDegree: modelDegree3,
                                  intialValueSpec: modelSpeciality3,
                                  button: 'Save',
                                  language: modelLanguages2,
                                  degree: modelDegree2,
                                  specialities: modelSpeciality2,
                                  jsonSpeciality: jsonSpeciality,
                                  jsonDegrees: jsonDegrees,
                                  jsonLanguage: jsonLanguage,
                                  id: data == null ? '' : data['user_id'],
                                )))
                        .then((value) {
                      getUserData();
                      getAppBar();
                      });
                  },
                  child: uplaodImage
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : fetchImageData[0]['image'] != ''
                          ? AvatarImagePD(
                              fetchImageData[0]['image'],
                              radius: kSpacingUnit.w * 5,
                            )
                          : AvatarImagePD(
                              'https://www.kindpng.com/picc/m/198-1985282_doctor-profile-icon-png-transparent-png.png',
                              radius: kSpacingUnit.w * 5,
                            ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: kDarkPrimaryColor,
                        size: (ScreenUtil()
                            .setSp(kSpacingUnit.w * 1.5)
                            .toDouble()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            'Dr. ${data == null ? '' : data['name']}',
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          flagAccess
              ? Container(
                  height: kSpacingUnit.w * 4,
                  width: kSpacingUnit.w * 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Center(
                    child: Text(
                      'Please wait..',
                      style: kButtonTextStyle,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (_) => EditProfileDD(
                                  intialValueLang: modelLanguages3,
                                  intialValueDegree: modelDegree3,
                                  intialValueSpec: modelSpeciality3,
                                  button: 'Save',
                                  language: modelLanguages2,
                                  degree: modelDegree2,
                                  specialities: modelSpeciality2,
                                  jsonSpeciality: jsonSpeciality,
                                  jsonDegrees: jsonDegrees,
                                  jsonLanguage: jsonLanguage,
                                  id: data == null ? '' : data['user_id'],
                                )))
                        .then((value) {
                      getUserData();
                      getAppBar();
                    });
                  },
                  child: Container(
                    height: kSpacingUnit.w * 4,
                    width: kSpacingUnit.w * 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState:
              ThemeModelInheritedNotifier.of(context).theme == Brightness.light
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
            child: Icon(
              LineAwesomeIcons.sun,
              size: (ScreenUtil().setSp(kSpacingUnit.w * 3)).toDouble(),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
            child: Icon(
              LineAwesomeIcons.moon,
              size: (ScreenUtil().setSp(kSpacingUnit.w * 3)).toDouble(),
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileInfo,
        // themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: kSpacingUnit.w * 1),
            header,
            SizedBox(height: kSpacingUnit.w * 3),
            GestureDetector(
              child: ProfileListItem(
                icon: Icons.password,
                text: 'Change Password',
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChangePassword(
                          mobile: data == null ? '' : data['number'],
                          userType: data == null ? '' : data['user_type'],
                        )));
              },
            ),
            GestureDetector(
              child: ProfileListItem(
                icon: LineAwesomeIcons.user,
                text: 'My Assistent',
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DisplayAssistents(
                          doctorId: data == null ? '' : data['user_id'],
                          userData: widget.userData,
                        )));
              },
            ),
            GestureDetector(
              child: ProfileListItem(
                icon: LineAwesomeIcons.cog,
                text: 'Settings',
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SettingDD(
                          doctorId: data == null ? '' : data['user_id'],
                          userData: widget.userData,
                        )));
              },
            ),
            GestureDetector(
              child: ProfileListItem(
                icon: LineAwesomeIcons.question_circle,
                text: 'About Medeleaf',
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => About()));
              },
            ),
            GestureDetector(
              child: ProfileListItem(
                icon: LineAwesomeIcons.user_shield,
                text: 'Privacy Policy',
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => PrivacyPolicy()));
              },
            ),
            GestureDetector(
              child: ProfileListItem(
                icon: LineAwesomeIcons.book,
                text: 'Term & Condition',
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => TermsOfServices()));
              },
            ),
            GestureDetector(
              child: ProfileListItem(
                icon: LineAwesomeIcons.alternate_sign_out,
                text: 'Logout',
                hasNavigation: false,
              ),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setBool('isLogin', false);
                Navigator.pushReplacementNamed(context, RouteGenerator.signIn);
              },
            )
          ],
        ),
      ),
    );
  }

   getAppBar(){
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: CustomAppBar(
        isleading: false,
      ),
    );
  }
}
