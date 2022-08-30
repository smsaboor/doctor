import 'package:doctor/core/constants.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/save_consult.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:doctor/doctor_dashboard/home_tab/search_appointment.dart';
import 'package:doctor/doctor_dashboard/more_tab/edit_profile/api/multi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeTabDD extends StatefulWidget {
  const HomeTabDD({Key? key, required this.doctorId, required this.userData})
      : super(key: key);
  final doctorId;
  final userData;

  @override
  _HomeTabDDState createState() => _HomeTabDDState();
}

class _HomeTabDDState extends State<HomeTabDD> {
  var dataAppointments;
  var dataHome;
  bool dataHomeFlag = true;
  bool emergencyAppointmentsFlag = true;
  var response2;
  bool updateBooking = false;

  Future<void> getHomeData() async {
    var API = API_BASE_URL + API_DOCTOR_HOMETAB_DASHBOARD;
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getHomeData: $error"));
    if (response.statusCode == 200) {
      setState(() {
        dataHomeFlag = false;
      });
      dataHome = jsonDecode(response.body.toString());
    } else {}
  }

  Future<void> getAllAssitents() async {
    var API = API_BASE_URL + API_DOCTOR_HOMETAB_DOCTOR_EMERGENCY_APPOINTMENTS;
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getAllAssitents: $error"));
    response2 = response.body;
    if (response.statusCode == 200) {
      setState(() {
        emergencyAppointmentsFlag = false;
      });
      dataAppointments = jsonDecode(response.body.toString());
    } else {
      dataAppointments = null;
    }
  }

  var getEmergencyData;
  var emergencyData;
  bool emergencyFlag = false;

  bool _switchValue = false;

  Future<void> getEmergencyService() async {
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/booking_on_off_api.php';
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getEmergencyService: $error"));
    if (response.statusCode == 200) {
      setState(() {
        getEmergencyData = jsonDecode(response.body.toString());
        if (getEmergencyData['on_off_status'] == "0") {
          setState(() {
            _switchValue = false;
          });
        } else {
          setState(() {
            _switchValue = true;
          });
        }
      });
    } else {}
  }

  Future<void> updateEmergencyService() async {
    updateBooking = true;
    String isSwitch;
    print('check1 ${widget.doctorId}');
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/update_on_off_api.php';
    await getEmergencyService();
    if (getEmergencyData['on_off_status'] == "0") {
      isSwitch = '1';
    } else {
      isSwitch = '0';
    }
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
      'on_off_status': isSwitch,
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) =>
            print(" Failed to update updateEmergencyService: $error"));
    if (response.statusCode == 200) {
      getEmergencyService();
      emergencyData = jsonDecode(response.body.toString());
        if (getEmergencyData['on_off_status'] == "0") {
          setState(() {
            _switchValue = false;
            updateBooking = false;
          });
          CustomSnackBar.snackBar(
              context: context,
              data: 'Booking On!',
              color: Colors.green);
        } else {
          setState(() {
            _switchValue = true;
            updateBooking = false;
            CustomSnackBar.snackBar(
                context: context,
                data: 'Booking Off!',
                color: Colors.red);
          });
        }
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeData();
    getAllAssitents();
    getEmergencyService();
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
              builder: (_) => SearchAppointments(
                    userData: widget.userData,
                  )));
        },
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          isleading: false,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            children: [
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
                                      });
                                    },
                                  ),
                                  updateBooking
                                      ? SizedBox(
                                          width: 40,
                                          child: Center(
                                            child: LinearProgressIndicator(),
                                          ))
                                      : Text('')
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
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              dataHome['new_booking_count'] ??
                                                  '',
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
                                              dataHome['today_booking'] ?? '',
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
              emergencyAppointmentsFlag
                  ? Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Text('Loading...'),
                      ],
                    ),
                  )
                  : FutureBuilder(
                      future: getAllAssitents(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: dataAppointments.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => SaveConsultDD(
                                            appointmentNumber:
                                                dataAppointments[index]
                                                    ['appointment_no'],
                                            patientName: dataAppointments[index]
                                                ['patient_name'],
                                            patientId: dataAppointments[index]
                                                ['patient_id'],
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 5, bottom: 5, top: 5),
                                  child: SizedBox(
                                    height: 250,
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 15),
                                        child: Column(
                                          children: [
                                            Center(
                                                child: Text(
                                              'Emergency Appointment',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                            Divider(),
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
                                                            ['image'] ??
                                                        '',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Appointment:',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          '  ${dataAppointments[index]['appointment_no'] ?? ''}',
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
                                                          '  ${dataAppointments[index]['booking_type'] ?? ''}',
                                                          style: TextStyle(
                                                              color: dataAppointments[
                                                                              index]
                                                                          [
                                                                          'booking_type'] ==
                                                                      'online'
                                                                  ? Colors.green
                                                                  : Colors.red,
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
                                                          '  ${dataAppointments[index]['date'] ?? ''}',
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
                                                              color:
                                                                  Colors.pink,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          '  ${dataAppointments[index]['patient_name'] ?? ''}',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
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
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              '  ${dataAppointments[index]['gender'] ?? ''}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
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
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              '  ${dataAppointments[index]['age'] ?? ''}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
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
                                                              color:
                                                                  Colors.pink,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          '  ${dataAppointments[index]['address'] ?? ''}',
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Total Fees: ',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Text(
                                                      '${dataAppointments[index]['doctor_fee'] ?? ''}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.black87),
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
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Text(
                                                      '${dataAppointments[index]['received_payment'] ?? ''}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green),
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
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Text(
                                                      '${dataAppointments[index]['due_payment'] ?? ''}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red),
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
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
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
