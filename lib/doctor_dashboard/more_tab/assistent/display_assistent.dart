import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/constants/urls.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/core/avatar_image.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:doctor/doctor_dashboard/more_tab/assistent/add_assistent.dart';
import 'package:doctor/doctor_dashboard/more_tab/assistent/edit_assistent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_package1/loading/loading_card_list.dart';

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
  bool dataHomeFlag = true;

  Future<void> getAllAssistants() async {
    var API = API_BASE_URL + API_DD_ASSISTENT_LIST;
    Map<String, dynamic> body = {'doctor_id': widget.doctorId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      dataAssistence = jsonDecode(response.body.toString());
      print('----getAllAssistants---${body}-----------${dataAssistence}');
      setState(() {
        dataHomeFlag = false;
      });
    } else {}
  }

  Future<String> deleteAssistant(String id) async {
    var data;
    var API = API_BASE_URL + API_DD_ASSISTENT_DELETE;
    Map<String, dynamic> body = {'assistant_id': id};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag = false;
      });
      return data[0]['status'];
    } else {
      return 'fail';
    }
  }

  @override
  void initState() {
    super.initState();
    getAllAssistants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          isleading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.blue,
              title: const Text("All Assistants"),
            ),
            dataHomeFlag
                ? LoadingCardList()
                : FutureBuilder(
                    future: getAllAssistants(),
                    builder: (context, snapshot) {
                      return dataAssistence[0]['status'] == 0
                          ? const Center(
                              child: Text('No Data Found!'),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(
                                                          left: 15.0),
                                                  child: AvatarImagePD(
                                                      AppUrls.userNurse),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'Name:  ',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color:
                                                                    Colors.pink,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            '${dataAssistence[
                                                            index][
                                                            'assistant_name'] == null ? '' : (dataAssistence[
                                                            index][
                                                            'assistant_name'].length > 15
                                                                ? dataAssistence[
                                                            index][
                                                            'assistant_name']
                                                                .substring(0, 15) +
                                                                '...'
                                                                : dataAssistence[
                                                            index][
                                                            'assistant_name'] ?? '')}',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                'Mobile:  ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .pink,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                ' ${dataAssistence[
                                                                index]
                                                                [
                                                                'number'].toString().length > 14 ?
                                                                dataAssistence[
                                                                index]
                                                                [
                                                                'number'].substring(0, 14)+'...' :
                                                                dataAssistence[
                                                                index]
                                                                [
                                                                'number'].substring(0) ?? ''}',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'Status:  ',
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
                                                                    'status_order'] ??
                                                                '',
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'Address:',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.pink,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            ' ${dataAssistence[index]['address'].length > 16 ?
                                                            dataAssistence[index]['address'].substring(0, 16)+'...' :
                                                            dataAssistence[index]['address'].substring(0) ?? ''}',
                                                            style: const TextStyle(
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
                                                  left: 38.0,
                                                  right: 38,
                                                  top: 15),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        _showDialog(
                                                            dataAssistence[
                                                                    index][
                                                                'assistant_id']);
                                                      },
                                                      child: const Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                  const Spacer(),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (_) => EditAssistent(
                                                                    button:
                                                                        'Update',
                                                                    data: dataAssistence[
                                                                        index])));
                                                      },
                                                      child: const Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            const Divider(
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
            const SizedBox(
              height: 200,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddAssistent(
                    button: 'Add',
                    doctor_id: widget.doctorId,
                  )));
        },
        // isExtended: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
        String status = await deleteAssistant(id);
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
            const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: const TextStyle(fontSize: 16.0)),
                Text(charge, style: const TextStyle(fontSize: 16.0))
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dateString,
                    style: const TextStyle(color: Colors.grey, fontSize: 14.0)),
                Text(type, style: const TextStyle(color: Colors.grey, fontSize: 14.0))
              ],
            ),
          ],
        ),
      );
}
