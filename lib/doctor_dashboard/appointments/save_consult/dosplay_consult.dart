import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/material.dart';

class DisplayConsult extends StatefulWidget {
  const DisplayConsult({Key? key}) : super(key: key);
  @override
  _DisplayConsultState createState() => _DisplayConsultState();
}

class _DisplayConsultState extends State<DisplayConsult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppBar(isleading: false)),
      body: SingleChildScrollView(child: Column(children: [
      ],),),
    );
  }
}
