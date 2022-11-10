import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/core/avatar_image.dart';
import 'package:flutter_package1/loading/Loading_card_Outer.dart';
import 'package:flutter_package1/loading/loading_card.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/save_consult.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:doctor/doctor_dashboard/home_doctor_dashboard.dart';
import 'package:doctor/doctor_dashboard/home_tab/search_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/data_connection_checker/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_package1/components.dart';
import 'package:doctor/core/internet_error.dart';
import 'package:flutter_package1/loading/loading1.dart';
import 'package:flutter_package1/loading/loading_card_list.dart';

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

String test='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa0';
  var getEmergencyData;
  var emergencyData;
  bool emergencyFlag = false;
  bool _switchValue = false;



  Future<void> getHomeData() async {
    var API = API_BASE_URL + API_DOCTOR_HOMETAB_DASHBOARD;
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      dataHome = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
      });
    } else {}
  }

  Future<void> getAllEmergencyAppointment() async {
    var API = API_BASE_URL + API_DOCTOR_HOMETAB_DOCTOR_EMERGENCY_APPOINTMENTS;
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    response2 = response.body;
    if (response.statusCode == 200) {
      dataAppointments = jsonDecode(response.body.toString());
      setState(() {
        emergencyAppointmentsFlag = false;
      });
    } else {
    }
  }


  Future<void> getEmergencyService() async {
    Map<String, dynamic> body = {
      'doctor_id': widget.doctorId,
    };
    http.Response response = await http
        .post(Uri.parse(API_BASE_URL+API_DD_EMERGENCY_SERVICE), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
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
        .post(Uri.parse(API_BASE_URL+API_DD_UPDATE_EMERGENCY_SERVICE), body: body)
        .then((value) => value)
        .catchError((error) =>
            print(error));
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
  Widget buildLoading() =>
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Row(
              children: [
              LoadingWidget.rectangular(height: 40,
                width: MediaQuery.of(context).size.width*0.25,),
              const Spacer(),
              LoadingWidget.rectangular(height: 40,
                width: MediaQuery.of(context).size.width*0.25,),
            ],),
            const SizedBox(height: 15,),
            Row(children: [
              LoadingWidget.rectangular(height: MediaQuery.of(context).size.width*0.4,
                width: MediaQuery.of(context).size.width*0.4,),
              const Spacer(),
              LoadingWidget.rectangular(height: MediaQuery.of(context).size.width*0.4,
                width: MediaQuery.of(context).size.width*0.4,),
            ],),
          ],
        ),
      );
  callApis(){
    getHomeData();
    getAllEmergencyAppointment();
    getEmergencyService();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeData();
    getAllEmergencyAppointment();
    getEmergencyService();
  }

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    navigateAndFinsh(context, DoctorDashBoard());
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    callApis();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state == NetworkState.initial) {
          // showToast(msg: TX_OFFLINE);
        }
        else if (state == NetworkState.gained) {
          callApis();
          // showToast(msg: TX_ONLINE);
        } else if (state == NetworkState.lost) {
          // showToast(msg: TX_OFFLINE);
        }
        else {
          // showToast(msg: 'error');
        }
      },
      builder: (context, state) {
        if (state == NetworkState.initial) {
          return const InternetError(text: TX_CHECK_INTERNET);
        } else if (state == NetworkState.gained) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              // isExtended: true,
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SearchAppointments(
                      userData: widget.userData,
                    ))).then((value) => navigateAndFinsh(context, DoctorDashBoard()));
              },
              // isExtended: true,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBar(
                isleading: false,
              ),
            ),
            body:SafeArea(
              child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: 	const WaterDropMaterialHeader(color: Colors.white,backgroundColor: Colors.blue),
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  controller: _refreshController,
                  child: getBody()),
            ),
          );
        } else if (state == NetworkState.lost) {
          return const InternetError(text: TX_LOST_INTERNET);
        } else {
          return const InternetError(text: 'error');
        }
      },
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SearchAppointments(
                    userData: widget.userData,
                  ))).then((value) => navigateAndFinsh(context, DoctorDashBoard()));
        },
        // isExtended: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          isleading: false,
        ),
      ),
      body:SafeArea(
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: 	const WaterDropMaterialHeader(color: Colors.white,backgroundColor: Colors.blue),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            controller: _refreshController,
            child: getBody()),
      ),
    );
  }

  getBody() {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              dataHomeFlag
                  ?buildLoading()
                  : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Live Booking',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              dataHome['active_booking'].toString(),
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            const Text(
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
                                ? const SizedBox(
                                width: 40,
                                child: Center(
                                  child: LinearProgressIndicator(),
                                ))
                                : const Text('')
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
                            shape: const RoundedRectangleBorder(
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
                                        style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
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
                            shape: const RoundedRectangleBorder(
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
                                        dataHome['today_booking'] ?? '',
                                        style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
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
                  ? Column(
                    children: const [
                      SizedBox(height: 20,),
                      LoadingCardList(),
                    ],
                  )
                  : dataAppointments[0]['status']==0 ? const Center(child: Text('No Emergency Appointments !'),): FutureBuilder(
                future: getAllEmergencyAppointment(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
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
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                  side: BorderSide(color: Colors.white),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 15),
                                  child: Column(
                                    children: [
                                      const Center(
                                          child: Text(
                                            'Emergency Appointment',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      const Divider(),
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
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
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
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
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
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Date:',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500),
                                                  ),
                                                  Text(
                                                    '  ${dataAppointments[index]['date'] ?? ''}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Name:  ',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                        Colors.pink,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500),
                                                  ),
                                                  Text(
                                                    dataAppointments[index]['patient_name'].length > 20 ?
                                                    dataAppointments[index]['patient_name'].substring(0, 20)+'...' :
                                                    dataAppointments[index]['patient_name'] ?? '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Sex: ',
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
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Age: ',
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
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Address:  ',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.pink,
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500),
                                                  ),
                                                  Text(
                                                    dataAppointments[index]['address'].length > 17 ?
                                                    dataAppointments[index]['address'].substring(0, 17)+'...' :
                                                    dataAppointments[index]['address'] ?? '',
                                                    style: const TextStyle(
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
                                      const Divider(
                                        color: Colors.black12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
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
                                                style: const TextStyle(
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
                                              const Text(
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
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
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
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(
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
        ));
  }
}
