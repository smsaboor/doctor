import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/doctor_dashboard/appointments/completed_appointment_card.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/add_doses.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/display_old_appointments.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/doses_card_all.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SaveConsultDD extends StatefulWidget {
  const SaveConsultDD(
      {Key? key,
      required this.appointmentNumber,
      this.patientName,
      this.patientId})
      : super(key: key);
  final appointmentNumber;
  final patientName;
  final patientId;

  @override
  _SaveConsultDDState createState() => _SaveConsultDDState();
}

class _SaveConsultDDState extends State<SaveConsultDD>
    with TickerProviderStateMixin {
  late TabController _tabController;

  var dataDoses;
  var response2;
  var dataOldAppointments;
  bool dataHomeFlag = true;
  bool appDonF = false;
  int status = 0;

  Future<void> getAllDoses() async {
    var API = '${API_BASE_URL}all_doses_api.php';
    Map<String, dynamic> body = {
      'appointment_no': widget.appointmentNumber.toString()
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      dataDoses = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
      });
    } else {}
  }
  String test='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa0';
  Future<void> getAllOldAppointments() async {
    setState(() {
      status = 1;
    });
    var API = '${API_BASE_URL}old_appointment_api.php';
    Map<String, dynamic> body = {'patient_id': widget.patientId.toString()};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      dataOldAppointments = jsonDecode(response.body.toString());
      if (dataOldAppointments[0]['status'] == 0) {
        setState(() {
          status = 2;
          dataOldAppointments = [];
        });
      } else {
        setState(() {
          status = 3;
        });
      }
    } else {}
  }

  Future<void> appointmentsDone() async {
    appDonF = true;
    var API = '${API_BASE_URL}complete_after_dose_api.php';
    Map<String, dynamic> body = {
      'appointment_no': widget.appointmentNumber.toString()
    };
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      dataDoses = jsonDecode(response.body.toString());
      setState(() {
        appDonF = false;
      });
      if (!mounted) return;
      Navigator.pop(context);
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDoses();
    getAllOldAppointments();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Row(children: <Widget>[
        const Text('Medicine Name',
            style: TextStyle(
              height: 3.0,
              fontSize: 20.2,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * .1,
        ),
        const Text('Type',
            style: TextStyle(
              height: 3.0,
              fontSize: 20.2,
              fontWeight: FontWeight.bold,
            )),
        const Spacer(),
        const Text('Dosage Time',
            style: TextStyle(
              height: 3.0,
              fontSize: 20.2,
              fontWeight: FontWeight.bold,
            )),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          isleading: false,
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Row(
                      children: [
                        //Tex
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24, // Changing Drawer Icon Size
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        ),
                        Text(
                          '#${widget.appointmentNumber}  ',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ), //
                        Text(
                          '${widget.patientName.length > 13 ?
                          widget.patientName.substring(0, 13)+'...' :
                          widget.patientName ?? ''}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ), // Tex
                      ],
                    ),
                  )),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,top: 8,bottom: 8),
                  child: SizedBox(
                    height: 20,
                    width: 100,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => AddDozesDD(
                                      button: 'Save',
                                      appNo: widget.appointmentNumber)))
                              .then((value) => dataHomeFlag = true);
                        },
                        child: const Text(
                          'Add Doses',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(55),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .02,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .40,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Medicine Name',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .25,
                          child: const Center(
                            child: Text(
                              'Dosage ',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .25,
                          child: const Center(
                              child: Text(
                            'Duration ',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ))),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .01,
                      ),
                    ],
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              elevation: 4.0,
              backgroundColor: Colors.blue,
              titleSpacing: 0.00,
              floating: true,
              pinned: true,
              snap: true,
            ),
          ];
        },
        body: ListView(
          children: [
            dataHomeFlag
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: FutureBuilder(
                      future: getAllDoses(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: dataDoses.length,
                            itemBuilder: (context, index) {
                              return DosesCardForAll(
                                doseId: dataDoses[index]['id'],
                                index: index,
                                button: 'button',
                                medicineName: dataDoses[index]['pills_name'],
                                medicineType: dataDoses[index]['pills_type'],
                                medicinePower: dataDoses[index]['pills_power'],
                                medicinDoses: dataDoses[index]['pills_dose'],
                                image:
                                    'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=940&q=80',
                                medicineRepetationPerDay: dataDoses[index]
                                    ['pills_timing'],
                                medicineRepedationLongTime: dataDoses[index]
                                    ['pills_repeat_timing'],
                                notes: dataDoses[index]['note'],
                              );
                            });
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    appointmentsDone();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      textStyle:
                          const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  child: appDonF
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.green,
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Old Appointments',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            status == 0
                ? const Text('')
                : status == 1
                    ? const Center(child: Text('Searching....'))
                    : status == 2
                        ? const Center(child: Text('No Data Found'))
                        : status == 3
                            ? const Text('')
                            : const Text('oops something wrong please try again '),
            status != 3
                ? const Center(child: Text(''))
                : Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: dataOldAppointments.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => DisplayOldAppointments(
                                      appointmentNumber:
                                          dataOldAppointments[index]
                                                  ['appointment_no'] ??
                                              '',
                                      patientName: dataOldAppointments[index]
                                              ['patient_name'] ??
                                          '',
                                      date: dataOldAppointments[index]['date'],
                                      doses: dataOldAppointments[index]
                                          ['Dose'])));
                            },
                            child: CompletedAppointmentCard(
                              button: 'Reactive Consult',
                              image: dataOldAppointments[index]['image'] ?? '',
                              appointment_no: dataOldAppointments[index]
                                      ['appointment_no'] ??
                                  '',
                              booking_type: dataOldAppointments[index]
                                      ['booking_type'] ??
                                  '',
                              address:
                                  dataOldAppointments[index]['address'] ?? '',
                              due_payment: dataOldAppointments[index]
                                      ['due_payment'] ??
                                  '',
                              age: dataOldAppointments[index]['age'] ?? '',
                              date: dataOldAppointments[index]['date'] ?? '',
                              gender:
                                  dataOldAppointments[index]['gender'] ?? '',
                              patient_name: dataOldAppointments[index]
                                      ['patient_name'] ??
                                  '',
                              received_payment: dataOldAppointments[index]
                                      ['received_payment'] ??
                                  '',
                              total_fees: dataOldAppointments[index]
                                      ['total_fees'] ??
                                  '',
                              doses: dataOldAppointments[index]['dose'],
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
