import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:doctor/dashboard_patient/home_patient_dashboard.dart';
import 'package:doctor/doctor_dashboard/home_doctor_dashboard.dart';
import 'package:doctor/doctor_dashboard/more_tab/constant.dart';
import 'package:flutter/material.dart';
import 'package:doctor/screens/auth/login/login.dart';
import 'package:doctor/splash_screen.dart';
import 'package:doctor/route.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final isLogin = preferences.getBool('isLogin') ?? false;
  final isFirst = preferences.getBool('onboarding') ?? true;
  final userType = preferences.getString('userType') ?? '1';
  runApp(MyApp(
    isFirst: isFirst,
    isLogin: isLogin,
    userType: userType,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.isFirst, this.isLogin, this.userType})
      : super(key: key);
  final isFirst, isLogin;
  final userType;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 4), () => setState(() => displaySplashImage = false));
  }

  final fontFamily = 'Poppins';
  bool displaySplashImage = true;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            builder: (context, child) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, child!),
                maxWidth: 1200,
                minWidth: 450,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(450, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
                background: Container(color: const Color(0xFFF5F5F5))),
            title: 'medilife',
            debugShowCheckedModeBanner: false,
            theme: ThemeModelInheritedNotifier.of(context).theme,
            home: displaySplashImage
                ? SplashScreen()
                : widget.isLogin
                    ? widget.userType == '2'
                        ? DoctorDashBoard()
                        : PatientDashboard()
                    : LoginScreen(),
            onGenerateRoute: (route) => RouteGenerator.generateRoute(route),
          );
        },
      ),
    );
  }
}
