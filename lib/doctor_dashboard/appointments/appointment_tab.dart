import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/internet_error.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:doctor/doctor_dashboard/appointments/complete_appointment.dart';
import 'package:doctor/doctor_dashboard/appointments/next_appointments.dart';
import 'package:doctor/doctor_dashboard/appointments/pause_appointment.dart';
import 'package:doctor/doctor_dashboard/appointments/rejected_appointments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/components.dart';
import 'package:flutter_package1/data_connection_checker/connectivity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
    var API = '${API_BASE_URL}all_appointment_api.php';
    Map<String, dynamic> body = {'doctor_id': widget.doctor_id};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
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
    return Container(
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
  callApis() {
    getAllAppointments();
  }

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    callApis();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    callApis();
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state == NetworkState.initial) {
          // showToast(msg: 'TX_OFFLINE3');
        }
        else if (state == NetworkState.gained) {
          callApis();
          // showToast(msg: 'TX_ONLINE3');
        } else if (state == NetworkState.lost) {
          // showToast(msg: 'TX_OFFLINE3');
        }
        else {
          // showToast(msg: 'error');
        }
      },
      builder: (context, state) {
        if (state == NetworkState.initial) {
          return const InternetError(text: TX_CHECK_INTERNET);
        } else if (state == NetworkState.gained) {
          return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: CustomAppBar(
                    isleading: false,
                  ),
                ),
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        foregroundColor: Colors.blue,
                        title: SizedBox(
                          width: 250,
                          child: Chip(
                              elevation: 1,
                              padding: const EdgeInsets.all(8),
                              backgroundColor: Colors.greenAccent[100],
                              shadowColor: Colors.black,
                              label: Row(
                                children: [
                                  const Text(
                                    'Current Consult: ',
                                    style: TextStyle(fontSize: 14),
                                  ), //Tex
                                  SizedBox(
                                    height: 20,
                                    width: 100,
                                    child: FutureBuilder(
                                      future: getAllAppointments(),
                                      builder: (context, snapshot) {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            itemCount: 1,
                                            itemBuilder: (context, index) {
                                              return Text(
                                                dataHomeFlag
                                                    ? ''
                                                    : '#${dataAppointments.length == 0 ? '' : dataAppointments[0]['appointment_no'] ?? ''}',
                                                style: const TextStyle(
                                                    fontSize: 16, fontWeight: FontWeight.w900),
                                              );
                                            });
                                      },
                                    ),
                                  ), //Tex
                                ],
                              )),
                        ),
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
                          tabs: const [
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
                  body: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      header: const WaterDropMaterialHeader(color: Colors.white,backgroundColor: Colors.blue),
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      controller: _refreshController,
                      child: _tabBarViewWorld()),
                ),
              ));
        } else if (state == NetworkState.lost) {
          return const InternetError(text: TX_LOST_INTERNET);
        } else {
          return const InternetError(text: 'error');
        }
      },
    );

  }

  Widget _tabBarViewWorld() {
    return TabBarView(controller: _tabController, children: [
      NextAppointmentsDD(doctorId: widget.doctor_id),
      PauseAppointmentsDD(doctorId: widget.doctor_id),
      RejectedAppointmentsDD(doctorId: widget.doctor_id),
      CompletedAppointmentsDD(doctorId: widget.doctor_id),
    ]);
  }

  Widget TabBarLocal() {
    return TabBar(
      labelStyle: const TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      unselectedLabelColor: Colors.black54,
      labelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4,
      indicatorColor: Colors.amber,
      isScrollable: true,
      tabs: const [
        Tab(child: Text('Hot News')),
        Tab(child: Text('Hot News')),
        Tab(child: Text('Hot News')),
      ],
      controller: _tabController,
    );
  }
}
