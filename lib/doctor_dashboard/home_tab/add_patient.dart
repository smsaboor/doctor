import 'package:doctor/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor/model/model_doctor.dart';
import 'package:doctor/model/model_patient.dart';
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
  var stateInitial="Andhra Pradesh";
  var stateList = [
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
  TextEditingController _controllerMobile = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerDistrict = TextEditingController();
  TextEditingController _controllerCity = TextEditingController();
  TextEditingController _controllerPin = TextEditingController();
  TextEditingController _controllerState = TextEditingController();

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
                          primary: Colors.blueAccent,
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
                    value: stateInitial,
                    dropdownColor: Colors.white,
                    focusColor: Colors.blue,
                    isExpanded: true,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    // Array list of items
                    items: stateList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (user) {
                      setState(() {
                        stateInitial = user.toString();
                      });
                      print('------------------${user}');
                      print('------------------${user}');
                    }),
              ),
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
      setState(() {
        tryRegistration = true;
      });
      data = await ApiService.signUpUser(
        API_INNER_SIGNUP,
          1,
          ModelDoctor(),
          ModelPatient(
            userType: '1',
            name: _controllerName.text,
            mobile: _controllerMobile.text,
            address: _controllerAddress.text,
            state: stateInitial,
            city: _controllerCity.text,
            district: _controllerDistrict.text,
            pincode: _controllerPin.text,
            password: _controllerMobile.text,
          ));
      print('1successcode:   ${data}');
      if (data == 'ok') {
        print('1successcode:   ${data}');
        setState(() {
          tryRegistration = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Patient Registered Successfully!'),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to Register'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
