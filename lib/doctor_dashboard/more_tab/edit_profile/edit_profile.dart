import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:flutter_package1/CustomFormField.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/core/avatar_image.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/api/api.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/image.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_degree.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_lang.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_profile.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_speciality.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/profile_servicee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as Dio;
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';

class EditProfileDD extends StatefulWidget {
  EditProfileDD(
      {Key? key,
      required this.button,
      required this.language,
      required this.degree,
      required this.specialities,
      required this.jsonLanguage,
      required this.jsonDegrees,
      required this.jsonSpeciality,
      required this.intialValueLang,
      required this.intialValueDegree,
      required this.intialValueSpec,
      required this.id})
      : super(key: key);
  final language;
  final id;
  final degree;
  final specialities;
  final button;
  final jsonSpeciality, jsonDegrees, jsonLanguage;
  final intialValueLang, intialValueDegree, intialValueSpec;
  XFile? image;
  @override
  _EditProfileDDState createState() => _EditProfileDDState();
}

class _EditProfileDDState extends State<EditProfileDD> {
  bool? isUserAdded;
  bool updateProfile=false;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerMobile =  TextEditingController();
  final TextEditingController _controllerLicenceNum =
       TextEditingController();
  final TextEditingController _controllerExperience =
       TextEditingController();
  final TextEditingController _controllerDegree =  TextEditingController();
  final TextEditingController _controllerSpeciality =
       TextEditingController();
  final TextEditingController _controllerAddress =  TextEditingController();
  final TextEditingController _controllerSpeaks =  TextEditingController();

  List<dynamic>? modelLanguages2 = [];
  List? _selectedLanguages = [];
  List? _selectedDegrees = [];
  List? _selectedSpeciality = [];

  List<ModelLanguages> languages = [];
  List<ModelDegrees> degre = [];
  List<ModelSpeciality> spec = [];

  bool getSpecialityFlag = true;
  var getSpecialityData;
  File? _image;
  var imagePicker;
  var type;
  var imageData;
  bool uplaodImage = true;

  var fetchImageData;
  var fetchUserData;

  var dataDegree;
  bool dataHomeFlag = true;
  var dataLanguages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    _selectedLanguages = widget.intialValueLang;
    _selectedDegrees = ['1'];
    _selectedSpeciality = ['1'];
    _getImgeUrl(widget.id);
    imagePicker =  ImagePicker();
  }

  void _getImgeUrl(String doctorId) async {
    fetchImageData = await ApiEditProfiles.getImgeUrl(doctorId);
    if (fetchImageData[0]['image'] != '') {
      setState(() {
        uplaodImage = false;
      });
    } else {
      setState(() {
        uplaodImage = false;
      });
    }
  }

  void _handleURLButtonPress(BuildContext context, var type) async {
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    XFile image = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      _image = File(image.path);
      uplaodImage=true;
      // uploadImage();
    });
    if (_image != null) {
      Dio.FormData formData =  Dio.FormData.fromMap({
        "doctor_id": widget.id,
        "image": await Dio.MultipartFile.fromFile(_image!.path,
            filename: _image!.path.split('/').last)
      });
      bool result = await ProfileServices.create(formData);
      if (result == true) {
        setState(() {
          _getImgeUrl(widget.id);
        });
      }
    } else {

    }
  }

  Future<void> getUserData() async {
    var API =
        '${API_BASE_URL}fetch_profile_api.php';
    Map<String, dynamic> body = {
      'doctor_id': widget.id,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      fetchUserData = jsonDecode(response.body.toString());
      setState(() {
        _controllerName.text = fetchUserData[0]['doctor_name'];
        _controllerMobile.text = fetchUserData[0]['number'];
        _controllerSpeaks.text = fetchUserData[0]['languages'];
        _controllerDegree.text = fetchUserData[0]['degree'];
        _controllerSpeciality.text = fetchUserData[0]['specialty'];
        _controllerLicenceNum.text = fetchUserData[0]['license_no'];
        _controllerAddress.text = fetchUserData[0]['address'];
        _controllerExperience.text = fetchUserData[0]['experience'];

        String firstText = _controllerSpeaks.text;
        String finalString = firstText.replaceAll("[", "").replaceAll("]", "");
        final splitedText = finalString.split(',');
        for (int i = 0; i < splitedText.length; i++) {
        }
        for (int i = 0; i < splitedText.length; i++) {
          modelLanguages2!.add(splitedText[i].toString());
        }
        setState(() {
          _selectedLanguages = modelLanguages2;
        });
      });
    } else {}
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: kSpacingUnit.w * 10,
                            width: kSpacingUnit.w * 10,
                            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                            child: Stack(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    uplaodImage?null:showAlertDialog(context);
                                  },
                                  child: uplaodImage
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : fetchImageData[0]['image'] != ''
                                          ? AvatarImagePD(
                                              fetchImageData[0]['image'],
                                              radius: kSpacingUnit.w * 5,
                                            )
                                          : AvatarImagePD(
                                              'https://www.kindpng.com/picc/m/198-1985282_doctor-profile-icon-png-transparent-png.png',
                                              radius: kSpacingUnit.w * 5,
                                            ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: kSpacingUnit.w * 2.5,
                                    width: kSpacingUnit.w * 2.5,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      heightFactor: kSpacingUnit.w * 1.5,
                                      widthFactor: kSpacingUnit.w * 1.5,
                                      child: Icon(
                                        LineAwesomeIcons.camera,
                                        color: kDarkPrimaryColor,
                                        size: (ScreenUtil()
                                            .setSp(kSpacingUnit.w * 1.5)
                                            .toDouble()),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        CustomFormField(
                            controlller: _controllerName,
                            errorMsg: 'Enter Name',
                            labelText: 'Name',
                            readOnly: false,
                            icon: Icons.person,
                            maxLimit: 30,
                            maxLimitError: '30',
                            textInputType: TextInputType.text),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        CustomFormField(
                            controlller: _controllerMobile,
                            errorMsg: 'Enter Your Mobile',
                            labelText: 'Mobile',
                            readOnly: false,
                            maxLimit: 10,
                            maxLimitError: '10',
                            icon: Icons.phone_android,
                            textInputType: TextInputType.number),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        CustomFormField(
                            controlller: _controllerLicenceNum,
                            errorMsg: 'Enter Licence No.',
                            labelText: 'Licence No.',
                            readOnly: false,
                            icon: Icons.numbers,
                            maxLimit: 50,
                            maxLimitError: '50',
                            textInputType: TextInputType.text),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        CustomFormField(
                            controlller: _controllerExperience,
                            errorMsg: 'Enter Experience',
                            labelText: 'Experience (in years)',
                            readOnly: false,
                            maxLimit: 2,
                            maxLimitError: '2',
                            icon: Icons.cases,
                            textInputType: TextInputType.number),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),

                        CustomFormField(
                            controlller: _controllerAddress,
                            errorMsg: 'Ente Full Address',
                            labelText: 'Address',
                            readOnly: false,
                            icon: Icons.home,
                            maxLimit: 60,
                            maxLimitError: '60',
                            textInputType: TextInputType.text),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          padding: const EdgeInsets.only(left: 18,right: 18),
                          child: MultiSelectFormField(
                            border: const OutlineInputBorder(),
                            autovalidate: AutovalidateMode.disabled,
                            chipBackGroundColor: Colors.blue,
                            chipLabelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            dialogTextStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            checkBoxActiveColor: Colors.blue,
                            checkBoxCheckColor: Colors.white,
                            dialogShapeBorder: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            title: const Text(
                              "Select languages",
                              style: TextStyle(fontSize: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'Please select one or more options';
                              }
                              return null;
                            },
                            dataSource: widget.language,
                            textField: 'language',
                            valueField: 'index',
                            okButtonLabel: 'OK',
                            cancelButtonLabel: 'CANCEL',
                            hintWidget: const Text('Please select language'),
                            initialValue: widget.intialValueLang,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedLanguages = value;
                                _controllerSpeaks.text =
                                    _selectedLanguages.toString();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          padding: const EdgeInsets.only(left: 18,right: 18),
                          child: MultiSelectFormField(
                            border: const OutlineInputBorder(),
                            autovalidate: AutovalidateMode.disabled,
                            chipBackGroundColor: Colors.blue,
                            chipLabelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                            checkBoxActiveColor: Colors.blue,
                            checkBoxCheckColor: Colors.white,
                            title: const Text(
                              "Select Speciality",
                              style: TextStyle(fontSize: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'Please select one or more options';
                              }
                              return null;
                            },
                            dataSource: widget.specialities,
                            textField: 'speciality',
                            valueField: 'index',
                            okButtonLabel: 'OK',
                            cancelButtonLabel: 'CANCEL',
                            hintWidget: const Text('Please select specialities'),
                            initialValue: widget.intialValueSpec,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedSpeciality = value;
                                _controllerSpeciality.text =
                                    _selectedSpeciality.toString();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          padding: const EdgeInsets.only(left: 18,right: 18),
                          child: MultiSelectFormField(
                            border: const OutlineInputBorder(),
                            autovalidate: AutovalidateMode.disabled,
                            chipBackGroundColor: Colors.blue,
                            chipLabelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            dialogTextStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                            checkBoxActiveColor: Colors.blue,
                            checkBoxCheckColor: Colors.white,
                            dialogShapeBorder: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                            title: const Text(
                              "Select Degrees",
                              style: TextStyle(fontSize: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'Please select one or more options';
                              }
                              return null;
                            },
                            dataSource: widget.degree,
                            textField: 'degree',
                            valueField: 'index',
                            okButtonLabel: 'OK',
                            cancelButtonLabel: 'CANCEL',
                            hintWidget: const Text('Please select degree'),
                            initialValue: widget.intialValueDegree,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedDegrees = value;
                                _controllerDegree.text =
                                    _selectedDegrees.toString();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        const Divider(
                          color: Colors.black12,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .87,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _updateProfile(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    textStyle: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                child: updateProfile?const Center(child: CircularProgressIndicator(color: Colors.white,),):Text(
                                  widget.button,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              _handleURLButtonPress(context, ImageSourceType.gallery);
            },
            child: const ListTile(
                title: Text("From Gallery"),
                leading: Icon(
                  Icons.image,
                  color: Colors.deepPurple,
                )),
          ),
          Container(
            width: 200,
            height: 1,
            color: Colors.black12,
          ),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              _handleURLButtonPress(context, ImageSourceType.camera);
            },
            child: const ListTile(
                title: Text(
                  "From Camera",
                  style: TextStyle(color: Colors.red),
                ),
                leading: Icon(
                  Icons.camera,
                  color: Colors.red,
                )),
          ),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<String> addProfile(ModelProfile? model) async {
    print('${model?.address}');
    var APIURL =
        '${API_BASE_URL}update_profile_api.php';
    http.Response response = await http
        .post(Uri.parse(APIURL), body: model?.toJson())
        .then((value) => value)
        .catchError((error) => print(error));
    var data = jsonDecode(response.body);
    return data[0]['doctor_name'];
  }

  _updateProfile(BuildContext context) async {
    setState(() {
      updateProfile=true;
    });
    if (_formKey.currentState!.validate()) {
      setState(() {
        isEdited = true;
      });
      String assistantName = await addProfile(ModelProfile(
        doctor_id: widget.id,
        name: _controllerName.text.toString(),
        number: _controllerMobile.text.toString(),
        address: _controllerAddress.text.toString(),
        language: _controllerSpeaks.text.toString(),
        degree: _controllerDegree.text.toString(),
        licence_no: _controllerLicenceNum.text.toString(),
        experience: _controllerExperience.text.toString(),
        speciality: _controllerSpeciality.text.toString(),
      ));
      if (assistantName == _controllerName.text) {
        setState(() {
          updateProfile=false;
        });
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('userName', _controllerName.text);
        CustomSnackBar.snackBar(
            context: context,
            data: 'Added Successfully !',
            color: Colors.green);
        setState(() {
          isEdited = false;
        });
        if (!mounted) return;
        Navigator.pop(context);
      } else {
        updateProfile=false;
        CustomSnackBar.snackBar(
            context: context,
            data: 'Failed to Registration !',
            color: Colors.red);
      }
    }
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
