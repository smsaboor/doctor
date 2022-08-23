import 'package:doctor/dashboard_patient/data/json.dart';
import 'package:doctor/doctor_dashboard/appointments_card.dart';
import 'package:flutter/material.dart';

class UpcomingApointments extends StatefulWidget {
  const UpcomingApointments({Key? key}) : super(key: key);
  @override
  _UpcomingApointmentsState createState() => _UpcomingApointmentsState();
}

class _UpcomingApointmentsState extends State<UpcomingApointments> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
      AppointmentCard(doctor:doctors[0]),
        SizedBox(height: 5,),
        AppointmentCard(doctor:doctors[1]),SizedBox(height: 5,),
        AppointmentCard(doctor:doctors[2]),SizedBox(height: 5,),
        AppointmentCard(doctor:doctors[3]),SizedBox(height: 5,),
        AppointmentCard(doctor:doctors[4]),SizedBox(height: 5,),
        AppointmentCard(doctor:doctors[5]),SizedBox(height: 5,),
        AppointmentCard(doctor:doctors[6]),

    ],);
  }
}
