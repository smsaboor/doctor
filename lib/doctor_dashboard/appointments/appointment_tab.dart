import 'dart:convert';
import 'package:doctor/doctor_dashboard/appointments/complete_appointment.dart';
import 'package:doctor/doctor_dashboard/appointments/next_appointments.dart';
import 'package:doctor/doctor_dashboard/appointments/pause_appointment.dart';
import 'package:doctor/doctor_dashboard/appointments/rejected_appointments.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:http/http.dart' as http;

class TabAppointmentDD extends StatefulWidget {
  const TabAppointmentDD(
      {Key? key, required this.doctor_id, required this.userData})
      : super(key: key);
  final doctor_id;
  final userData;

  @override
  _TabAppointmentDDState createState() => _TabAppointmentDDState();
}

class _TabAppointmentDDState extends State<TabAppointmentDD>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var data;

  var dataAppointments;
  bool dataHomeFlag = true;

  Future<void> getAllAppointments() async {
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/all_appointment_api.php';
    Map<String, dynamic> body = {'doctor_id': widget.doctor_id};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getAPPOINTMENTS $error"));
    if (response.statusCode == 200) {
      dataAppointments = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
      });
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    getAllAppointments();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  Widget addLeadingIcon(){
    return new Container(
      height: 90.0,
      width: 150,
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Image.asset(
        'assets/img_2.png',
        width: 150,
        height: 90,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // appBar: AppBar(
        //   // leadingWidth: 8,
        //   // leading: Icon(Icons.android),
        //   backgroundColor: Colors.white,
        //   bottomOpacity: 0.0,
        //   titleSpacing: 0,
        //   elevation: 0.0,
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             widget.userData == null ? 'Dr. ' : 'Dr. ${widget.userData['name']} ',
        //             style: TextStyle(
        //               fontSize: 17.0,
        //               color: Colors.black,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           // Text(
        //           //   'MBBS',
        //           //   style: TextStyle(
        //           //     fontSize: 14.0,
        //           //     color: Colors.black,
        //           //     fontWeight: FontWeight.w500,
        //           //   ),
        //           // ),
        //         ],
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: AvatarImagePD(
        //         "https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
        //         radius: 35,
        //         height: 40,
        //         width: 40,
        //       ),
        //     ),
        //   ],
        //   title: Image.asset(
        //     'assets/img_2.png',
        //     width: 150,
        //     height: 90,
        //   ),
        // ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(isleading: false,),),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  // centerTitle: true,
                  // leading:  Image.asset(
                  //   'assets/img_2.png',
                  //   width: 200,
                  //   height: 90,
                  // ),
                  foregroundColor: Colors.blue,
                  title: SizedBox(
                    width: 200,
                    child: Chip(
                        elevation: 1,
                        padding: EdgeInsets.all(8),
                        backgroundColor: Colors.greenAccent[100],
                        shadowColor: Colors.black,
                        label: Row(
                          children: [
                            Text(
                              'Current Consult: ',
                              style: TextStyle(fontSize: 14),
                            ), //Tex
                            Text(
                              dataHomeFlag
                                  ? ''
                                  : '#${dataAppointments.length == 0 ? '' : dataAppointments[0]['appointment_no'] ?? ''}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ), //Tex
                          ],
                        )),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20,
                        width: 70,
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.pink),
                            onPressed: () {},
                            child: Text('Next')),
                      ),
                    )
                  ],
                  automaticallyImplyLeading: false,
                  elevation: 4.0,
                  backgroundColor: Colors.white,
                  floating: true,
                  pinned: true,
                  snap: true,
                  bottom: TabBar(
                    indicatorColor: Colors.red,
                    isScrollable: false,
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: "Next",
                      ),
                      Tab(
                        text: "Pause",
                      ),
                      Tab(
                        text: "Rejected",
                      ),
                      Tab(
                        text: "Completed",
                      ),
                    ],
                    labelColor: Colors.black,
                    unselectedLabelStyle: GoogleFonts.mulish(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    labelStyle: GoogleFonts.mulish(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    indicator: MaterialIndicator(
                      color: Colors.purple,
                      height: 5,
                      topLeftRadius: 8,
                      topRightRadius: 8,
                      horizontalPadding: 50,
                      tabPosition: TabPosition.bottom,
                    ),
                  ),
                ),
              ];
            },
            body: _tabBarViewWorld()),
      ),
    );
  }

  Widget _tabBarViewWorld() {
    debugPrint("in ........................_tabBarView");
    return TabBarView(controller: _tabController, children: [
      NextAppointmentsDD(doctorId: widget.doctor_id),
      PauseAppointmentsDD(doctorId: widget.doctor_id),
      RejectedAppointmentsDD(doctorId: widget.doctor_id),
      CompletedAppointmentsDD(doctorId: widget.doctor_id),
    ]);
  }

  Widget TabBarLocal() {
    return TabBar(
      labelStyle: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      unselectedLabelColor: Colors.black54,
      labelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4,
      indicatorColor: Colors.amber,
//      indicator: BoxDecoration(
//          borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//          color: Colors.white70),
      isScrollable: true,
      tabs: [
        Tab(child: Text('Hot News')),
        Tab(child: Text('Hot News')),
        Tab(child: Text('Hot News')),
      ],
      controller: _tabController,
    );
  }
}
