
import 'package:doctor/doctor_dashboard/theme/colors.dart';
import 'package:doctor/core/avatar_image.dart';
import 'package:doctor/doctor_dashboard/more_tab/widget/doctor_info_box.dart';
import 'package:doctor/doctor_dashboard/more_tab/widget/mybutton.dart';
import 'package:flutter/material.dart';

class DoctorProfilePageDD extends StatefulWidget {
  const DoctorProfilePageDD({Key? key, required this.doctor}) : super(key: key);
  final doctor;

  @override
  _DoctorProfilePageDDState createState() => _DoctorProfilePageDDState();
}

class _DoctorProfilePageDDState extends State<DoctorProfilePageDD> {
  void _modalMenu() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const Text('mytext');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
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
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
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
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.doctor['doctor_name'].toString(),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        widget.doctor['digree'].toString(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.pink)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.doctor['specialty'].toString(),
                      style: const TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Speak: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.doctor['speak'].toString(),
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 5),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 18,
                color: Colors.orangeAccent,
              ),
              const Icon(
                Icons.star,
                size: 18,
                color: Colors.orangeAccent,
              ),
              const Icon(
                Icons.star,
                size: 18,
                color: Colors.orangeAccent,
              ),
              const Icon(
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
          const SizedBox(
            height: 5,
          ),
          const Text("4.0 Out of 5.0",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 3,
          ),
          const Text(
            "340 Patients review",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(
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
                  children: const [
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
                  children: const [
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
          const SizedBox(
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
              const SizedBox(
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
          const SizedBox(
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
              const SizedBox(
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
