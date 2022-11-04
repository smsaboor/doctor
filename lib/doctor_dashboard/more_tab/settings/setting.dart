import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingDD extends StatefulWidget {
  const SettingDD({Key? key, required this.doctorId, required this.userData})
      : super(key: key);
  final doctorId;
  final userData;

  @override
  _SettingDDState createState() => _SettingDDState();
}

class _SettingDDState extends State<SettingDD> {
  final TextEditingController _controllerNormalFees =
  TextEditingController();
  final TextEditingController _controllerEmergencyFees =
  TextEditingController();
  bool dataHomeFlag = true;
  var fetchData;
  var updateData;
  bool _switchValue = false;
  bool updateBooking = false;

  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  getSetting(int button) async {
    var API = '${API_BASE_URL}setting_api.php';
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      fetchData = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
        _controllerNormalFees.text = fetchData['doctor_fee'];
        _controllerEmergencyFees.text = fetchData['emergency_fees'];
      });
    } else {}
  }

  Future<void> updateSetting(int button) async {

    var API = '${API_BASE_URL}setting_api.php';
    Map<String, dynamic> body = {
      'doctor_fee': _controllerNormalFees.text,
      'emergency_fees': _controllerEmergencyFees.text,
      'doctor_id': widget.doctorId,
    };
    if (formKey.currentState!.validate()) {
      http.Response response = await http
          .post(Uri.parse(API), body: body)
          .then((value) => value)
          .catchError((error) => print(error));
      if (response.statusCode == 200) {
        updateData = jsonDecode(response.body.toString());
        CustomSnackBar.snackBar(
            context: context,
            data: button==1?'Normal Fees Updated Successfully !': 'Emergency Fees Updated Successfully !',
            color: Colors.green);
        setState(() {
          dataHomeFlag = false;
        });
        getSetting(button);
      } else {
        CustomSnackBar.snackBar(
            context: context,
            data: 'Fees Not Saved!',
            color: Colors.red);
      }
    }
  }

  bool emergencyFlag=true;
  var getEmergencyData;
  var emergencyData;
  bool indicatorF=false;


  Future<void> getEmergencyService() async {
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
    };
   var API = '${API_BASE_URL}emergency_api.php';
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      setState(() {
        getEmergencyData = jsonDecode(response.body.toString());
        if (getEmergencyData['emergency_status'] == "0") {
          setState(() {
            _switchValue = false;
            emergencyFlag = false;
          });
        } else {
          setState(() {
            _switchValue = true;
            emergencyFlag = false;
          });
        }
      });
    } else {}
  }

  Future<void> updateEmergencyService() async {
    updateBooking = true;
    String isSwitch;
    var API = '${API_BASE_URL}update_emergency_api.php';
    await getEmergencyService();
    if (getEmergencyData['emergency_status'] == "0") {
      isSwitch = '1';
    } else {
      isSwitch = '0';
    }
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
      'emergency_status': isSwitch,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) =>
        print(error));
    if (response.statusCode == 200) {
      getEmergencyService();
      emergencyData = jsonDecode(response.body.toString());
      if (getEmergencyData['emergency_status'] == "0") {
      setState(() {
        _switchValue = false;
        updateBooking = false;
      });
    CustomSnackBar.snackBar(
    context: context,
    data: 'Emergency Service On!',
    color: Colors.green);
    } else {
    setState(() {
    _switchValue = true;
    updateBooking = false;
    });
    CustomSnackBar.snackBar(
        context: context,
        data: 'Emergency Service Off!',
        color: Colors.red);
    }
  } else {}
}
  // Future<void> getEmergencyService() async {
  //   var API = '${API_BASE_URL}emergency_api.php';
  //   Map<String, dynamic> body = {
  //     'doctor_id': widget.doctorId,
  //   };
  //   http.Response response = await http
  //       .post(Uri.parse(API), body: body)
  //       .then((value) => value)
  //       .catchError((error) => print(error));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       getEmergencyData = jsonDecode(response.body.toString());
  //       if(getEmergencyData['emergency_status'].toString()=="0"){
  //         emergencyFlag = false;
  //       }else{
  //         emergencyFlag = false;
  //       }
  //     });
  //   } else {}
  // }
  // Future<void> updateEmergencyService() async {
  //   indicatorF=true;
  //   String setString;
  //   var API = '${API_BASE_URL}update_emergency_api.php';
  //   getEmergencyService();
  //   if(getEmergencyData['emergency_status'].toString()=="0"){
  //     setString ="1";
  //   }else{
  //     setString ="0";
  //   }
  //   Map<String, dynamic> body = {
  //     'doctor_id': widget.doctorId,
  //     'emergency_status':setString,
  //   };
  //   http.Response response = await http
  //       .post(Uri.parse(API), body: body)
  //       .then((value) => value)
  //       .catchError((error) => print(error));
  //   if (response.statusCode == 200) {
  //     getEmergencyData();
  //     setState(() {
  //       emergencyData = jsonDecode(response.body.toString());
  //       if(getEmergencyData['emergency_status']=='0'){
  //         emergencyFlag = false;
  //       }else{
  //         emergencyFlag = true;
  //       }
  //     });
  //   } else {}
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSetting(1);
    getEmergencyService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(isleading: false),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: Colors.blue,
              title: const Text("Setting"),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 380,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        dataHomeFlag
                            ? const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: SizedBox(
                              width: 100,
                              child: Center(
                                child: LinearProgressIndicator(),
                              )),
                            )
                            : const Text(''),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .9,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Theme(
                                    data: ThemeData(
                                      primaryColor: Colors.redAccent,
                                      primaryColorDark: Colors.red,
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          .60,
                                      child: TextFormField(
                                        controller: _controllerNormalFees,
                                        validator: (value) {
                                          if (value!.length>5) {
                                            return 'Limit 5 character';
                                          }
                                          if (int.parse(value)<1000) {
                                            return 'Greater then 1000';
                                          }
                                          if (value.isEmpty) {
                                            return 'Please Enter Fees';
                                          }
                                          return null;
                                        },
                                        textAlignVertical:
                                        TextAlignVertical.center,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 26.0,
                                            color: Colors.red),
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          // floatingLabelBehavior:
                                          //     FloatingLabelBehavior.never,
                                          contentPadding: EdgeInsets.all(8),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.orange)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                          labelText: 'Normal Fees',
                                          disabledBorder: InputBorder.none,
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .3,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      updateSetting(1);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        textStyle: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    child: const Text(
                                      'Save',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.01),
                        const Divider(
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Theme(
                                    data: ThemeData(
                                      primaryColor: Colors.redAccent,
                                      primaryColorDark: Colors.red,
                                    ),
                                    child: SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          .60,
                                      child: TextFormField(
                                        controller:
                                        _controllerEmergencyFees,
                                        validator: (value) {
                                          if (value!.length>5) {
                                            return 'Limit 5 character';
                                          }
                                          if (int.parse(value)<1000) {
                                            return 'Greater then 1000';
                                          }
                                          if (value.isEmpty) {
                                            return 'Please Enter Fees';
                                          }
                                          return null;
                                        },
                                        textAlignVertical:
                                        TextAlignVertical.center,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 26.0,
                                            color: Colors.red),
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide:  BorderSide(
                                                  color: Colors.orange)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                          labelText: 'Emergency Fees',
                                          disabledBorder: InputBorder.none,
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .3,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      updateSetting(2);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        textStyle: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    child: const Text(
                                      'Save',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: 80,
                            width: MediaQuery.of(context).size.width * .9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Emergency Service',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      _switchValue?'Active':'InActive',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                          color:_switchValue?Colors.green:Colors.red),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      const Text(
                                        'On/Off',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CupertinoSwitch(
                                        value: _switchValue,
                                        trackColor: Colors.red,
                                        activeColor: Colors.green,
                                        onChanged: (value) {
                                          setState(() {
                                            updateEmergencyService();
                                          });
                                        },
                                      ),
                                      updateBooking
                                          ? const SizedBox(
                                          width: 40,
                                          child: Center(
                                            child: LinearProgressIndicator(),
                                          ))
                                          : const Text('')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
