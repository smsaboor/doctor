
import 'package:flutter/material.dart';

class DosesCardForAllForOldAppointments extends StatefulWidget {
  const DosesCardForAllForOldAppointments(
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
  _DosesCardForAllForOldAppointmentsState createState() => _DosesCardForAllForOldAppointmentsState();
}

class _DosesCardForAllForOldAppointmentsState extends State<DosesCardForAllForOldAppointments> {
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
                    '${widget.index + 1}) ${widget.medicineType} ${widget.medicineName}',
                  ),
                  const SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text('(${widget.medicinePower})',style: const TextStyle(color: Colors.pink,fontWeight: FontWeight.w400,fontSize: 12),),
                  ),
                ],
              ),),
            SizedBox(
              width: MediaQuery.of(context).size.width * .25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${widget.medicinDoses}'),
                  const Text('(Before Food)'),
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
          ],
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
  var dataDelete;
}

