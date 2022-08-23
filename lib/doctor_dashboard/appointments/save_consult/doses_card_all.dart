import 'dart:convert';

import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/save_consult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DosesCardForAll extends StatefulWidget {
  const DosesCardForAll(
      {Key? key,
      required this.button,
        this.doseId,
      this.index,
      this.medicineName,
      this.image,
      this.medicineType,
      this.medicinePower,
      this.medicinDoses,
      this.medicineRepetationPerDay,
      this.medicineRepedationLongTime,
      this.notes})
      : super(key: key);
  final button;
  final index;
  final medicineType,
      doseId,
      medicinePower,
      image,
      medicinDoses,
      medicineRepetationPerDay,
      medicineRepedationLongTime,
      notes,
      medicineName;

  @override
  _DosesCardForAllState createState() => _DosesCardForAllState();
}

class _DosesCardForAllState extends State<DosesCardForAll> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .40,
                child: Text(
                  '${widget.index + 1}) ${widget.medicineType} ${widget.medicineName}',
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * .25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.medicineRepetationPerDay}'),
                  Text('(Before Food)'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .25,
              child: Column(
                children: [
                  Text('${widget.medicineRepedationLongTime}'),
                  Text('(Total ${widget.index} Tab)'),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .09,
                child: InkWell(
                  onTap: () {
                    deleteDose();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .08,
                    child: Icon(Icons.delete),
                  ),
                ))
          ],
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }

  var dataDelete;
  Future<void> deleteDose() async {
    print('doses--delete---------------${widget.doseId}--');
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/delete_doses_api.php';
    Map<String, dynamic> body = {
      'doses_id': widget.doseId.toString()
    };
    print('doses--delete------------------');
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getAPPOINTMENTS $error"));
    print('doses--delete------------------');
    if (response.statusCode == 200) {
      dataDelete = jsonDecode(response.body.toString());
      print('doses--delete------------------${dataDelete}');
      setState(() {
      });
    } else {}
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
