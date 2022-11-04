import 'package:doctor/core/constants/apis.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doctor/screens/auth/login/login.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({Key? key, required this.mobile})
      : super(key: key);
  final mobile;

  @override
  _CreatePasswordState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final TextEditingController _controllerOldPassword = TextEditingController();
  final TextEditingController _controllerNewPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name = ' ';
  String? number;
  bool changePasswordF = false;
  bool? _isHidden1 = true;
  bool? _isHidden2 = true;
  bool? _isHidden3 = true;

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    name = preferences.getString('name');
    number = preferences.getString('number');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        titleSpacing: 0,
        elevation: 0.0,
        title: Image.asset(
          'assets/img_2.png',
          width: 150,
          height: 90,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              AppBar(
                backgroundColor: Colors.blue,
                title: const Text("Create New Password"),
              ),
              const SizedBox(height: 25),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * .95,
                    height: 390,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Theme(
                            data: ThemeData(
                              primaryColor: Colors.redAccent,
                              primaryColorDark: Colors.red,
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              readOnly: false,
                              controller: _controllerNewPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter New Password';
                                }
                                else if (value!.length>8) {
                                  return 'Character Limit 8';
                                }
                                if (_controllerNewPassword.text ==
                                    _controllerOldPassword.text) {
                                  return 'Your Old and new Password is same';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              obscureText: _isHidden2! ? true : false,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal)),
                                  labelText: 'New Password',
                                  prefixText: ' ',
                                  prefixIcon: const Icon(
                                    Icons.lock_clock,
                                    color: Colors.blue,
                                  ),
                                  suffix: InkWell(
                                    onTap: _togglePasswordConfirmView2,
                                    child: Icon(
                                      _isHidden2!
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  suffixStyle:
                                  const TextStyle(color: Colors.green)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Theme(
                            data: ThemeData(
                              primaryColor: Colors.redAccent,
                              primaryColorDark: Colors.red,
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              readOnly: false,
                              controller: _controllerConfirmPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Confirm Password';
                                }
                                if (_controllerNewPassword.text !=
                                    _controllerConfirmPassword.text) {
                                  return 'Please Enter Correct Password';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              obscureText: _isHidden3! ? true : false,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal)),
                                  labelText: 'Confirm Password',
                                  prefixText: ' ',
                                  prefixIcon: const Icon(
                                    Icons.lock_clock,
                                    color: Colors.blue,
                                  ),
                                  suffix: InkWell(
                                    onTap: _togglePasswordConfirmView3,
                                    child: Icon(
                                      _isHidden3!
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  suffixStyle:
                                  const TextStyle(color: Colors.green)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .87,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                _changePassword(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              child: changePasswordF
                                  ? const Center(
                                child: CircularProgressIndicator(color: Colors.white,),
                              )
                                  : const Text(
                                "Change",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordConfirmView1() {
    setState(() {
      _isHidden1 = !_isHidden1!;
    });
  }

  void _togglePasswordConfirmView2() {
    setState(() {
      _isHidden2 = !_isHidden2!;
    });
  }

  void _togglePasswordConfirmView3() {
    setState(() {
      _isHidden3 = !_isHidden3!;
    });
  }

  Future<String> changePassword(
      {String? newPass,
        String? mobile}) async {
    print("data, $newPass, $mobile, ${_controllerConfirmPassword.text}");
    var APIURL =
        '${API_BASE_URL}forget_password_api.php';
    Map<String, dynamic> body = {
      'mobile': mobile,
      'confirm_password': _controllerConfirmPassword.text,
      'new_password': newPass,
    };
    http.Response response = await http
        .post(Uri.parse(APIURL), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    var data = jsonDecode(response.body);
    return data[0]['success_status'];
  }

  _changePassword(BuildContext context) async {
    setState(() {
      changePasswordF = true;
    });
    if (_formKey.currentState!.validate()) {
      String successStatus = await changePassword(
          mobile: widget.mobile,
          newPass: _controllerNewPassword.text,);
      if (successStatus == '1') {
        setState(() {
          changePasswordF = false;
        });

        CustomSnackBar.snackBar(
            context: context,
            data: 'Password Changed Successfully!',
            color: Colors.green);
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen(),
          ),
              (route) => false,
        );
      } else {
        setState(() {
          changePasswordF = false;
        });
        CustomSnackBar.snackBar(
            context: context, data: 'Failed to Change Password!', color: Colors.red);
      }
    }
  }

  _showDialog() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      borderSide: const BorderSide(
        color: Colors.green,
        width: 2,
      ),
      width: MediaQuery.of(context).size.width,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      showCloseIcon: true,
      title: 'Congratulation',
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      desc: 'Your Password is Changed Successfully.',
      btnOkOnPress: () {
        _controllerNewPassword.clear();
        _controllerOldPassword.clear();
        _controllerConfirmPassword.clear();
        Navigator.pop(context);
      },
    ).show();
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
      ),
    );
  }
}
