import 'dart:convert';
import 'package:doctor/core/constants.dart';
import 'package:doctor/dashboard_patient/doctor/doctor_page.dart';
import 'package:doctor/dashboard_patient/doctor/doctor_profile_page.dart';
import 'package:doctor/dashboard_patient/widgets/category_box.dart';
import 'package:doctor/dashboard_patient/widgets/popular_doctor.dart';
import 'package:doctor/dashboard_patient/widgets/textbox.dart';
import 'package:doctor/dashboard_patient/data/json.dart';
import 'package:doctor/dashboard_patient/doctor/doctor_card_list.dart';
import 'package:doctor/dashboard_patient/doctor/symptoms.dart';
import 'package:doctor/dashboard_patient/doctor/upcoming_appointments.dart';
import 'package:doctor/dashboard_patient/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TabHomePatient extends StatefulWidget {
  const TabHomePatient({Key? key}) : super(key: key);

  @override
  _TabHomePatientState createState() => _TabHomePatientState();
}

class _TabHomePatientState extends State<TabHomePatient> {
  int currentPos = 0;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  var dataAllDoctors;
  var dataSpeciality;

  Future<void> getAllDoctors() async {
    print('...............................');
    var API =
        'all_doctor_api.php';
    http.Response response = await http
        .get(Uri.parse(API_BASE_URL+API))
        .then((value) => value)
        .catchError((error) => print(" Failed to getLogin: $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      print('..22222222222222222222222222222222....${response.body}');
      dataAllDoctors = jsonDecode(response.body.toString());
      print('..22222222222222222222222222222222....${dataAllDoctors.length}');
    } else {}
  }
  Future<void> getSpecialist() async {
    print('...............................');
    var API =
        'specialist_api.php';
    http.Response response = await http
        .get(Uri.parse(API_BASE_URL+API))
        .then((value) => value)
        .catchError((error) => print(" Failed to getLogin: $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      print('..33333333333333333333333333....${response.body}');
      dataSpeciality = jsonDecode(response.body.toString());
      print('..3333333333333333333333333333333....${dataAllDoctors.length}');
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDoctors();
    getSpecialist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 45,
          ),
          Center(
              child: Text(
                "Let's Find Your Doctor",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              )),
          SizedBox(height: 15),
          CustomTextBoxPD(),
          SizedBox(height: 25),
          Container(
              child: Text(
                "UpComing Appointments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )),
          SizedBox(height: 10),
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 5),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UpComingAppointments(
                  doctor: doctors[0],
                ),
                UpComingAppointments(
                  doctor: doctors[1],
                ),
                UpComingAppointments(
                  doctor: doctors[2],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          if (mounted) {
                            setState(() {
                              currentPos = index;
                            });
                          }
                        }),
                    items: imgList.map((item) => MyImageView(item)).toList(),
                  )),
              Positioned(
                bottom: 40,
                left: MediaQuery.of(context).size.width * .4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.map((url) {
                    int index = imgList.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPos == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.width * .30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Column(
                            children: [
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width * .18,
                                  width:
                                  MediaQuery.of(context).size.width * .18,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: .1,
                                      ),
                                    ),
                                    child: Image.asset('assets/icons/male.png'),
                                  )),
                              SizedBox(height: 5),
                              Text(
                                'Appointment Now',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => Symptoms()));
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * .1),
                        GestureDetector(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                    'assets/icons/medical-record.png'),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Book Lab Test',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => Symptoms()));
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 5),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  child: CategoryBoxPD(
                    title: "Heart",
                    icon: Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => DoctorCardList()));
                  },
                ),
                GestureDetector(
                  child: CategoryBoxPD(
                    title: "Medical",
                    icon: Icons.local_hospital,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Container()));
                  },
                ),
                GestureDetector(
                  child: CategoryBoxPD(
                    title: "Dental",
                    icon: Icons.details_rounded,
                    color: Colors.purple,
                  ),
                  onTap: () {
                    // getUserApi();
                  },
                ),
                GestureDetector(
                  child: CategoryBoxPD(
                    title: "Healing",
                    icon: Icons.healing_outlined,
                    color: Colors.green,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => DoctorPagePD()));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          dataSpeciality == null
              ? CircularProgressIndicator()
              : Container(
              height: 170,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: dataSpeciality.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: PopularDoctorPD(
                        doctor: dataAllDoctors[index],
                      ),
                      onTap: () async{
                        SharedPreferences preferencess =
                        await SharedPreferences.getInstance();
                        preferencess.setBool('isLogin', false);

                        print('........data......${dataAllDoctors[index]}');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                DoctorProfilePagePD(doctor: dataAllDoctors[index])));
                      },
                    );
                  })),
          Container(
            margin: EdgeInsets.only(right: 15),
            padding: EdgeInsets.only(left: 5, top: 15),
            width: MediaQuery.of(context).size.width * .9,
            height: 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 5),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    child: CategoryBoxPD(
                      title: "Heart",
                      icon: Icons.favorite,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => DoctorPagePD()));
                    },
                  ),
                  GestureDetector(
                    child: CategoryBoxPD(
                      title: "Medical",
                      icon: Icons.local_hospital,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => DoctorPagePD()));
                    },
                  ),
                  GestureDetector(
                    child: CategoryBoxPD(
                      title: "Dental",
                      icon: Icons.details_rounded,
                      color: Colors.purple,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => DoctorPagePD()));
                    },
                  ),
                  GestureDetector(
                    child: CategoryBoxPD(
                      title: "Healing",
                      icon: Icons.healing_outlined,
                      color: Colors.green,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => DoctorPagePD()));
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
              child: Text(
                "Nearby Doctors",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          SizedBox(height: 10),
          dataAllDoctors == null
              ? CircularProgressIndicator()
              : Container(
              height: 170,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: dataAllDoctors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: PopularDoctorPD(
                        doctor: dataAllDoctors[index],
                      ),
                      onTap: () async{
                        SharedPreferences preferencess =
                        await SharedPreferences.getInstance();
                        preferencess.setBool('isLogin', false);

                        print('........data......${dataAllDoctors[index]}');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                DoctorProfilePagePD(doctor: dataAllDoctors[index])));
                      },
                    );
                  })),
          SizedBox(
            height: 25,
          ),
          Container(
              child: Text(
                "Popular Doctors",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          SizedBox(height: 10),
          dataAllDoctors == null
              ? CircularProgressIndicator()
              : Container(
              height: 170,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: dataAllDoctors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: PopularDoctorPD(
                        doctor: dataAllDoctors[index],
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                DoctorProfilePagePD(doctor: dataAllDoctors[index])));
                      },
                    );
                  })),
          SizedBox(
            height: 25,
          ),
          Container(
              child: Text(
                "Search by Speciality",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),

          SizedBox(
            height: 20,
          ),
          // Container(
          //   width: double.infinity,
          //   padding: EdgeInsets.all(20),
          //   height: 160,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(30),
          //     image: DecorationImage(
          //       image: NetworkImage("https://media.istockphoto.com/vectors/electronic-health-record-concept-vector-id1299616187?k=20&m=1299616187&s=612x612&w=0&h=gmUf6TXc8w6NynKB_4p2TzL5PVIztg9UK6TOoY5ckMM="),
          //       fit: BoxFit.cover,)
          //   ),
          // ),
          // SizedBox(height: 20,),
        ]),
      ),
    );
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      height: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: NetworkImage(
                "https://media.istockphoto.com/vectors/electronic-health-record-concept-vector-id1299616187?k=20&m=1299616187&s=612x612&w=0&h=gmUf6TXc8w6NynKB_4p2TzL5PVIztg9UK6TOoY5ckMM="),
          )),
    );
  }
}
