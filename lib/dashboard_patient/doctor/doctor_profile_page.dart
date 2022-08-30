
import 'package:doctor/dashboard_patient/theme/colors.dart';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/dashboard_patient/widgets/doctor_info_box.dart';
import 'package:doctor/dashboard_patient/widgets/mybutton.dart';
import 'package:flutter/material.dart';

class DoctorProfilePagePD extends StatefulWidget {
  const DoctorProfilePagePD({Key? key, required this.doctor}) : super(key: key);
  final doctor;

  @override
  _DoctorProfilePagePDState createState() => _DoctorProfilePagePDState();
}

class _DoctorProfilePagePDState extends State<DoctorProfilePagePD> {
  void _modalMenu() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return RequestSheet(
          doctor: widget.doctor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Doctor's Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: getBody(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: MyButtonPD(
            disableButton: false,
            bgColor: primary,
            title: "Book Appointment",
            onTap: () {
              _modalMenu();
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  getBody() {
    print('..............................${widget.doctor['image'].toString()}');
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvatarImagePD(
                widget.doctor['image'].toString(),
                radius: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.doctor['clinic_name'].toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.doctor['doctor_name'].toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        widget.doctor['digree'].toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.pink)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.doctor['specialty'].toString(),
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Speak: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.doctor['speak'].toString(),
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 5),
                      child: Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              width: 120,
                              height: 25,
                              color: Colors.orange,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Fees: ${widget.doctor['doctor_fee']}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 18,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text("4.0 Out of 5.0",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(
            height: 3,
          ),
          Text(
            "340 Patients review",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ContactBox(icon: Icons.videocam_rounded, color: Colors.blue,),
                Column(
                  children: [
                    Text("Live Consultant",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 3,
                    ),
                    Text("12 / 30",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.pink)),
                  ],
                ),
                Column(
                  children: [
                    Text("Last Booking Number",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 3,
                    ),
                    Text("110",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.pink)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DoctorInfoBoxPD(
                value: "500+",
                info: "Successful Patients",
                icon: Icons.groups_rounded,
                color: Colors.green,
              ),
              SizedBox(
                width: 20,
              ),
              DoctorInfoBoxPD(
                value: "10 Years",
                info: "Experience",
                icon: Icons.medical_services_rounded,
                color: Colors.purple,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DoctorInfoBoxPD(
                value: "28+",
                info: "Successful OT",
                icon: Icons.bloodtype_rounded,
                color: Colors.blue,
              ),
              SizedBox(
                width: 20,
              ),
              DoctorInfoBoxPD(
                value: "8+",
                info: "Certificates Achieved",
                icon: Icons.card_membership_rounded,
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
