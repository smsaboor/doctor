import 'package:flutter/material.dart';
class AppColors {
  static const defaultColor = Colors.deepOrange;
  static const mainColor = Color(0xFFfc6011);
  static const primaryFontColor = Color(0xFF4a4b4d);
  static const secondaryFontColor = Color(0xFF7c7d7e);
  static const placeholder = Color(0xFF959696);
  static const themeColor = Color(0xfff5a623);
  static Color primaryColor = const Color(0xffffa500);
  static Color secondaryColor = Colors.purple;
  static Color blackGrey = const Color.fromARGB(255, 39, 39, 39);
  static Color backgroundBlack = const Color.fromARGB(255, 37, 37, 37);
  static Color backgroundWhite = const Color.fromARGB(255, 255, 255, 255);
  static Color backgroundGray = const Color.fromARGB(255, 240, 240, 240);
  static const greyColor = Color(0xffaeaeae);
  static const greyColor2 = Color(0xffE8E8E8);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color initial = Color.fromRGBO(23, 43, 77, 1.0);
  static const Color primary = Color.fromRGBO(94, 114, 228, 1.0);
  static const Color secondary = Color.fromRGBO(247, 250, 252, 1.0);
  static const Color label = Color.fromRGBO(254, 36, 114, 1.0);
  static const Color info = Color.fromRGBO(17, 205, 239, 1.0);
  static const Color error = Color.fromRGBO(245, 54, 92, 1.0);
  static const Color success = Color.fromRGBO(45, 206, 137, 1.0);
  static const Color warning = Color.fromRGBO(251, 99, 64, 1.0);
  static const Color header = Color.fromRGBO(82, 95, 127, 1.0);
  static const Color bgColorScreen = Color.fromRGBO(248, 249, 254, 1.0);
  static const Color border = Color.fromRGBO(202, 209, 215, 1.0);
  static const Color inputSuccess = Color.fromRGBO(123, 222, 177, 1.0);
  static const Color inputError = Color.fromRGBO(252, 179, 164, 1.0);
  static const Color muted = Color.fromRGBO(136, 152, 170, 1.0);
  static const Color text = Color.fromRGBO(50, 50, 93, 1.0);

  static Map<int, Color> swatchColor = {
    50: themeColor.withOpacity(0.1),
    100: themeColor.withOpacity(0.2),
    200: themeColor.withOpacity(0.3),
    300: themeColor.withOpacity(0.4),
    400: themeColor.withOpacity(0.5),
    500: themeColor.withOpacity(0.6),
    600: themeColor.withOpacity(0.7),
    700: themeColor.withOpacity(0.8),
    800: themeColor.withOpacity(0.9),
    900: themeColor.withOpacity(1),
  };
  static MaterialColor primarySwatch = const MaterialColor(
    0xFF1C3E66,
    {
      50: Color(0xFF8e9fb3),
      100: Color(0xFF778ba3),
      200: Color(0xFF607894),
      300: Color(0xFF496585),
      400: Color(0xFF335175),
      500: Color(0xFF1C3E66),
      600: Color(0xFF19385c),
      700: Color(0xFF163252),
      800: Color(0xFF142b47),
      900: Color(0xFF11253d),
    },
  );

}
