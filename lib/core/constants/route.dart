import 'package:flutter/material.dart';
import 'package:doctor/screens/auth/login/login.dart';
import 'package:doctor/screens/auth/registration/registration.dart';
import 'package:doctor/splash_screen.dart';



class RouteGenerator {
  static const String bottomNavScreen = '/tab';
  static const String homeScreen = '/home';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String userDetail = '/userDetail';
  static const String otp = '/otp';
  static const String pwdReset = '/pwdReset';
  static const String otpConfirm = '/pwdReset';
  static const String intro = '/';
  static const String splash = '/splash';
  static const String loading = '/loading';
  static const String error = '/error';
  RouteGenerator._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intro:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loading:
        return MaterialPageRoute(builder: (_) => Container());
      case error:
        return MaterialPageRoute(builder: (_) => Container());
      case signIn:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen(mobile: 1010,));
      case userDetail:
        return MaterialPageRoute(builder: (_) => Container());
    // case otp:
    //   return MaterialPageRoute(builder: (_) => OtpScreen(mobile: mobile));
      case pwdReset:
        return MaterialPageRoute(builder: (_) => Container());
      case bottomNavScreen:
        return MaterialPageRoute(builder: (_) => Container());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => Container());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
