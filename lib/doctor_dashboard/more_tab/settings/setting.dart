import 'dart:convert';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
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
      new TextEditingController();
  final TextEditingController _controllerEmergencyFees =
      new TextEditingController();
  bool dataHomeFlag = true;
  var fetchData;
  var updateData;

  getSetting(int button) async {
    if(button==1){
      _controllerNormalFees.text = '0';
    }
    else{
      _controllerEmergencyFees.text = '0';
    }
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/setting_api.php';
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getSetting: $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      print('..getSetting22222222222222222222222222222222....${response.body}');
      fetchData = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
        _controllerNormalFees.text = fetchData['doctor_fee'];
        _controllerEmergencyFees.text = fetchData['emergency_fees'];
      });
      print(
          '..getSetting22222222222222222222222222222222....${fetchData.length}');
      print('..getSetting2222222222222222222222222222data....${fetchData}');
    } else {}
  }

  Future<void> updateSetting(int button) async {
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/setting_api.php';
    Map<String, dynamic> body = {
      'doctor_fee': _controllerNormalFees.text,
      'emergency_fees': _controllerEmergencyFees.text,
      'doctor_id': widget.doctorId,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to update Setting: $error"));
    if (response.statusCode == 200) {
      updateData = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
      });
      getSetting(button);
    } else {}
  }

  bool? emergencyFlag;
  var getEmergencyData;
  var emergencyData;
  bool indicatorF=false;
  Future<void> getEmergencyService() async {
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/emergency_api.php';
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to update getEmergencyData: $error"));
    if (response.statusCode == 200) {
      setState(() {
        getEmergencyData = jsonDecode(response.body.toString());
        if(getEmergencyData['emergency_status'].toString()=="0"){
          emergencyFlag = false;
        }else{
          emergencyFlag = true;
        }
      });
    } else {}
  }
  Future<void> updateEmergencyService() async {
    indicatorF=true;
    String setString;
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/update_emergency_api.php';
    getEmergencyService();
    if(getEmergencyData['emergency_status'].toString()=="0"){
      setString ="1";
    }else{
      setString ="0";
    }
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
      'emergency_status':setString,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to update updateEmergencyService: $error"));
    if (response.statusCode == 200) {
      getEmergencyData();
      setState(() {
        emergencyData = jsonDecode(response.body.toString());
        if(getEmergencyData['emergency_status']=='0'){
          emergencyFlag = false;
        }else{
          emergencyFlag = true;
        }
      });
    } else {}
  }

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(isleading: false),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: Colors.blue,
              title: Text("Setting"),
            ),
            SizedBox(
              height: 15,
            ),
            dataHomeFlag
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 15),
                        child: Column(
                          children: [
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
                                        data: new ThemeData(
                                          primaryColor: Colors.redAccent,
                                          primaryColorDark: Colors.red,
                                        ),
                                        child: SizedBox(
                                          height: 70,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .60,
                                          child: new TextFormField(
                                            controller: _controllerNormalFees,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 26.0,
                                                color: Colors.red),
                                            keyboardType: TextInputType.number,
                                            decoration: new InputDecoration(
                                              // floatingLabelBehavior:
                                              //     FloatingLabelBehavior.never,
                                              contentPadding: EdgeInsets.all(8),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
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
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      height: 45,
                                      child: Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            updateSetting(1);
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SuccessScreen()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.blue,
                                              textStyle: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold)),
                                          child: Text(
                                            'Save',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
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
                            Divider(
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
                                        data: new ThemeData(
                                          primaryColor: Colors.redAccent,
                                          primaryColorDark: Colors.red,
                                        ),
                                        child: SizedBox(
                                          height: 70,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .60,
                                          child: new TextFormField(
                                            controller:
                                                _controllerEmergencyFees,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 26.0,
                                                color: Colors.red),
                                            keyboardType: TextInputType.number,
                                            decoration: new InputDecoration(
                                              // floatingLabelBehavior:
                                              //     FloatingLabelBehavior.never,
                                              contentPadding: EdgeInsets.all(8),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
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
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      height: 45,
                                      child: Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            updateSetting(2);
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SuccessScreen()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.blue,
                                              textStyle: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold)),
                                          child: Text(
                                            'Save',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
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
                                    Column(
                                      children: [
                                        Text(
                                          'Emergency Service',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          '${getEmergencyData['emergency_status']=="0" ?'InActive':'Active'}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                              color: getEmergencyData['emergency_status']=='0'?Colors.red:Colors.green),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      height: 45,
                                      child: Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            updateEmergencyService();
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SuccessScreen()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: getEmergencyData['emergency_status'].toString()=='0'?Colors.green: Colors.red,
                                              textStyle: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold)),
                                          child: Text(
                                            getEmergencyData['emergency_status'].toString()=='0'?'Activate':'Left',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
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
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }
}
