
import 'package:doctor/doctor_dashboard/appointments/save_consult/doses_card_all_old_appointments.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/material.dart';

class DisplayOldAppointments extends StatefulWidget {
  const DisplayOldAppointments(
      {Key? key,
        required this.doses, this.date,this.appointmentNumber,this.patientName})
      : super(key: key);
  final doses;
  final date;
  final appointmentNumber,patientName;

  @override
  _DisplayOldAppointmentsState createState() => _DisplayOldAppointmentsState();
}

class _DisplayOldAppointmentsState extends State<DisplayOldAppointments>
    with TickerProviderStateMixin {
  late TabController _tabController;

  var dataDoses;
  var response2;
  var dataOldAppointments;
  bool dataHomeFlag = true;
  bool flagOldAppointments = true;
  bool appDonF = false;

  Future<void> getAllDoses() async {
   dataDoses=widget.doses;
   dataHomeFlag=false;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDoses();
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
                  width: MediaQuery.of(context).size.width * .6,
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
                          '${widget.patientName}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ), // Tex
                      ],
                    ),
                  )),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Center(child: Text(widget.date,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
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
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Container()));
                          },
                          child: DosesCardForAllForOldAppointments(
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
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
