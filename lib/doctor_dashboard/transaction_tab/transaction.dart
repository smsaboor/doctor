import 'dart:convert';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TransactionTabDD extends StatefulWidget {
  const TransactionTabDD({Key? key, required this.userData,this.doctor_id}) : super(key: key);
  final userData;
  final doctor_id;

  @override
  _TransactionTabDDState createState() => _TransactionTabDDState();
}

class _TransactionTabDDState extends State<TransactionTabDD> {
  var dataTransaction;
  var dataTransactionDate;
  bool dataF = true;
  bool isDate = false;


  String? name='2022-08-09';

  Future<void> getAllTrans() async {
    var API =
        'https://cabeloclinic.com/website/medlife/php_auth_api/all_transactions_api.php';
    Map<String, dynamic> body={'doctor_id':widget.doctor_id};
    http.Response response = await http
        .post(Uri.parse(API),body: body)
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

  Future<void> getDateTrans(String date) async {
    dataF=true;
    print('date: $date');
    var API = 'https://cabeloclinic.com/website/medlife/php_auth_api/datewise_transactions_api.php';
    print('date tra...2.....................${widget.doctor_id}');
    Map<String, dynamic> body = {'doctor_id':widget.doctor_id,'date': date};
    http.Response response = await http
        .post(Uri.parse(API),body:body)
        .then((value) => value)
        .catchError((error) => print(" Failed to getAllAssitents: $error"));
    print('.date tra........................${response.body}');
    if (response.statusCode == 200) {
      setState(() {
        dataF = false;
        isDate = true;
      });
      print('..22222222222222222222222222222222....${response.body}');
      dataTransaction = jsonDecode(response.body.toString());
      print(
          '..22222222222222222222222222222222....${dataTransaction.length ?? 0}');
    } else {}
  }



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
        name = formattedDate.toString();
        getDateTrans(name.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
