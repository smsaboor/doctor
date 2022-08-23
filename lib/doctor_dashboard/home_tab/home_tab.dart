import 'package:doctor/core/constants.dart';
import 'package:doctor/dashboard_patient/data/json.dart';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:doctor/doctor_dashboard/home_tab/add_appointment.dart';
import 'package:doctor/doctor_dashboard/home_tab/doctor_profile_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeTabDD extends StatefulWidget {
  const HomeTabDD({Key? key,required this.doctorId,required this.userData}) : super(key: key);
  final doctorId;
  final userData;
  @override
  _HomeTabDDState createState() => _HomeTabDDState();
}

class _HomeTabDDState extends State<HomeTabDD> {
  var dataAppointments;
  var dataHome;
  bool dataHomeFlag = true;
  var response2;

  Future<void> getHomeData() async {
    var API = API_BASE_URL+API_DOCTOR_HOMETAB_DASHBOARD;
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getAllAssitents: $error"));
    if (response.statusCode == 200) {
      setState(() {
        dataHomeFlag = false;
      });
      dataHome = jsonDecode(response.body.toString());
    } else {}
  }

  Future<void> getAllAssitents() async {
    var API = API_BASE_URL+API_DOCTOR_HOMETAB_DOCTOR_APPOINTMENTS;
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http.post(Uri.parse(API), body: body).then((value) => value)
        .catchError((error) => print(" Failed to getAllAssitents: $error"));
    response2 = response.body;
    if (response.statusCode == 200) {
      dataAppointments = jsonDecode(response.body.toString());
    } else {}
  }

  var emergencyData;
  bool emergencyFlag=false;

  bool _switchValue = false;
  Future<void> updateEmergencyService() async {
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/booking_on_off_api.php';
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to update updateEmergencyService: $error"));
    if (response.statusCode == 200) {
      setState(() {
        emergencyData = jsonDecode(response.body.toString());
        if(emergencyData['booking']=='0'){
          _switchValue = false;
        }else{
          _switchValue = true;
        }
      });
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllAssitents();
    getHomeData();
    updateEmergencyService();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddApointments(userData: widget.userData,)));
        },
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(isleading: false,),),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Image.asset(
              //       'assets/images/img_2.png',
              //       width: 200,
              //       height: 90,
              //     ),
              //     Spacer(),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           widget.userData == null ? 'Dr.' : 'Dr. ${widget.userData['name']} ',
              //           style: TextStyle(
              //             fontSize: 17.0,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         // Text(
              //         //   'MBBS',
              //         //   style: TextStyle(
              //         //     fontSize: 14.0,
              //         //     fontWeight: FontWeight.w500,
              //         //   ),
              //         // ),
              //       ],
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     AvatarImagePD(
              //       "https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
              //       radius: 30,
              //       height: 45,
              //       width: 45,
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
              dataHomeFlag
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Live Booking',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  Text(
                                    dataHome['live_booking'].toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    'Booking',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CupertinoSwitch(
                                    value: _switchValue,
                                    trackColor: Colors.red,
                                    activeColor: Colors.green,
                                    onChanged: (value) {
                                      setState(() {
                                        updateEmergencyService();
                                        _switchValue = value;
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 5, bottom: 5, top: 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width * .4,
                                width: MediaQuery.of(context).size.width * .4,
                                child: Card(
                                  elevation: 10,
                                  color: Colors.pinkAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // Scaffold.of(context).showSnackBar(SnackBar(
                                      //     content: Text(
                                      //   "Selected Ite",
                                      //   style: TextStyle(
                                      //     fontSize: 16.0,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // )));
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              dataHome['new_booking_count'] ??'',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "New Booking",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, bottom: 5, top: 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width * .4,
                                width: MediaQuery.of(context).size.width * .4,
                                child: Card(
                                  elevation: 10,
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // Scaffold.of(context).showSnackBar(
                                      //     SnackBar(content: Text("Selected Ite")));
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              dataHome['today_booking'] ??'',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "       Today \nAppointments",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              dataHomeFlag
                  ? Center(child: Text(''))
                  : FutureBuilder(
                      future: getAllAssitents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: dataAppointments.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 5, bottom: 5, top: 5),
                                  child: SizedBox(
                                    height: 220,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    child: Card(
                                      elevation: 10,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        side: BorderSide(color: Colors.white),
                                      ),
                                      child: InkWell(
                                          onTap: () {
                                            // Scaffold.of(context).showSnackBar(SnackBar(
                                            //     content: Text(
                                            //       "Selected Ite",
                                            //       style: TextStyle(
                                            //         fontSize: 16.0,
                                            //         fontWeight: FontWeight.bold,
                                            //       ),
                                            //     )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: AvatarImagePD(
                                                        dataAppointments[index]
                                                            ['image']??'',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Appointment:',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              '  ${dataAppointments[
                                                              index][
                                                              'appointment_no']??''}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Booking Type:',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              '  ${dataAppointments[
                                                              index][
                                                              'booking_type']??''}',
                                                              style: TextStyle(
                                                                color: dataAppointments[
                                                                index][
                                                                'booking_type']=='online'?Colors.green:Colors.red,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Date:',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              '  ${dataAppointments[
                                                              index]
                                                              ['date']??''}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Name:',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .pink,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              '  ${dataAppointments[
                                                              index]
                                                              ['patient_name']??''}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Sex:',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .pink,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text('  ${dataAppointments[
                                                                  index]
                                                                  [
                                                                  'gender']??''}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Age:',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .pink,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  '  ${dataAppointments[
                                                                  index]
                                                                  ['age']??''}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Address:',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .pink,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              '  ${dataAppointments[
                                                              index]
                                                              ['address'] ?? '' }',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.black12,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Total Fees: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                        Text(
                                                         '${ dataAppointments[
                                                         index]
                                                         ['doctor_fee']??''}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Received: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                        Text(
                                                         '${ dataAppointments[
                                                         index][
                                                         'received_payment']??''}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Due: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                        Text(
                                                         '${ dataAppointments[
                                                         index]
                                                         ['due_payment']??''}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.black12,
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                    ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
        ),
        SizedBox(width: 15),
        Text("Hello,"),
        Text(' Janth,',
            style: GoogleFonts.mulish(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        Expanded(
          child: SizedBox(),
        ),
        Icon(
          Icons.short_text,
          color: Theme.of(context).iconTheme.color,
        )
      ],
    );
  }
}
