import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/dashboard_patient/data/json.dart';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/transaction_card.dart';
import 'package:doctor/doctor_dashboard/more_tab/assistent/add_assistent.dart';
import 'package:doctor/doctor_dashboard/more_tab/assistent/assistents_card.dart';
import 'package:doctor/doctor_dashboard/more_tab/assistent/edit_assistent.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class DisplayAssistents extends StatefulWidget {
  const DisplayAssistents(
      {Key? key, required this.doctorId, required this.userData})
      : super(key: key);
  final doctorId;
  final userData;

  @override
  _DisplayAssistentsState createState() => _DisplayAssistentsState();
}

class _DisplayAssistentsState extends State<DisplayAssistents> {
  DateTime selectedDate = DateTime.now();

  var dataAssistence;
  var response2;
  bool dataHomeFlag = true;

  Future<void> getAllAssitents() async {
    print('.widget.doctorId..............................${widget.doctorId}');
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/assistant_list_api.php';
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getAllAssitents: $error"));
    print('...............................${response.body}');
    response2 = response.body;
    if (response.statusCode == 200) {
      print('..22222222222222222222222222222222....${response.body}');
      dataAssistence = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
      });
      print('..22222222222222222222222222222222....${dataAssistence.length}');
      print(
          '..2222222222222222222222222222data....${dataAssistence[0]['assistant_name']}');
    } else {}
  }

  Future<String> deleteAssitent(String id) async {
    print('.widget.doctorId..............................${widget.doctorId}');
    var data;
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/delete_assistant_api.php';
    Map<String, dynamic> body = {'assistant_id': id};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(" Failed to delete: $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      print('..22222222222222222222222222222222....${response.body}');
      data = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
      });
      print('..22222222222222222222222222222222....${data.length}');
      return data[0]['status'];
    } else {
      return 'fail';
    }
  }

  @override
  void initState() {
    super.initState();
    getAllAssitents();
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
          print('${widget.doctorId}');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddAssistent(
                    button: 'Add',
                    doctor_id: widget.doctorId,
                  )));
        },
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   bottomOpacity: 0.0,
      //   elevation: 0.0,
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           Text(
      //             'Dr. Abhishekh',
      //             style: TextStyle(
      //               fontSize: 14.0,
      //               color: Colors.black,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           Text(
      //             'MBBS',
      //             style: TextStyle(
      //               fontSize: 14.0,
      //               color: Colors.black,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
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
      //   titleSpacing: 0.00,
      //   title: Image.asset(
      //     'assets/img_2.png',
      //     width: 150,
      //     height: 90,
      //   ),
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          isleading: false,
        ),
      ),
      body: dataHomeFlag
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.blue,
                    title: Text("All Assistents"),
                  ),
                  FutureBuilder(
                    future: getAllAssitents(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: dataAssistence.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 5, bottom: 5, top: 5),
                              child: SizedBox(
                                height: 220,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 10,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    side: BorderSide(color: Colors.white),
                                  ),
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
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: AvatarImagePD(
                                                dataAssistence[index]
                                                        ['image'] ??
                                                    'https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Name:  ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.pink,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        dataAssistence[index][
                                                                'assistant_name'] ??
                                                            '',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Mobile:  ',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.pink,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            dataAssistence[
                                                                        index][
                                                                    'number'] ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Status:  ',
                                                        style: TextStyle(
                                                            color: Colors.pink,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        dataAssistence[index][
                                                                'status_order'] ??
                                                            '',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Address:',
                                                        style: TextStyle(
                                                            color: Colors.pink,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        dataAssistence[index]
                                                                ['address'] ??
                                                            '',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ])
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 38.0, right: 38,top: 15),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    _showDialog(
                                                        dataAssistence[index]
                                                            ['assistant_id']);
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              Spacer(),
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                EditAssistent(
                                                                    button:
                                                                        'Update',
                                                                    data: dataAssistence[
                                                                        index])));
                                                  },
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
    );
  }

  _showDialog(String id) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      borderSide: const BorderSide(
        color: Colors.green,
        width: 2,
      ),
      width: MediaQuery.of(context).size.width,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      showCloseIcon: true,
      title: 'Delete',
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      desc: 'Are You Confirm to delete.',
      btnOkOnPress: () async {
        String status = await deleteAssitent(id);
        if (status == 'ok') {
          CustomSnackBar.snackBar(
              context: context,
              data: 'Deleted Successfully !',
              color: Colors.green);
        } else {
          CustomSnackBar.snackBar(
              context: context, data: 'Deleted Fail !', color: Colors.red);
        }
      },
    ).show();
  }

  Container accountItems(
          String item, String charge, String dateString, String type,
          {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontSize: 16.0)),
                Text(charge, style: TextStyle(fontSize: 16.0))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dateString,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                Text(type, style: TextStyle(color: Colors.grey, fontSize: 14.0))
              ],
            ),
          ],
        ),
      );
}
