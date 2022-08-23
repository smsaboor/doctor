import 'package:doctor/core/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMemberPD extends StatefulWidget {
  const AddMemberPD({Key? key}) : super(key: key);

  @override
  _AddMemberPDState createState() => _AddMemberPDState();
}

class _AddMemberPDState extends State<AddMemberPD> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();

  String? name = ' ';
  String? number;

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    name = preferences.getString('name');
    number = preferences.getString('number');
    name='saboor';
    number='9090909098';
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  String? relative = 'Grand Father';
  var genderList = ['Male', 'Female', 'Others'];
  String? gender = 'Male';
  var relatives = [
    "Grand Father",
    "Grand Mother",
    "Father",
    "Mother",
    "Doughter",
    "Son",
    "Brother",
    "Sister",
    "Uncle",
    "Aunty"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Add New Member'),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24, // Changing Drawer Icon Size
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * .95,
                  height: MediaQuery.of(context).size.height * .6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(8, 8, 0, 15),
                      //   child: TitleText(text: ' Profile Details'),
                      // ),

                      SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                          readOnly: false,
                          controlller: _controllerName,
                          errorMsg: 'Enter Your Name',
                          labelText: 'Name',
                          icon: Icons.perm_identity,
                          textInputType: TextInputType.text),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: Colors.redAccent,
                            primaryColorDark: Colors.red,
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(1.0),
                            padding: const EdgeInsets.only(left: 5.0),
                            decoration: myBoxDecoration(),
                            height: 60,
                            //
                            width: MediaQuery.of(context).size.width,
                            //          <// --- BoxDecoration here
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButton(
                                // Initial Value
                                  menuMaxHeight:
                                  MediaQuery.of(context).size.height,
                                  value: relative,
                                  dropdownColor: Colors.white,
                                  focusColor: Colors.blue,
                                  isExpanded: true,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  // Array list of items
                                  items: relatives.map((String items) {
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
                                        relative = spec.toString();
                                      });
                                    }
                                    print('------------------${spec}');
                                  }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: Colors.redAccent,
                            primaryColorDark: Colors.red,
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(1.0),
                            padding: const EdgeInsets.only(left: 5.0),
                            decoration: myBoxDecoration(),
                            height: 60,
                            //
                            width: MediaQuery.of(context).size.width,
                            //          <// --- BoxDecoration here
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButton(
                                  // Initial Value
                                  menuMaxHeight:
                                      MediaQuery.of(context).size.height,
                                  value: gender,
                                  dropdownColor: Colors.white,
                                  focusColor: Colors.blue,
                                  isExpanded: true,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  // Array list of items
                                  items: genderList.map((String items) {
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
                                        gender = spec.toString();
                                      });
                                    }
                                    print('------------------${spec}');
                                  }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                          readOnly: false,
                          controlller: _controllerName,
                          errorMsg: 'Enter Age',
                          labelText: 'Age',
                          icon: Icons.numbers,
                          textInputType: TextInputType.number),
                      SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .87,
                          height: 60,
                          child: Container(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.pink,
                                  textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              child: Text(
                                "Add Memeber",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 50,
            //   decoration:
            //   BoxDecoration(border: Border.all(color: Colors.blueAccent),color: Colors.white),
            //   child: Center(child: Text('कम से कम १०० रुपए डाल सकते हैं। ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.redAccent),)),
            // ),
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
