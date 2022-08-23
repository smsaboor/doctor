import 'package:doctor/screens/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor/model/model_doctor.dart';
import 'package:doctor/model/model_patient.dart';
import 'package:doctor/route.dart';
import 'package:doctor/screens/auth/registration/CustomFormField.dart';
import 'package:doctor/service/api.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key, required this.mobile}) : super(key: key);
  final mobile;

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  // getSP()async{
  //   await SharedPreferences.getInstance();
  // }

  String dropdownvalueState = 'Arunachal Pradesh';

  var indianState = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry"
  ];
  var usertype = [
    'Patient',
    'Doctor',
  ];
  var speciality = [
    'Sergion',
    'Mental',
    'Kidney',
  ];
  var hospitalsName = [
    'Apolo Hospital',
    'Surya Hospital',
    'PGI Hospital',
  ];
  String? _selectedState = "Choose State";
  String dropdownvalue = 'Patient';
  String? currentUser = 'Patient';
  String? specialityOF = 'Sergion';
  String? currentHospital = 'Apolo Hospital';

  bool tryRegistration = false;

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerHospitalName = TextEditingController();
  TextEditingController _controllerMobile = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerEmergencyNum = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerState = TextEditingController();
  TextEditingController _controllerPin = TextEditingController();
  TextEditingController _controllerDistrict = TextEditingController();
  TextEditingController _controllerCity = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerConfirmPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerMobile.text = widget.mobile;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        SizedBox(
                            width: 80, child: Image.asset('assets/logo2.png')),
                      ],
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, bottom: 15),
                child: Text(
                  "Add New Patient",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xE1100A44),
                      fontSize: 32),
                  textAlign: TextAlign.left,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0),
              ),
              SizedBox(height: size.height * 0.006),
              buildPatientForm(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 50,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        _registration(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      child: tryRegistration
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Submit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
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

  buildPatientForm() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerName,
            errorMsg: 'Enter Your Name',
            labelText: 'Patient Name',
            readOnly: false,
            icon: Icons.person,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerMobile,
            errorMsg: 'Enter Your Mobile',
            labelText: 'Mobile',
            readOnly: true,
            icon: Icons.phone_android,
            textInputType: TextInputType.number),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        // Padding(
        //   padding: const EdgeInsets.only(left: 25, right: 18),
        //   child: DropdownButton(
        //     // Initial Value
        //     menuMaxHeight: MediaQuery.of(context).size.height,
        //     value: dropdownvalue,
        //     dropdownColor: Colors.white,
        //     focusColor: Colors.blue,
        //     isExpanded: true,
        //     // Down Arrow Icon
        //     icon: const Icon(Icons.keyboard_arrow_down),
        //     // Array list of items
        //     items: indianState.map((String items) {
        //       return DropdownMenuItem(
        //         value: items,
        //         child: Text(items),
        //       );
        //     }).toList(),
        //     // After selecting the desired option,it will
        //     // change button value to selected value
        //     onChanged: (String? newValue) {
        //       setState(() {
        //         dropdownvalue = newValue!;
        //         _controllerState.text = newValue;
        //         // tryRegistration = false;
        //       });
        //     },
        //   ),
        // ),
        CustomFormField(
            controlller: _controllerAddress,
            errorMsg: 'Enter Your Address',
            labelText: 'Address',
            readOnly: false,
            icon: Icons.home,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerCity,
            errorMsg: 'Enter Your City',
            labelText: 'City',
            readOnly: false,
            icon: Icons.location_city,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerDistrict,
            errorMsg: 'Enter Your District',
            readOnly: false,
            labelText: 'District',
            icon: Icons.location_city_sharp,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerPin,
            errorMsg: 'Enter Your Pin',
            readOnly: false,
            labelText: 'Pin',
            icon: Icons.pin,
            textInputType: TextInputType.number),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerPassword,
            errorMsg: 'Enter Your Password',
            readOnly: false,
            labelText: 'Password',
            icon: Icons.password,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Theme(
            data: new ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
            ),
            child: Expanded(
              child: new TextFormField(
                textInputAction: TextInputAction.next,
                readOnly: false,
                controller: _controllerConfirmPassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirm Password';
                  }
                  if(_controllerPassword.text!=_controllerConfirmPassword.text){
                    return 'please enter same password';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    labelText: 'Confirm Password',
                    prefixText: ' ',
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.blue,
                    ),
                    suffixStyle: const TextStyle(color: Colors.green)),
              ),
            ),
          ),
        )
      ],
    );
  }

  buildAssistentForm() {
    return Column(
      children: [
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
                    menuMaxHeight: MediaQuery.of(context).size.height,
                    value: currentHospital,
                    dropdownColor: Colors.white,
                    focusColor: Colors.blue,
                    isExpanded: true,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    // Array list of items
                    items: hospitalsName.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (hos) {
                      setState(() {
                        currentHospital = hos.toString();
                      });
                      print('------------------${hos}');
                    }),
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Theme(
            data: new ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
            ),
            child: new TextFormField(
              textInputAction: TextInputAction.next,
              controller: _controllerName,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Your Name';
                }
                return null;
              },
              onChanged: (v) {
                setState(() {
                  tryRegistration = false;
                });
              },
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  labelText: 'Doctor Name',
                  prefixText: ' ',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  suffixStyle: const TextStyle(color: Colors.green)),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Theme(
            data: new ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
            ),
            child: new TextFormField(
              textInputAction: TextInputAction.next,
              controller: _controllerMobile,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Your Mobile';
                }
                return null;
              },
              onChanged: (v) {
                setState(() {
                  tryRegistration = false;
                });
              },
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  labelText: 'Mobile',
                  prefixText: ' ',
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.blue,
                  ),
                  suffixStyle: const TextStyle(color: Colors.green)),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }

  void _registration(BuildContext context) async {
    var data;
    if (formKey.currentState!.validate()) {
      if (currentUser == 'Patient') {
        setState(() {
          tryRegistration = true;
        });
        data = await ApiService.signUpUser(
            1,
            ModelDoctor(),
            ModelPatient(
              userType: '1',
              name: _controllerName.text,
              mobile: _controllerMobile.text,
              address: _controllerAddress.text,
              state: 'up',
              city: _controllerCity.text,
              district: _controllerDistrict.text,
              pincode: _controllerPin.text,
              password: _controllerPassword.text,
            ));
        print('1successcode:   ${data}');
        if (data == 'ok') {
          print('1successcode:   ${data}');
          setState(() {
            tryRegistration = false;
          });
          Navigator.pushReplacementNamed(context, RouteGenerator.signIn);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to Register'),
            backgroundColor: Colors.red,
          ));
        }
      } else if (currentUser == 'Doctor') {
        setState(() {
          tryRegistration = true;
        });
        data = await ApiService.signUpUser(
            2,
            ModelDoctor(
              userType: '2',
              name: _controllerName.text,
              mobile: _controllerMobile.text,
              phone: _controllerPhone.text,
              emergencyNumber: _controllerEmergencyNum.text,
              clinicName: _controllerHospitalName.text,
              specialist: specialityOF,
              state: 'up',
              address: _controllerAddress.text,
              city: _controllerCity.text,
              district: _controllerDistrict.text,
              pincode: _controllerPin.text,
              password: _controllerPassword.text,
            ),
            ModelPatient());
        print('2successcode:   ${data}');
        if (data == 'ok') {
          print('2successcode:   ${data}');
          setState(() {
            tryRegistration = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            ),
            (route) => false,
          );
          // Navigator.pushNamedAndRemoveUntil(context, "/signin", (Route<dynamic> route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select number'),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
  }

  bool _isEmailValidate(String txt) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(txt);
  }
}
