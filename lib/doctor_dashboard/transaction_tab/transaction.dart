import 'dart:convert';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TransactionTabDD extends StatefulWidget {
  const TransactionTabDD({Key? key, required this.userData}) : super(key: key);
  final userData;

  @override
  _TransactionTabDDState createState() => _TransactionTabDDState();
}

class _TransactionTabDDState extends State<TransactionTabDD> {
  var dataTransaction;
  var dataTransactionDate;
  bool dataF = true;
  bool isDate = false;

  Future<void> getAllTrans() async {
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/all_transactions_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(" Failed to getAllAssitents: $error"));
    print('...............................${response.body}');
    if (response.statusCode == 200) {
      setState(() {
        dataF = false;
      });
      print('..22222222222222222222222222222222....${response.body}');
      dataTransaction = jsonDecode(response.body.toString());
      print(
          '..22222222222222222222222222222222....${dataTransaction.length ?? 0}');
    } else {}
  }

  Future<void> getDateTrans() async {
    dataF = true;
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/datewise_transactions_api.php';
    Map<String, dynamic> body = {'date': '2022-08-10'};
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(" Failed to getAllAssitents: $error"));
    print('......./////////@@@@@@@@@........................${response.body}');
    if (response.statusCode == 200) {
      setState(() {
        dataF = false;
        isDate = true;
      });
      print('..22222222222222222222222222222222....${response.body}');
      dataTransactionDate = jsonDecode(response.body.toString());
      print(
          '..22222222222222222222222222222222....${dataTransaction.length ?? 0}');
    } else {}
  }

  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTrans();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        selectedDate = picked;
        getDateTrans();
        name = formattedDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   bottomOpacity: 0.0,
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
        child: CustomAppBar(isleading: false,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.blue,
              title: Text("All Transaction"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: SizedBox(
                      child: Image.asset('assets/images/cal.jpg'),
                      height: 30,
                      width: 30,
                    ),
                  ),
                )
              ],
            ),
            dataF
                ? Center(child: CircularProgressIndicator())
                : FutureBuilder(
                    future: isDate ? getDateTrans() : getAllTrans(),
                    builder: (context, snapshot) {
                      return isDate == true
                          ? dataTransactionDate[0]['transaction_id'] == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text('Sorry No Data Available'),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: dataTransactionDate.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return accountItems(
                                        "Transaction: ${dataTransactionDate[index]['transaction_id']}",
                                        '${dataTransactionDate[index]['amount']} Rs',
                                        "${dataTransactionDate[index]['transaction_date']}",
                                        '${dataTransactionDate[index]['transaction_type']}',
                                        oddColour: const Color(0xFFF7F7F9));
                                  })
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: dataTransaction.length ?? 0,
                              itemBuilder: (context, index) {
                                return accountItems(
                                    "Transaction: ${dataTransaction[index]['transaction_id']}",
                                    '${dataTransaction[index]['amount']} Rs',
                                    "${dataTransaction[index]['transaction_date']}",
                                    '${dataTransaction[index]['transaction_type']}',
                                    oddColour: const Color(0xFFF7F7F9));
                              });
                    })
          ],
        ),
      ),
    );
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
