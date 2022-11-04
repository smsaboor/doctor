import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
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
  String test='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa0';
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
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.index + 1}) ${widget.medicineType.length > 4 ?
                      widget.medicineType.substring(0, 4) :
                      widget.medicineType ?? ''} ${widget.medicineName.length > 12 ?
                      widget.medicineName.substring(0, 12)+'..' :
                      widget.medicineName ?? ''}',
                    ),
                    const SizedBox(height: 3,),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text('(${widget.medicinePower.length > 15 ?
                      widget.medicinePower.substring(0, 15)+'..' :
                      widget.medicinePower ?? ''})',style: const TextStyle(color: Colors.pink,fontWeight: FontWeight.w400,fontSize: 12),),
                    ),
                  ],
                ),),
            SizedBox(
              width: MediaQuery.of(context).size.width * .25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${widget.medicinDoses.length > 10 ?
                  widget.medicinDoses.substring(0, 10)+'..' :
                  widget.medicinDoses ?? ''}'),
                  const Text('(After Food)'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .25,
              child: Column(
                children: [
                  Text('${widget.medicineRepedationLongTime.length > 10 ?
                  widget.medicineRepedationLongTime.substring(0, 10)+'..' :
                  widget.medicineRepedationLongTime ?? ''}'),
                  Text('(Total Tab:  )'),
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
                    child: const Icon(Icons.delete,color: Colors.red),
                  ),
                ))
          ],
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }

  var dataDelete;
  Future<void> deleteDose() async {
    var API = '${API_BASE_URL}delete_doses_api.php';
    Map<String, dynamic> body = {
      'doses_id': widget.doseId.toString()
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      dataDelete = jsonDecode(response.body.toString());
      setState(() {
      });
    } else {}
  }
}
