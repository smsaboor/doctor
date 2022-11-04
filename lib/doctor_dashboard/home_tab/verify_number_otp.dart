import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:doctor/doctor_dashboard/home_tab/add_patient.dart';
import 'package:doctor/service/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package1/CustomFormField.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  bool tryRegistration = false;
  bool isSubmitted = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerOtp = TextEditingController();

  late FocusNode text1, text2;
  String otp = '';

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

  int status = 0;

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          isleading: false,
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.blue,
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24, // Changing Drawer Icon Size
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
                title: Text("Register New Patient $otp"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
              ),
              SizedBox(height: size.height * 0.006),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              CustomFormField(
                  controlller: _controllerMobile,
                  errorMsg: 'Please Enter Patient Mobile',
                  labelText: 'Enter Patient Mobile',
                  readOnly: false,
                  icon: Icons.phone_android,
                  maxLimit: 10,
                  maxLimitError: '10',
                  textInputType: TextInputType.number),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              isSubmitted
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Theme(
                        data: ThemeData(
                          primaryColor: Colors.redAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: TextFormField(
                          focusNode: text2,
                          textInputAction: TextInputAction.next,
                          controller: _controllerOtp,
                          onChanged: (v) {
                            if (mounted) {
                              setState(() {
                                tryRegistration = false;
                              });
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Otp';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.teal)),
                              labelText: 'Enter Your Otp',
                              prefixText: ' ',
                              prefixIcon: Icon(
                                Icons.numbers,
                                color: Colors.blue,
                              ),
                              suffixStyle:
                                  TextStyle(color: Colors.green)),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _verifyPatentMobile(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: tryRegistration
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _verifyPatentMobile(BuildContext context) async {
    if (status == 0) {
      if (formKey.currentState!.validate()) {
        setState(() {
          tryRegistration = true;
        });
        var data = await ApiService.checkUserRegisteredInner(_controllerMobile.text);
        if (data['status'].toString() == '0') {
          setState(() {
            isSubmitted = true;
            tryRegistration = false;
            otp = data['otp'].toString();
            FocusScope.of(context).requestFocus(text2);
          });
          setState(() {
            status = 1;
          });
        } else if (data['status'].toString() == '1') {
          CustomSnackBar.snackBar(
              context: context,
              data: 'Sorry ! Mobile already registered',
              color: Colors.red);
        }
      }
    } else {
      if (formKey.currentState!.validate()) {
        setState(() {
          tryRegistration = true;
        });
        if (_controllerOtp.text == otp) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddPatient(mobile: _controllerMobile.text))).then((value){
            Navigator.pop(context);
          });
        } else {
          CustomSnackBar.snackBar(
              context: context, data: 'Wrong! Otp', color: Colors.red);
        }
      }
    }
  }

  buildPatientForm() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerOtp,
            errorMsg: 'Enter Otp',
            readOnly: false,
            labelText: 'Otp',
            icon: Icons.numbers,
            maxLimit: 30,
            maxLimitError: '30',
            textInputType: TextInputType.number),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }
}
