import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/screens/auth/verify_otp.dart';
import 'package:doctor/service/api.dart';
import 'package:flutter/material.dart';

class HomeForgetPassword extends StatefulWidget {
  const HomeForgetPassword({Key? key}) : super(key: key);
  @override
  _HomeForgetPasswordState createState() => _HomeForgetPasswordState();
}

class _HomeForgetPasswordState extends State<HomeForgetPassword> {
  late FocusNode text1, text2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text1 = FocusNode();
    text2 = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    text1.dispose();
    text2.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _controllerMobile = TextEditingController();
  bool tryRegistration = false;
  bool isRegistered = false;
  int? status = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .15,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: Center(child: Image.asset('assets/logo2.png'))),
              SizedBox(
                height: MediaQuery.of(context).size.height * .13,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18.0, bottom: 15),
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xE1100A44),
                      fontSize: 26),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.redAccent,
                    primaryColorDark: Colors.red,
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    focusNode: text1,
                    controller: _controllerMobile,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Mobile';
                      }
                      else if (value!.length>10) {
                        return 'Character Limit 10';
                      }
                      return null;
                    },
                    onChanged: (v) {
                      setState(() {
                        tryRegistration = false;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                        labelText: 'Mobile',
                        prefixText: ' ',
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.blue,
                        ),
                        suffixStyle: TextStyle(color: Colors.green)),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    _verifyUser(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold)),
                  child: tryRegistration
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _verifyUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (mounted) {
        setState(() {
          tryRegistration = true;
        });
      }
      var data = await ApiService.checkUserRegisteredForgetPassword(_controllerMobile.text);
      setState(() {
        tryRegistration = false;
      });
      if (data['status'] == 1) {
        if (mounted) {
          setState(() {
            tryRegistration = false;
            isRegistered = true;
          });
        }
        if (!mounted) return;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => OtpVerification(
              otp: data['otp'],
              mobile: _controllerMobile.text,
              isForgetPassword: true,
            )));
      } else {
        if (mounted) {
          setState(() {
            tryRegistration = false;
            isRegistered = false;
          });
        }
        CustomSnackBar.snackBar(
            context: context, data: 'Phone Number is Invalid!', color: Colors.red);
      }
    }
  }

  bool _isEmailValidate(String txt) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(txt);
  }
}
