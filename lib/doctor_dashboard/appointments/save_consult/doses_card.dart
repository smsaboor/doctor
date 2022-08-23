import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/save_consult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DosesCard extends StatefulWidget {
  const DosesCard(
      {Key? key,
        required this.button,
        this.medicineName,
        this.image,
        this.medicineType,
        this.medicinePower,
        this.medicinDoses,
        this.medicineRepetationPerDay,
        this.medicineRepedationLongTime,
      this.notes
      })
      : super(key: key);
  final button;
  final medicineType,
      medicinePower,
  image,
      medicinDoses,
      medicineRepetationPerDay,
      medicineRepedationLongTime,
      notes, medicineName;

  @override
  _DosesCardState createState() =>
      _DosesCardState();
}

class _DosesCardState extends State<DosesCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 0, top: 0),
      child: SizedBox(
        height: 130,
        width: MediaQuery.of(context).size.width * .9,
        child: Card(
          elevation: 2,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        AvatarImagePD(
                          widget.image,
                          width: 90,
                          height: 80,
                        ),
                        SizedBox(height: 3,),
                          Text(
                            widget.medicineName,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                      ],)
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Medicin Type:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.medicineType}',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              'Dose at one time:',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.medicinDoses,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              'Daily Take:',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.medicineRepetationPerDay}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
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
                                  'How many days:',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' ${widget.medicineRepedationLongTime},',
                                  style: TextStyle(
                                      fontSize: 14,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Power: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87),
                                ),
                                Text(
                                  '${widget.medicinePower}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                            SizedBox(width: 5,),
                            Row(
                              children: [
                                Text(
                                  'Daily Dose: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87),
                                ),
                                Text(
                                  '1x3',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            SizedBox(width: 5,),
                            Row(
                              children: [
                                Text(
                                  'Due: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87),
                                ),
                                Text(
                                  '8',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    )
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width * .8,
                //     height: 50,
                //     child: Container(
                //       child: ElevatedButton(
                //         onPressed: () {
                //         },
                //         style: ElevatedButton.styleFrom(
                //             primary: Colors.pink,
                //             textStyle: TextStyle(
                //                 fontSize: 30, fontWeight: FontWeight.bold)),
                //         child: Text(
                //           widget.button,
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold, fontSize: 20),
                //         ),
                //       ),
                //     ),
                //   ),
                // )
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
