import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpComingAppointments extends StatelessWidget {
  UpComingAppointments({Key? key, required this.doctor}) : super(key: key);
  var doctor;
  bool noAppointment = false;

  @override
  Widget build(BuildContext context) {
    return noAppointment ? Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.only(left: 5, top: 15),
        width: MediaQuery
            .of(context)
            .size
            .width * .8,
        height: MediaQuery
            .of(context)
            .size
            .width * .40,
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
        child:Column(children: [
          SizedBox(height: 150,width: 170,child: Image.asset('assets/appointments.png'),)
        ],),) : Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.only(left: 5, top: 15),
        width: MediaQuery
            .of(context)
            .size
            .width * .8,
        height: MediaQuery
            .of(context)
            .size
            .width * .30,
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
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 5),
                          child: Icon(
                            Icons.local_hospital,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                        Text(
                          doctor["name"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Apmnt No.",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue),
                              ),
                              Text(
                                " #212",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: Column(
                            children: [
                              Text(
                                "Date & Time",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue),
                              ),
                              Text(
                                "5/12/2022",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "12:30 P.M",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .4,
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
                              'Status: Pending',
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
        ));
  }
}
