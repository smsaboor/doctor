import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:doctor/dashboard_patient/tabs/tab_profile/change_password.dart';
import 'package:doctor/doctor_dashboard/more_tab/change_password.dart';
import 'package:doctor/doctor_dashboard/more_tab/terms_notes.dart';
import 'package:doctor/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'package:doctor/doctor_dashboard/more_tab/widget/profile_list_item.dart';

class PatientProfilePD extends StatefulWidget {
  @override
  State<PatientProfilePD> createState() => _PatientProfilePDState();
}

class _PatientProfilePDState extends State<PatientProfilePD> {
  var data;
  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString('userDetails');
    setState(() {
      data = jsonStringToMap(user!);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: AssetImage('assets/images/img.png'),
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
            data==null?'sab':data['name'],
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            'nicolasadams@gmail.com',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Text(
                'Upgrade to PRO',
                style: kButtonTextStyle,
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
        // SizedBox(width: kSpacingUnit.w * 3),
        // Icon(
        //   LineAwesomeIcons.arrow_left,
        //   size: (ScreenUtil().setSp(kSpacingUnit.w * 3)).toDouble(),
        // ),
        profileInfo,
        // themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return data==null
        ? Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
        ))
        : ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: kSpacingUnit.w * 5),
                  header,
                  SizedBox(height: kSpacingUnit.w * 3),
                  GestureDetector(
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.user_shield,
                      text: 'Term and Conditions',
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => TermsOfServices()));
                    },
                  ),
                  GestureDetector(
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.history,
                      text: 'Appointment History',
                    ),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => AppointmentHistory()));
                    },
                  ),
                  GestureDetector(
                    child: ProfileListItem(
                      icon: Icons.password,
                      text: 'Change Password',
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>ChangePasswordPD()));
                    },
                  ),
                  GestureDetector(
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.question_circle,
                      text: 'Report Issue',
                    ),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => ReportIssu()));
                    },
                  ),
                  GestureDetector(
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.cog,
                      text: 'Settings',
                    ),
                    onTap: () {},
                  ),
                  GestureDetector(
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.user_plus,
                      text: 'Invite a Friend',
                      onTap: () {},
                    ),
                    onTap: () {
                      Share.share(
                          "Install Doctor App 'Medelipe'",
                          subject: 'Medelips!');
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
        },
      ),
    );
  }
}
