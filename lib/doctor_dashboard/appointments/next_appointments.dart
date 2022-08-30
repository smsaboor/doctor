import 'dart:convert';
import 'package:doctor/core/constants.dart';
import 'package:doctor/doctor_dashboard/appointments/next_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NextAppointmentsDD extends StatefulWidget {
  const NextAppointmentsDD({Key? key, required this.doctorId})
      : super(key: key);
  final doctorId;
  @override
  _NextAppointmentsDDState createState() => _NextAppointmentsDDState();
}

class _NextAppointmentsDDState extends State<NextAppointmentsDD> {
  var dataAppointments;
  var response2;
  bool dataHomeFlag = true;

  Future<void> getAllAppointments() async {
    var API = API_BASE_URL+API_DT2_ALLAPPOINTMENTS;
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getAPPOINTMENTS $error"));
    if (response.statusCode == 200) {
      print('%%%%%%%%%%%%%%% ${response.body}');
      dataAppointments = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
      });
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllAppointments();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          dataHomeFlag
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : FutureBuilder(
                  future: getAllAppointments(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: dataAppointments.length ?? 0,
                        itemBuilder: (context, index) {
                          return NextAppointmentCard(
                            button: 'Save Consult',
                            appointment_no:
                                dataAppointments[index]['appointment_no'] ?? '',
                            patient_id: dataAppointments[index]['patient_id'] ?? '',
                            booking_type:
                                dataAppointments[index]['booking_type'] ?? '',
                            address: dataAppointments[index]['address'] ?? '',
                            due_payment:
                                dataAppointments[index]['due_payment'] ?? '',
                            age: dataAppointments[index]['age'] ?? '',
                            date: dataAppointments[index]['date'] ?? '',
                            gender: dataAppointments[index]['gender'] ?? '',
                            patient_name:
                                dataAppointments[index]['patient_name'] ?? '',
                            received_payment: dataAppointments[index]
                                    ['received_payment'] ??
                                '',
                            total_fees:
                                dataAppointments[index]['total_fees'] ?? '',
                          );
                        });
                  },
                )
        ],
      ),
    );
  }
}
