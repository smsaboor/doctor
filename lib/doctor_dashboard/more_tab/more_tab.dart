import 'dart:convert';
import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
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
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'package:doctor/doctor_dashboard/more_tab/widget/profile_list_item.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class MoreTabDD extends StatefulWidget {
  MoreTabDD({required this.userData});

  final userData;

  @override
  State<MoreTabDD> createState() => _MoreTabDDState();
}

class _MoreTabDDState extends State<MoreTabDD> {
  var data;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString('userDetails');
    setState(() {
      data = jsonStringToMap(user!);
      print('data----------------------------$data');
      print('data----------------------------${data['user_id']}');
    });
    // print('..data: ${data}');
    // print('..data: ${data['name']}');
    // print('...runtime:${data.runtimeType}');
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

  static List<ModelLanguages> languages = <ModelLanguages>[];
  static List<ModelDegrees> degrees = <ModelDegrees>[];
  static List<ModelSpeciality> specialities = <ModelSpeciality>[];

  List<MultiSelectItem<ModelSpeciality?>>? _itemsSpecialities;
  List<MultiSelectItem<ModelLanguages?>>? _itemsLanguages;
  List<MultiSelectItem<ModelDegrees?>>? _itemsDigrees;

  bool flagAccess = true;

  Future<dynamic> getLanguages() async {
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/languages_api.php';
    try {
      final response = await http.post(Uri.parse(API));
      if (response.statusCode == 200) {
        print('saboor---${response.body}');
        Iterable l = json.decode(response.body);
        List<ModelLanguages> posts = List<ModelLanguages>.from(
            l.map((model) => ModelLanguages.fromJson(model)));
        languages = posts;
        _itemsLanguages = languages
            .map(
                (lang) => MultiSelectItem<ModelLanguages>(lang, lang.language!))
            .toList();
        for (int i = 0; i < posts.length; i++) {
          print('////////////////////${posts[i].language}');
        }
        setState(() {
          flagAccess = false;
        });
      }
    } catch (e) {
      debugPrint('$e');
      return <ModelLanguages>[];
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
        degrees = posts;
        _itemsDigrees = degrees
            .map((lang) => MultiSelectItem<ModelDegrees>(lang, lang.degree!))
            .toList();
        for (int i = 0; i < posts.length; i++) {
          print('////////////////////${posts[i].degree}');
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
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/specialist_profile_api.php';
    try {
      final response = await http.post(Uri.parse(API));
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<ModelSpeciality> posts = List<ModelSpeciality>.from(
            l.map((model) => ModelSpeciality.fromJson(model)));
        specialities = posts;
        _itemsSpecialities = specialities
            .map((lang) => MultiSelectItem<ModelSpeciality>(lang, lang.doctor_speciality!))
            .toList();
        for (int i = 0; i < posts.length; i++) {
          print('////////////////////${posts[i].doctor_speciality}');
        }
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => EditProfileDD(
                              button: 'Save',
                              language: _itemsLanguages,
                              degree: _itemsDigrees,
                              specialities: _itemsSpecialities,
                              id: data == null ? '' : data['user_id'],
                            )));
                  },
                  child: CircleAvatar(
                    radius: kSpacingUnit.w * 5,
                    backgroundImage: AssetImage('assets/images/user.jpg'),
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
          Text(
            'n@gmail.c',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => EditProfileDD(
                        button: 'Save',
                        language: _itemsLanguages,
                        degree: _itemsDigrees,
                        specialities: _itemsSpecialities,
                        id: data == null ? '' : data['user_id'],
                      )));
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(isleading: false,),),
      body: SingleChildScrollView(
        child: flagAccess
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                                doctorId: data == null ? '' : data['user_id'],userData: widget.userData,
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
                          builder: (_) => SettingDD(doctorId: data == null ? '' : data['user_id'],userData: widget.userData,)));
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => PrivacyPolicy()));
                    },
                  ),
                  GestureDetector(
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.book,
                      text: 'Term & Condition',
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => TermsOfServices()));
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
                      Navigator.pushReplacementNamed(
                          context, RouteGenerator.signIn);
                    },
                  )
                ],
              ),
      ),
    );
  }
}
