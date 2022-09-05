import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'avatar_image.dart';

class PopularDoctorPD extends StatelessWidget {
  PopularDoctorPD({Key? key, required this.doctor}) : super(key: key);
  var doctor;

  @override
  Widget build(BuildContext context) {
    print('saboor2---------------------${doctor["image"]}');
    print('saboor3---------------------${doctor}');
    return Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.only(left: 5, top: 15),
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.width * .45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: AvatarImagePD(doctor["image"]),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.local_hospital,
                      color: Colors.blue,
                      size: 26,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      doctor["clinic_name"] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor["doctor_name"] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctor["specialty"].toString().replaceAll('[', '').replaceAll(']', '')  ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        doctor["specialty"].toString().replaceAll('[', '').replaceAll(']', '')  ?? '',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            "Speaks: ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue),
                          ),
                          Text(
                            doctor["specialty"].toString().replaceAll('[', '').replaceAll(']', '')  ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.star,
                      //       color: Colors.yellow,
                      //       size: 14,
                      //     ),
                      //     SizedBox(
                      //       width: 2,
                      //     ),
                      //     Text(
                      //       "${doctor["review"]} Review",
                      //       style: TextStyle(fontSize: 12),
                      //     )
                      //   ],
                      // ),
                      Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              width: 120,
                              height: 30,
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
                                        'Fees: ${doctor["doctor_fee"]??''}',
                                        style: TextStyle(
                                            fontSize: 16,
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
                )
              ],
            )
          ],
        ));
  }
}
