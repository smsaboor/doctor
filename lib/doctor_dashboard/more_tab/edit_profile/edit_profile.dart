import 'dart:convert';
import 'package:doctor/core/custom_form_field.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/api/api.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/image.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_degree.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_lang.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_profile.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/model_speciality.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/multi_select_api.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/profile_servicee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as Dio;

import '../constant.dart';

import 'package:dio/dio.dart';

class EditProfileDD extends StatefulWidget {
  EditProfileDD(
      {Key? key,
      required this.button,
      required this.language,
      required this.degree,
      required this.specialities,
      required this.id})
      : super(key: key);
  final language;
  final id;
  final degree;
  final specialities;
  final button;
  XFile? image;

  @override
  _EditProfileDDState createState() => _EditProfileDDState();
}

class _EditProfileDDState extends State<EditProfileDD> {
  bool? isUserAdded;
  final TextEditingController _startDateController =
      new TextEditingController();
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerMobile = new TextEditingController();
  final TextEditingController _controllerLicenceNum =
      new TextEditingController();
  final TextEditingController _controllerExperience =
      new TextEditingController();
  final TextEditingController _controllerDegree = new TextEditingController();
  final TextEditingController _controllerSpeciality =
      new TextEditingController();
  final TextEditingController _controllerAddress = new TextEditingController();
  final TextEditingController _controllerSpeaks = new TextEditingController();

  var jsonLanguage;
  var jsonDegrees;
  var jsonSpeciality;

  bool getSpecialityFlag = true;
  var getSpecialityData;
  File? _image;
  var imagePicker;
  var type;
  var imageData;
  bool uplaodImage = false;

  var fetchImageData;
  var fetchUserData;
  List<MultiSelectItem<ModelLanguages?>>? _selectedLanguages;
  List<MultiSelectItem<ModelLanguages?>>? _selectedSpeciality;
  List<MultiSelectItem<ModelLanguages?>>? _selectedDegree;

  void _getImgeUrl(String doctorId) async {
    uplaodImage = true;
    fetchImageData = await ApiEditProfiles.getImgeUrl(widget.id);
    if (ApiEditProfiles.fetchImageF == true) {
      setState(() {
        uplaodImage = true;
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
      // uploadImage();
    });
    if (_image != null) {
      print('/7/7/7/7/7/7/7/7//77/7//7 start');
      Dio.FormData formData = new Dio.FormData.fromMap({
        "doctor_id": '7',
        "image": await Dio.MultipartFile.fromFile(_image!.path,
            filename: _image!.path.split('/').last)
      });
      print('/7/7/7/7/7/7/7/7//77/7//7 start2');
      bool result = await ProfileServices.create(formData);
      if (result == true) {
        setState(() {
          uplaodImage = false;
          _getImgeUrl(widget.id);
        });
      }
      if (result) print('/7/7/7/7/7/7/7/7//77/7//7/ $result');
    } else {}

    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  }

  Future<void> getUserData() async {
    List<ModelLanguages> languages = <ModelLanguages>[];
    List<ModelDegrees> degre = <ModelDegrees>[];
    List<ModelSpeciality> spec = <ModelSpeciality>[];
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/fetch_profile_api.php';
      Map<String, dynamic> body = {
        'doctor_id': widget.id,
      };
    http.Response response = await http
        .post(Uri.parse(API),body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to fetchProfileData: $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      print('..fetchProfileData....${response.body}');
      fetchUserData = jsonDecode(response.body.toString());
      print('..fetchProfileData....${fetchUserData.length ?? 0}');

      Iterable l = json.decode(fetchUserData[0]['languages']);
      List<ModelLanguages> posts = List<ModelLanguages>.from(
          l.map((model) => ModelLanguages.fromJson(model)));
      languages = posts;
      _selectedLanguages = languages.map(
              (lang) => MultiSelectItem<ModelLanguages>(lang, lang.language!))
          .toList();
      print('..fetchProfileData2....${_selectedLanguages}');
      Iterable l2 = json.decode(fetchUserData[0]['degree']);
      List<ModelDegrees> posts2 = List<ModelDegrees>.from(
          l2.map((model) => ModelDegrees.fromJson(model)));
      degre = posts2;
      _selectedDegree = degre.map(
              (lang) => MultiSelectItem<ModelDegrees>(lang, lang.degree!)).cast<MultiSelectItem<ModelLanguages?>>()
          .toList();
      Iterable l3 = json.decode(fetchUserData[0]['languages']);
      List<ModelSpeciality> posts3 = List<ModelSpeciality>.from(
          l3.map((model) => ModelSpeciality.fromJson(model)));
      spec = posts3;
      _selectedSpeciality = spec.map(
              (lang) => MultiSelectItem<ModelSpeciality>(lang, lang.doctor_speciality!)).cast<MultiSelectItem<ModelLanguages?>>()
          .toList();


      var selLan=fetchUserData[0]['languages'];
      var selSpec=fetchUserData[0]['specialty'];
      var selDegr=fetchUserData[0]['degree'];

      setState(() {
        _controllerName.text=fetchUserData[0]['doctor_name'];
        _controllerMobile.text=fetchUserData[0]['number'];
        _controllerSpeaks.text=fetchUserData[0]['languages'];
        _controllerLicenceNum.text=fetchUserData[0]['license_no'];
        _controllerDegree.text=fetchUserData[0]['degree'];
        _controllerSpeciality.text=fetchUserData[0]['specialty'];
        _controllerAddress.text=fetchUserData[0]['address'];
      });
    } else {}
  }

  // Future<void> uploadImage() async {
  //   print('.uploadImage.................${widget.id}............$_image.');
  //   var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/update_image_api.php';
  //   String base64Image = base64Encode(_image!.readAsBytesSync());
  //   String fileName = _image!.path.split("/").last;
  //   Map<String, dynamic> body = {
  //     'doctor_id': widget.id,
  //     'image': base64Image,
  //   };
  //   http.Response response = await http
  //       .post(Uri.parse(API), body: body)
  //       .then((value) => value)
  //       .catchError((error) => print(" Failed to uploadImage: $error"));
  //   print('...............................${response.body}');
  //   if (response.statusCode == 200) {
  //     print('..uploadImage222222222222222222222....${response.request}');
  //     imageData = jsonDecode(response.body.toString());
  //     setState(() {});
  //     uplaodImage = false;
  //     print('..uploadImage2222222222222222222222222222....${imageData.length}');
  //     print('..uploadImage222222222222222222222222data....${imageData[0]}');
  //     print(
  //         '..uploadImage222222222222222222222222data....${imageData[0]['image']}');
  //   } else {}
  // }

  var dataDegree;
  bool dataHomeFlag = true;
  var dataLanguages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getImgeUrl(widget.id);
    getUserData();
    imagePicker = new ImagePicker();
    // getDegree();
    // getLanguages();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isEditted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Colors.blue,
                title: Text("Edit Profile"),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 5),
                    child: Column(
                      children: [
                        Container(
                          height: kSpacingUnit.w * 10,
                          width: kSpacingUnit.w * 10,
                          margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                          child: Stack(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  showAlertDialog(context);
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>UploadImageScreen()));
                                  // final image = await ImagePicker().getImage(source: ImageSource.gallery);
                                  // if (image == null) return;
                                  // final directory = await getApplicationDocumentsDirectory();
                                  // final name = basename(image.path);
                                  // final imageFile = File('${directory.path}/$name');
                                  // final newImage = await File(image.path).copy(imageFile.path);
                                  // setState(() => user = user.copy(imagePath: newImage.path));
                                },
                                child: uplaodImage
                                    ? CircleAvatar(
                                        radius: kSpacingUnit.w * 5,
                                        backgroundImage: AssetImage(
                                            'assets/images/user.jpg'),
                                      )
                                    : AvatarImagePD(
                                        fetchImageData[0]['image'],
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        CustomFormField(
                            controlller: _controllerName,
                            errorMsg: 'Enter Name',
                            labelText: 'Name',
                            readOnly: false,
                            icon: Icons.person,
                            textInputType: TextInputType.text),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        CustomFormField(
                            controlller: _controllerMobile,
                            errorMsg: 'Enter Your Mobile',
                            labelText: 'Mobile',
                            readOnly: false,
                            icon: Icons.phone_android,
                            textInputType: TextInputType.number),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: MultiSelectDialogField(
                            items: widget.language,
                            title: Text("Languages"),
                            selectedColor: Colors.blue,
                            decoration: myBoxDecoration(),
                            buttonIcon: Icon(
                              Icons.speaker_notes_outlined,
                              color: Colors.blue,
                            ),
                            buttonText: Text(
                              "Languages Speak",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              print(results.length);
                              List<ModelLanguages> model = [];
                              for (int i = 0; i < results.length; i++) {
                                var newValues = results[i] as ModelLanguages;
                                print(newValues.language);
                                model.add(ModelLanguages(
                                    language: newValues.language));
                              }
                              var jsonLanguage = jsonEncode(
                                  model.map((e) => e.toJson()).toList());
                              print('Sab------------------${jsonLanguage}');
                              _controllerSpeaks.text = jsonLanguage;
                              // List<ModelLanguages> _language = [];
                              // var newValues = results[0] as ModelLanguages;
                              // print(newValues.language);
                              // // newValues.forEach((element) {
                              // //   print(element);
                              // //   // _language.add(element.language);
                              // // });
                              //
                              // // _selectedLookingGender2 = tempSelectedLookingGender;
                              // print(_language);
                              // print(_language[0]);
                              // print(_language[1]);
                              // print(_language.runtimeType);
                              // _controllerSpeaks.text =
                              //     results.length.toString();
                              // languages=results as List<ModelLanguages>;
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        CustomFormField(
                            controlller: _controllerLicenceNum,
                            errorMsg: 'Enter Licence No.',
                            labelText: 'Licence No.',
                            readOnly: false,
                            icon: Icons.numbers,
                            textInputType: TextInputType.text),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: MultiSelectDialogField(
                            items: widget.degree,
                            title: Text("Digrees"),
                            selectedColor: Colors.blue,
                            decoration: myBoxDecoration(),
                            buttonIcon: Icon(
                              Icons.history_edu,
                              color: Colors.blue,
                            ),
                            buttonText: Text(
                              "Digrees",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              print(results.length);
                              List<ModelDegrees> model = [];
                              for (int i = 0; i < results.length; i++) {
                                var newValues = results[i] as ModelDegrees;
                                print(newValues.degree);
                                model.add(ModelDegrees(
                                    degree: newValues.degree));
                              }
                              var jsonDegree = jsonEncode(
                                  model.map((e) => e.toJson()).toList());
                              print('Sab------------------${jsonDegree}');
                              _controllerDegree.text = jsonDegree;
                              //_selectedAnimals = results;
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        CustomFormField(
                            controlller: _controllerExperience,
                            errorMsg: 'Enter Experience',
                            labelText: 'Experience',
                            readOnly: false,
                            icon: Icons.cases,
                            textInputType: TextInputType.text),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: MultiSelectDialogField(
                            items: widget.specialities,
                            title: Text("Speciality"),
                            selectedColor: Colors.blue,
                            decoration: myBoxDecoration(),
                            buttonIcon: Icon(
                              Icons.folder_special,
                              color: Colors.blue,
                            ),
                            buttonText: Text(
                              "Specialty",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              print(results.length);
                              List<ModelSpeciality> model = [];
                              for (int i = 0; i < results.length; i++) {
                                var newValues = results[i] as ModelSpeciality;
                                print(newValues.doctor_speciality);
                                model.add(ModelSpeciality(
                                    doctor_speciality: newValues.doctor_speciality));
                              }
                              var jsonSpe = jsonEncode(
                                  model.map((e) => e.toJson()).toList());
                              print('Sab------------------${jsonSpe}');
                              _controllerSpeciality.text = jsonSpe;
                              //_selectedAnimals = results;
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        CustomFormField(
                            controlller: _controllerAddress,
                            errorMsg: 'Ente Full Address',
                            labelText: 'Address',
                            readOnly: false,
                            icon: Icons.home,
                            textInputType: TextInputType.text),
                        Divider(
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .87,
                            height: 50,
                            child: Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  _updateProfile(context);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (_) => MyHomePage()));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                child: Text(
                                  widget.button,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              _handleURLButtonPress(context, ImageSourceType.gallery);
            },
            child: Container(
              child: ListTile(
                  title: Text("From Gallery"),
                  leading: Icon(
                    Icons.image,
                    color: Colors.deepPurple,
                  )),
            ),
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
            child: Container(
              child: ListTile(
                  title: Text(
                    "From Camera",
                    style: TextStyle(color: Colors.red),
                  ),
                  leading: Icon(
                    Icons.camera,
                    color: Colors.red,
                  )),
            ),
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
        'https://cabeloclinic.com/website/medlife/php_auth_api/update_profile_api.php';
    http.Response response = await http
        .post(Uri.parse(APIURL), body: model?.toJson())
        .then((value) => value)
        .catchError((error) => print("doctore Failed to addProfile: $error"));
    var data = jsonDecode(response.body);
    print("addProfile DATA: ${data}");
    return data[0]['doctor_name'];
  }

  _updateProfile(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isEditted = true;
      });
      String assistant_name = await addProfile(ModelProfile(
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
      if (assistant_name == _controllerName.text) {
        CustomSnackBar.snackBar(
            context: context,
            data: 'Added Successfully !',
            color: Colors.green);
        setState(() {
          isEditted = false;
        });
        Navigator.pop(context);
      } else {
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
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }
}
