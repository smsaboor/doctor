import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/model_pill_repeat_time.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/model_pills.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/model_pills_dose.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/model_pills_power.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/model_pills_timing.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/model_pills_type.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddDozesDD extends StatefulWidget {
  const AddDozesDD({Key? key, required this.button, required this.appNo})
      : super(key: key);
  final button, appNo;
  @override
  _AddDozesDDState createState() => _AddDozesDDState();
}

class _AddDozesDDState extends State<AddDozesDD> {
  final TextEditingController _controllerComment = TextEditingController();

  var dataPills;
  bool dataPillsFlag = true;

  bool dataAddDosesF = false;
  var dataAddDoses;

  void addDoses(String appNo) async {
    setState(() {
      dataAddDosesF = true;
    });
    var API = '${API_BASE_URL}add_dose_api.php';
    Map<String, dynamic> body = {
      'appointment_no': appNo,
      'pills_name': pills,
      'pills_type': pillsType,
      'pills_power': pillsPower,
      'pills_dose': pillsDose,
      'pills_timing': pillsTiming,
      'pills_repeat_timing': pillsRepeatTiming,
      'note': _controllerComment.text,
    };
        http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      setState(() {
        dataAddDosesF = false;
      });
      dataAddDoses = jsonDecode(response.body.toString());
    } else {}
  }


  String? pills = '';
  List<String> pillsList = [];

  Future<void> getAllPills() async {
    var API = '${API_BASE_URL}pills_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body.toString());
      List<ModelPills> pillss =
          List<ModelPills>.from(l.map((model) => ModelPills.fromJson(model)));
      for (int i = 0; i < pillss.length; i++) {
        print('////////////////////${pillss[i].pills}');
      }
      for (int i = 0; i < pillss.length; i++) {
        pillsList.add('${pillss[i].pills}');
      }
      setState(() {
        dataPillsFlag = false;
        pills = pillss[0].pills;
      });
    } else {}
  }



  String? pillsType = '';
  List<String> pillsTypeList = [];

  Future<void> getAllPillsType() async {
    var API = '${API_BASE_URL}pills_type_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body.toString());
      List<ModelPillsType> pillss =
          List<ModelPillsType>.from(l.map((model) => ModelPillsType.fromJson(model)));
      for (int i = 0; i < pillss.length; i++) {
        print('${pillss[i].pills_type}');
      }
      for (int i = 0; i < pillss.length; i++) {
        pillsTypeList.add('${pillss[i].pills_type}');
      }
      setState(() {
        dataPillsFlag = false;
        pillsType = pillss[0].pills_type;
      });
    } else {}
  }

  String? pillsPower = '';
  List<String> pillsPowerList = [];

  Future<void> getAllPillsPower() async {
    var API = '${API_BASE_URL}pills_power_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body.toString());
      List<ModelPillsPower> pillss =
      List<ModelPillsPower>.from(l.map((model) => ModelPillsPower.fromJson(model)));
      for (int i = 0; i < pillss.length; i++) {
        print('${pillss[i].pills_power}');
      }
      for (int i = 0; i < pillss.length; i++) {
        pillsPowerList.add('${pillss[i].pills_power}');
      }
      setState(() {
        dataPillsFlag = false;
        pillsPower = pillss[0].pills_power;
      });
    } else {}
  }



  String? pillsDose = '';
  List<String> pillsDoseList = [];

  Future<void> getAllPillsDose() async {
    var API = '${API_BASE_URL}pills_dose_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body.toString());
      List<ModelPillsDose> pillss =
      List<ModelPillsDose>.from(l.map((model) => ModelPillsDose.fromJson(model)));
      for (int i = 0; i < pillss.length; i++) {
        print('${pillss[i].pills_dose}');
      }
      for (int i = 0; i < pillss.length; i++) {
        pillsDoseList.add('${pillss[i].pills_dose}');
      }
      setState(() {
        dataPillsFlag = false;
        pillsDose = pillss[0].pills_dose;
      });
    } else {}
  }


  String? pillsTiming = '';
  List<String> pillsTimingList = [];

  Future<void> getAllPillsTiming() async {
    var API = '${API_BASE_URL}pills_timing_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body.toString());
      List<ModelPillsTiming> pillss =
      List<ModelPillsTiming>.from(l.map((model) => ModelPillsTiming.fromJson(model)));
      for (int i = 0; i < pillss.length; i++) {
        print('${pillss[i].pills_timing}');
      }
      for (int i = 0; i < pillss.length; i++) {
        pillsTimingList.add('${pillss[i].pills_timing}');
      }
      setState(() {
        dataPillsFlag = false;
        pillsTiming = pillss[0].pills_timing;
      });
    } else {}
  }


  String? pillsRepeatTiming = '';
  List<String> pillsRepeatTimingList = [];

  Future<void> getAllPillsRepeatTiming() async {
    var API = '${API_BASE_URL}pills_repeat_timing_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body.toString());
      List<ModelPillsRepeatTime> pillss =
      List<ModelPillsRepeatTime>.from(l.map((model) => ModelPillsRepeatTime.fromJson(model)));
      for (int i = 0; i < pillss.length; i++) {
        print('${pillss[i].repeat_time}');
      }
      for (int i = 0; i < pillss.length; i++) {
        pillsRepeatTimingList.add('${pillss[i].repeat_time}');
      }
      setState(() {
        dataPillsFlag = false;
        pillsRepeatTiming = pillss[0].repeat_time;
      });
    } else {}
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPills();
    getAllPillsType();
    getAllPillsPower();
    getAllPillsDose();
    getAllPillsTiming();
    getAllPillsRepeatTiming();
  }

  String? medicinTiming = 'Daily 2 Times';
  var medicinTimingList = [
    "Daily 2 Times",
    "Daily 3 Times",
    "Daily Empty Stomach/Before Breakfast",
    "Daily Morning After Breakfast",
    "Daily Before Launch",
    "Daily After Launch",
    "Daily Evening",
    "Daily Before Dinner",
    "Daily After Dinner",
    "Daily Before Sleep",
  ];
  String? medicinRepeat = "no repeat only 1 Time";
  var medicinRepeatList = [
    "no repeat only 1 Time",
    "repeat 2 Days",
    "repeat 3 Days",
    "repeat 4 Days",
    "repeat 5 Days",
    "repeat 6 Days",
    "repeat for 1 weeks",
    "repeat for 2 weeks",
    "repeat for 3 weeks",
    "repeat for 1 Month",
    "repeat for 2 Month",
    "repeat for 3 Month",
    "repeat with 1 day gap",
    "repeat with 2 day gap",
    "repeat with 3 day gap",
    "only a week"
  ];

  String? medicinType = 'Tablet';
  var medicinTypeList = [
    "Tablet",
    "Syrup",
  ];

  String? medicinPower = '10 mg';
  var medicinPowerList = [
    "10 mg",
    "100 mg",
    "200 mg",
    "500 mg",
    "1000 mg",
  ];

  String? medicinDoze = '1/2 Tablet';
  var medicinDozeList = [
    "1/2 Tablet",
    "1 Tablet",
    "2 Tablet",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: CustomAppBar(isleading: false),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: Colors.blue,
              title: Row(
                children: [
                  const Text(
                    'Current Consult: ',
                    style: TextStyle(fontSize: 18),
                  ), //Tex
                  Text(
                    '#${widget.appNo}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ), //Tex
                ],
              ),
            ),
            SizedBox(
              height: 750,
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
                  child: Column(
                    children: [
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.redAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 15),
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: myBoxDecoration(),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          //          <// --- BoxDecoration here
                          child: DropdownButton(
                              // Initial Value
                              menuMaxHeight: MediaQuery.of(context).size.height,
                              value: pills,
                              dropdownColor: Colors.white,
                              focusColor: Colors.blue,
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: pillsList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (spec) {
                                if (mounted) {
                                  setState(() {
                                    pills = spec.toString();
                                  });
                                }
                              }),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.redAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 15),
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: myBoxDecoration(),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          //          <// --- BoxDecoration here
                          child: DropdownButton(
                              // Initial Value
                              menuMaxHeight: MediaQuery.of(context).size.height,
                              value: pillsType,
                              dropdownColor: Colors.white,
                              focusColor: Colors.blue,
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: pillsTypeList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (spec) {
                                if (mounted) {
                                  setState(() {
                                    pillsType = spec.toString();
                                  });
                                }
                              }),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.redAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 15),
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: myBoxDecoration(),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          //          <// --- BoxDecoration here
                          child: DropdownButton(
                              // Initial Value
                              menuMaxHeight: MediaQuery.of(context).size.height,
                              value: pillsPower,
                              dropdownColor: Colors.white,
                              focusColor: Colors.blue,
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: pillsPowerList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (spec) {
                                if (mounted) {
                                  setState(() {
                                    pillsPower = spec.toString();
                                  });
                                }
                              }),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.redAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 15),
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: myBoxDecoration(),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          //          <// --- BoxDecoration here
                          child: DropdownButton(
                              // Initial Value
                              menuMaxHeight: MediaQuery.of(context).size.height,
                              value: pillsDose,
                              dropdownColor: Colors.white,
                              focusColor: Colors.blue,
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: pillsDoseList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (spec) {
                                if (mounted) {
                                  setState(() {
                                    pillsDose = spec.toString();
                                  });
                                }
                              }),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.redAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 15),
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: myBoxDecoration(),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          //          <// --- BoxDecoration here
                          child: DropdownButton(
                              // Initial Value
                              menuMaxHeight: MediaQuery.of(context).size.height,
                              value: pillsTiming,
                              dropdownColor: Colors.white,
                              focusColor: Colors.blue,
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: pillsTimingList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (spec) {
                                if (mounted) {
                                  setState(() {
                                    pillsTiming = spec.toString();
                                  });
                                }
                              }),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.redAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 15),
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: myBoxDecoration(),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          //          <// --- BoxDecoration here
                          child: DropdownButton(
                              // Initial Value
                              menuMaxHeight: MediaQuery.of(context).size.height,
                              value: pillsRepeatTiming,
                              dropdownColor: Colors.white,
                              focusColor: Colors.blue,
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: pillsRepeatTimingList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (spec) {
                                if (mounted) {
                                  setState(() {
                                    pillsRepeatTiming = spec.toString();
                                  });
                                }
                              }),
                        ),
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
                            controller: _controllerComment,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Note';
                              }
                              return null;
                            },
                            onChanged: (v) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.text,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.teal)),
                                labelText: 'Notes',
                                suffixStyle:
                                    TextStyle(color: Colors.green)),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .87,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              addDoses(widget.appNo);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                textStyle: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            child: dataAddDosesF?const Center(child: CircularProgressIndicator()):Text(
                              widget.button,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      )
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
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }
}
