import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: Image.asset(
              'assets/logo2.png',
            ),
          ),
          // Text(
          //   'medilips',
          //   style: FlutterFlowTheme.title1.override(
          //     fontFamily: 'Cabin',
          //     color: Colors.blue,
          //     fontSize: MediaQuery.of(context).size.height * .05,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),)
    );
  }
}
