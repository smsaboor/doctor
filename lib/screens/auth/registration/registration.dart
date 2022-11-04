import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/screens/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:doctor/model/model_doctor.dart';
import 'package:doctor/model/model_patient.dart';
import 'package:doctor/core/constants/route.dart';
import 'package:flutter_package1/CustomFormField.dart';
import 'package:doctor/service/api.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.mobile}) : super(key: key);
  final mobile;
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

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
  String? currentUser = 'Doctor';
  String? specialityOF = 'Sergion';
  String? currentHospital = 'Apolo Hospital';

  bool tryRegistration=false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerHospitalName = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerEmergencyNum = TextEditingController();
  final  TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerState = TextEditingController();
  final TextEditingController _controllerPin = TextEditingController();
  final TextEditingController _controllerDistrict = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();

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
              const Padding(
                padding: EdgeInsets.only(left: 25.0, bottom: 15),
                child: Text(
                  "SignUp",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xE1100A44),
                      fontSize: 32),
                  textAlign: TextAlign.left,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
              ),
              currentUser == 'Doctor'
                  ? buildDoctorForm(context)
                  : currentUser == 'Patient'
                      ? buildDoctorForm(context)
                      : buildDoctorForm(context),
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
                        primary: Colors.blue,
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: tryRegistration
                        ? const Center(
                      child: CircularProgressIndicator(color: Colors.white,),
                    ):const Text(
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

  buildDoctorForm(BuildContext context) {
    return Column(
      children: [
        CustomFormField(
            controlller: _controllerHospitalName,
            errorMsg: 'Enter Your Hospital/Clinic',
            labelText: 'Hospital/Clinic',
            readOnly: false,
            icon: Icons.local_hospital,
            maxLimit: 30,
            maxLimitError: '30',
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerName,
            errorMsg: 'Enter Your Name',
            readOnly: false,
            labelText: 'Doctor Name',
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
            controlller: _controllerPhone,
            errorMsg: 'Enter Your Phone',
            readOnly: false,
            labelText: 'Enter Your Phone',
            icon: Icons.phone,
            maxLimit: 10,
            maxLimitError: '10',
            textInputType: TextInputType.number),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerEmergencyNum,
            errorMsg: 'Enter Your Emergency Number',
            readOnly: false,
            labelText: 'Emergency Number',
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
            maxLimit: 30,
            maxLimitError: '30',
            icon: Icons.home,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        stateWidget(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerCity,
            errorMsg: 'Enter Your City',
            labelText: 'City',
            maxLimit: 30,
            maxLimitError: '30',
            readOnly: false,
            icon: Icons.location_city,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerDistrict,
            errorMsg: 'Enter Your District',
            labelText: 'District',
            readOnly: false,
            maxLimit: 30,
            maxLimitError: '30',
            icon: Icons.location_city_sharp,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerPin,
            errorMsg: 'Enter Your Pin',
            labelText: 'Pin',
            readOnly: false,
            icon: Icons.pin,
            maxLimit: 6,
            maxLimitError: '6',
            textInputType: TextInputType.number),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerPassword,
            errorMsg: 'Enter Your Password',
            readOnly: false,
            labelText: 'Password',
            maxLimit: 8,
            maxLimitError: '8',
            icon: Icons.password,
            textInputType: TextInputType.text),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        CustomFormField(
            controlller: _controllerConfirmPassword,
            errorMsg: 'Confirm Password not match',
            readOnly: false,
            labelText: 'Confirm Password',
            maxLimit: 8,
            maxLimitError: '8',
            icon: Icons.password,
            textInputType: TextInputType.text),

      ],
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
        stateWidget(),
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
        CustomFormField(
            controlller: _controllerPassword,
            errorMsg: 'Enter Your Password',
            readOnly: false,
            labelText: 'Password',
            maxLimit: 8,
            maxLimitError: '8',
            icon: Icons.password,
            textInputType: TextInputType.text),
        CustomFormField(
            controlller: _controllerConfirmPassword,
            errorMsg: 'Enter Confirm Password',
            readOnly: false,
            labelText: 'Confirm Password',
            maxLimit: 8,
            maxLimitError: '8',
            icon: Icons.password,
            textInputType: TextInputType.text),
      ],
    );
  }

stateWidget(){
    return  Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Theme(
        data:  ThemeData(
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
    );
}
  void _registration(BuildContext context) async {
    var data;
    if (formKey.currentState!.validate()) {
      if (currentUser == 'Patient') {
        setState(() {
          tryRegistration = true;
        });
        data = await ApiService.signUpUser(API_SIGNUP,1, ModelDoctor(), ModelPatient(
          userType: '1',
          name: _controllerName.text,
          mobile: _controllerMobile.text,
          address: _controllerAddress.text,
          state: stateInitial.toString(),
          city: _controllerCity.text,
          district: _controllerDistrict.text,
          pincode: _controllerPin.text,
          password: _controllerPassword.text,
        ));
        if (data == 'ok') {
          setState(() {
            tryRegistration = false;
          });
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, RouteGenerator.signIn);
        }else{
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to Register'),
            backgroundColor: Colors.red,
          ));
        }
      } else if (currentUser == 'Doctor') {
        setState(() {
          tryRegistration = true;
        });
        data = await ApiService.signUpUser(API_SIGNUP,2, ModelDoctor(
          userType: '2',
          name: _controllerName.text,
          mobile: _controllerMobile.text,
          phone: _controllerPhone.text,
          emergencyNumber: _controllerEmergencyNum.text,
          clinicName: _controllerHospitalName.text,
          specialist: '',
          state: 'up',
          address: _controllerAddress.text,
          city: _controllerCity.text,
          district: _controllerDistrict.text,
          pincode: _controllerPin.text,
          password: _controllerPassword.text,
        ), ModelPatient());
        if (data == 'ok') {
          setState(() {
            tryRegistration = false;
          });
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen(),
            ),
                (route) => false,
          );
        }else{
          if (!mounted) return;
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
