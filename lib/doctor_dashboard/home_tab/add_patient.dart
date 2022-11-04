import 'package:doctor/core/constants/apis.dart';
import 'package:flutter/material.dart';
import 'package:doctor/model/model_doctor.dart';
import 'package:doctor/model/model_patient.dart';
import 'package:flutter_package1/CustomFormField.dart';
import 'package:doctor/service/api.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key, required this.mobile}) : super(key: key);
  final mobile;

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  String dropdownvalueState = 'Arunachal Pradesh';
  var stateInitial = "Andhra Pradesh";
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

  String dropdownvalue = 'Patient';
  String? currentUser = 'Patient';
  String? specialityOF = 'Sergion';
  String? currentHospital = 'Apolo Hospital';

  bool tryRegistration = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerDistrict = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  final TextEditingController _controllerPin = TextEditingController();

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
      borderRadius: const BorderRadius.all(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24, // Changing Drawer Icon Size
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            SizedBox(
                                width: 80,
                                child: Image.asset('assets/logo2.png')),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
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
                  child: ElevatedButton(
                    onPressed: () {
                      _registration(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
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
            maxLimit: 30,
            maxLimitError: '30',
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerMobile,
            errorMsg: 'Enter Your Mobile',
            labelText: 'Mobile',
            readOnly: true,
            maxLimit: 10,
            maxLimitError: '10',
            icon: Icons.phone_android,
            textInputType: TextInputType.number),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerAddress,
            errorMsg: 'Enter Your Address',
            labelText: 'Address',
            readOnly: false,
            icon: Icons.home,
            maxLimit: 60,
            maxLimitError: '60',
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerCity,
            errorMsg: 'Enter Your City',
            labelText: 'City',
            readOnly: false,
            maxLimit: 30,
            maxLimitError: '30',
            icon: Icons.location_city,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerDistrict,
            errorMsg: 'Enter Your District',
            readOnly: false,
            labelText: 'District',
            maxLimit: 30,
            maxLimitError: '30',
            icon: Icons.location_city_sharp,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerPin,
            errorMsg: 'Enter Your Pin',
            readOnly: false,
            labelText: 'Pin',
            maxLimit: 8,
            maxLimitError: '8',
            icon: Icons.pin,
            textInputType: TextInputType.number),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Theme(
            data: ThemeData(
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
      if (data == 'ok') {
        setState(() {
          tryRegistration = false;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Patient Registered Successfully!'),
          backgroundColor: Colors.green,
        ));
        if (!mounted) return;
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to Register'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
