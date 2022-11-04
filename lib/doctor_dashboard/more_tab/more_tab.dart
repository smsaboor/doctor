import 'dart:convert';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/avatar_image.dart';
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
import 'package:doctor/core/constants/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'package:doctor/doctor_dashboard/more_tab/widget/profile_list_item.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/core/constants/urls.dart';

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

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString('userDetails');
    setState(() {
      data = jsonStringToMap(user!);
    });
    _getImgeUrl(data == null ? '' : data['user_id']);
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

  var fetchUserData;
  String? textLanguages;
  String? textDegree;
  String? textSpeciality;

  getUserData() async {
    _getImgeUrl(widget.userID);
    setState(() {});
    var API =
        '${API_BASE_URL}fetch_profile_api.php';
    Map<String, dynamic> body = {
      'doctor_id': widget.userID,
    };
    modelLanguages3!.clear();
    modelSpeciality3!.clear();
    modelDegree3!.clear();
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
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
      if (textLanguages!.isEmpty) {
        modelLanguages3=[];
      } else {
        for (int i = 0; i < splitedTextL.length; i++) {
          modelLanguages3!.add(splitedTextL[i].toString());
        }
      }
      if (textDegree!.isEmpty) {
        modelDegree3=[];
      } else {
        for (int i = 0; i < splitedTextD.length; i++) {
          modelDegree3!.add(splitedTextD[i].toString());
        }
      }
      if (textSpeciality!.isEmpty) {
        modelSpeciality3=[];
      } else {
        for (int i = 0; i < splitedTextS.length; i++) {
          modelSpeciality3!.add(splitedTextS[i].toString());
        }
      }
    } else {}
  }

  var fetchImageData;

  void _getImgeUrl(String doctorId) async {
    fetchImageData = await ApiEditProfiles.getImageUrl(doctorId);
    if (fetchImageData[0]['image'] != '') {
      setState(() {
        uplaodImage = false;
      });
    } else {
      setState(() {
        uplaodImage = false;
      });
    }
  }

  Future<dynamic> getLanguages() async {
    var API =
        '${API_BASE_URL}languages_api.php';
    try {
      final response = await http.post(Uri.parse(API));
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<ModelLanguages> posts = List<ModelLanguages>.from(
            l.map((model) => ModelLanguages.fromJson(model)));
        for (int i = 0; i < posts.length; i++) {
          modelLanguages2!.add({
            'index': posts[i].language.toString(),
            'language': posts[i].language.toString()
          });
        }
        jsonLanguage =
            jsonEncode(modelLanguages2!.map((e) => e.toJson()).toList());
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
    var API = '${API_BASE_URL}degree_api.php';
    try {
      final response = await http.post(Uri.parse(API));
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<ModelDegrees> posts = List<ModelDegrees>.from(
            l.map((model) => ModelDegrees.fromJson(model)));
        for (int i = 0; i < posts.length; i++) {
          modelDegree2!.add({
            'index': posts[i].degree.toString(),
            'degree': posts[i].degree.toString()
          });
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

  Future<dynamic> getSpecialty() async {
    var API = '${API_BASE_URL}specialist_profile_api.php';
    try {
      final response = await http.post(Uri.parse(API));
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<ModelSpeciality> posts = List<ModelSpeciality>.from(
            l.map((model) => ModelSpeciality.fromJson(model)));
        for (int i = 0; i < posts.length; i++) {
          modelSpeciality2!.add({
            'index': posts[i].doctor_speciality.toString(),
            'speciality': posts[i].doctor_speciality.toString()
          });
        }
        jsonSpeciality = jsonEncode(modelSpeciality2!.map((e) => e.toJson()).toList());
        setState(() {
          flagAccess = false;
        });
      }
    } catch (e) {
      debugPrint('$e');
      return <ModelSpeciality>[];
    }
  }

  void getApiData() async {
    await getLanguages();
    await getDegrees();
    await getSpecialty();
    await getData();
    await getUserData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(414, 896),
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
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : fetchImageData[0]['image'] != ''
                          ? AvatarImagePD(
                              fetchImageData[0]['image'],
                              radius: kSpacingUnit.w * 5,
                            )
                          : AvatarImagePD(
                              AppUrls.user,
                              radius: kSpacingUnit.w * 5,
                            ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
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
            'Dr. ${data == null ? '' : (data['name'].length > 20
                ? data['name']
                .substring(0, 20) +
                '...'
                : data['name'] ?? '')}',
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          flagAccess
              ? Container(
                  height: kSpacingUnit.w * 4,
                  width: kSpacingUnit.w * 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                    color: Colors.amber,
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
                      color: Colors.amber,
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
          duration: const Duration(milliseconds: 200),
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
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          uplaodImage
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AvatarImagePD(
                    AppUrls.user,
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
              child: const ProfileListItem(
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
              child: const ProfileListItem(
                icon: LineAwesomeIcons.user,
                text: 'My Assistant',
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
              child: const ProfileListItem(
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
              child: const ProfileListItem(
                icon: LineAwesomeIcons.question_circle,
                text: 'About Medilipse',
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const About()));
              },
            ),
            GestureDetector(
              child: const ProfileListItem(
                icon: LineAwesomeIcons.user_shield,
                text: 'Privacy Policy',
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const PrivacyPolicy()));
              },
            ),
            GestureDetector(
              child: const ProfileListItem(
                icon: LineAwesomeIcons.book,
                text: 'Term & Condition',
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const TermsOfServices()));
              },
            ),
            GestureDetector(
              child: const ProfileListItem(
                icon: LineAwesomeIcons.alternate_sign_out,
                text: 'Logout',
                hasNavigation: false,
              ),
              onTap: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.setBool('isLogin', false);
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, RouteGenerator.signIn);
              },
            ),
          ],
        ),
      ),
    );
  }

  getAppBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: CustomAppBar(
        isleading: false,
      ),
    );
  }
}
