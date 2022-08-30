import 'dart:convert';

import 'package:doctor/doctor_dashboard/appointments/rejected_appointments_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RejectedAppointmentsDD extends StatefulWidget {
  const RejectedAppointmentsDD({Key? key, required this.doctorId})
      : super(key: key);
  final doctorId;

  @override
  _RejectedAppointmentsDDState createState() => _RejectedAppointmentsDDState();
}

class _RejectedAppointmentsDDState extends State<RejectedAppointmentsDD> {
  var dataAppointments;
  var response2;
  bool dataHomeFlag = true;

  Future<void> getAllAppointments() async {
    print(
        '.appointments_1 widget.doctorId..............................${widget.doctorId}');
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/rejected_appointment_api.php';
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getAPPOINTMENTS $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      print('..appointments_1....${response.body}');
      dataAppointments = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
      });
      print('..appointments_1....${dataAppointments.length}');
      print('..appointments_1data....${dataAppointments[0]['assistant_name']}');
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('wwwwww${widget.doctorId}');
    getAllAppointments();
  }

  final popupMenu = new PopupMenuButton(
    child: new ListTile(
      title: new Text('Doge or lion?'),
      trailing: const Icon(Icons.more_vert),
    ),
    itemBuilder: (_) => <PopupMenuItem<String>>[
      new PopupMenuItem<String>(child: new Text('Doge'), value: 'Doge'),
      new PopupMenuItem<String>(child: new Text('Lion'), value: 'Lion'),
    ],
    onSelected: (v) {},
  );

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
                    return RejectedAppointmentCard(
                      button: 'Reactive Consult',
                      appointment_no:
                      dataAppointments[index]['appointment_no'] ?? '',
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
