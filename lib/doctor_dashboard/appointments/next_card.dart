import 'dart:convert';

import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/save_consult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NextAppointmentCard extends StatefulWidget {
  const NextAppointmentCard(
      {Key? key,
      required this.button,
      this.appointment_no,
      this.booking_type,
      this.date,
      this.patient_name,
        this.patient_id,
      this.age,
      this.gender,
      this.address,
      this.total_fees,
      this.received_payment,
      this.due_payment})
      : super(key: key);
  final button;
  final appointment_no,
      booking_type,
      date,
      patient_name,
      patient_id,
      age,
      gender,
      address,
      total_fees,
      received_payment,
      due_payment;

  @override
  _NextAppointmentCardState createState() => _NextAppointmentCardState();
}

class _NextAppointmentCardState extends State<NextAppointmentCard> {
  int? _value;
  bool dataF = false;
  var dataSkipAppointment;

  changeStatus(int changedValue, String appNo) async {
    print('change value=$changedValue    --------  appN = $appNo');
    if (changedValue == 1) {
      dataF = true;
      var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/skip_appointment_api.php';
      Map<String, dynamic> body = {'appointment_no': appNo};
      http.Response response = await http
          .post(Uri.parse(API), body: body)
          .then((value) => value)
          .catchError((error) => print(" Failed to changeStatus: $error"));
      if (response.statusCode == 200) {
        setState(() {
          dataF = false;
        });
        dataSkipAppointment = jsonDecode(response.body.toString());
      } else {}
    } else if (changedValue == 2) {
      dataF = true;
      var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/reject_appointment_api.php';
      Map<String, dynamic> body = {'appointment_no': appNo};
      http.Response response = await http
          .post(Uri.parse(API), body: body)
          .then((value) => value)
          .catchError((error) => print(" Failed to changeStatus: $error"));
      if (response.statusCode == 200) {
        setState(() {
          dataF = false;
        });
        dataSkipAppointment = jsonDecode(response.body.toString());
        print(
            '..changeStatus 22222222222222222222222222222222....${dataSkipAppointment.length ?? 0}');
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 5, bottom: 5, top: 5),
      child: SizedBox(
        height: 290,
        width: MediaQuery.of(context).size.width * .9,
        child: Card(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: AvatarImagePD(
                        "https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .6,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Appointment No:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '  ${widget.appointment_no}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              PopupMenuButton<int>(
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuItem<int>>[
                                        new PopupMenuItem<int>(
                                            value: 1, child: new Text('Skip')),
                                        new PopupMenuItem<int>(
                                            value: 2,
                                            child: new Text('Reject')),
                                      ],
                                  onSelected: (int value) {
                                    setState(() {
                                      _value = value;
                                      changeStatus(
                                          value, widget.appointment_no);
                                    });
                                  })
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Booking Type:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.booking_type}',
                              style: TextStyle(
                                  color: widget.booking_type == 'online'
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              'Name:',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.patient_name}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Sex:',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '  ${widget.gender},',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Age:',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' ${widget.age}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              'Address:',
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.address}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Date:',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.date}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.black12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Fees: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        Text(
                          widget.total_fees,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Received: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        Text(
                          widget.received_payment,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Due: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        Text(
                          widget.due_payment,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 50,
                    child: Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SaveConsultDD(
                                    appointmentNumber: widget.appointment_no,
                                    patientName: widget.patient_name,
                                patientId: widget.patient_id,
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        child: Text(
                          widget.button,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //   Text(
                //     'Total',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: Colors.black87),
                //   ),
                //   Text(
                //     'Received',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: Colors.black87),
                //   ),
                //   Text(
                //     'Due',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: Colors.black87),
                //   ),
                // ],),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Text(
                //       '1200 Rs',
                //       style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.black87),
                //     ),
                //     Text(
                //       '800',
                //       style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.black87),
                //     ),
                //     Text(
                //       '400',
                //       style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.black87),
                //     ),
                //   ],)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.fund) {
      print('Settings');
    } else if (choice == Constants.SignOut) {
      print('Subscribe');
    } else if (choice == Constants.SignOut) {
      print('SignOut');
    }
  }
}

class Constants {
  static const String fund = 'Fund';

//  static const String Settings = 'Settings';
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[
    'fund',
    'enter code here',
    'SignOut'
  ];
}
