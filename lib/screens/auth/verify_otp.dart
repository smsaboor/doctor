import 'package:flutter/material.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/model/model_otp.dart';
import 'package:doctor/route.dart';
import 'package:doctor/screens/auth/registration/registration.dart';
import 'package:doctor/service/api.dart';


class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key, required this.otp, this.mobile})
      : super(key: key);
  final otp, mobile;

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  _OtpVerificationState();

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  late FocusNode text1, text2, text3, text4;

  @override
  void initState() {
    super.initState();
    text1 = FocusNode();
    text2 = FocusNode();
    text3 = FocusNode();
    text4 = FocusNode();
  }


  @override
  void dispose() {
    text1.dispose();
    text2.dispose();
    text3.dispose();
    text4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    SizedBox(width: 80, child: Image.asset('assets/logo2.png')),
                    // SizedBox(
                    //     height: 40,
                    //     width: 80,
                    //     child: Image.asset('assets/img_4.png'))
                    // Text(
                    //   'medilipse',
                    //   style: FlutterFlowTheme.title1.override(
                    //     fontFamily: 'Cabin',
                    //     color: Colors.blue,
                    //     fontSize: MediaQuery.of(context).size.height * .02,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Verify OTP",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xE1100A44),
                  fontSize: 36),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Enter 4 digit code\nsend on ${widget.otp} ",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black45,
                  fontSize: 20),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          _boxBuilder(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              height: 50,
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    _verify();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => RegistrationScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  child: Text(
                    "Verify",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _verify() async {
    if (formKey.currentState!.validate()) {
      print('-----------------------------------1');
      String otp = _controller1.text +
          _controller2.text +
          _controller3.text +
          _controller4.text;
      print('-------------${widget.otp}------------------$otp----1');
      if (widget.otp.toString() == otp.toString()) {
        CustomSnackBar.snackBar(
            context: context,
            data: 'Otp Verified Successfully !',
            color: Colors.green);
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignUpScreen(mobile: widget.mobile,)));
      } else {
        CustomSnackBar.snackBar(
            context: context, data: 'Wrong otp!', color: Colors.red);
      }
    }
  }

  Widget _boxBuilder(BuildContext context) {
    return Form(
        key: formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _box(context, _controller1, true, text1, text2),
            _box(context, _controller2, false, text2, text3),
            _box(context, _controller3, false, text3, text4),
            _box(context, _controller4, false, text4, text1),
          ],
        ));
  }

  Widget _box(BuildContext context, TextEditingController customController,
      bool focus, FocusNode text, FocusNode changeFocus) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2.5),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 14,
      width: MediaQuery.of(context).size.width / 8,
      child: Center(
        child: TextField(
          autofocus: focus,
          focusNode: text,
          onChanged: (value) {
            if (value.length > 0) {
              FocusScope.of(context).requestFocus(changeFocus);
            }
          },
          cursorHeight: 40,
          controller: customController,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              contentPadding: const EdgeInsets.all(20)),
        ),
      ),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue, width: 1)),
    );
  }
}
