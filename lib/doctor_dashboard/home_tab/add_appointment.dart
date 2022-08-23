import 'dart:convert';
import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:doctor/doctor_dashboard/home_tab/add_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

class AddApointments extends StatefulWidget {
  const AddApointments({Key? key, required this.userData}) : super(key: key);
  final userData;

  @override
  _AddApointmentsState createState() => _AddApointmentsState();
}

class _AddApointmentsState extends State<AddApointments> {
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

  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = [];
  List filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  TextEditingController _controllerMobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          isleading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 24, // Changing Drawer Icon Size
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              title: Text("Book Appointment"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddPatient(mobile: '97788798')));
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Theme(
                data: ThemeData(
                  primaryColor: Colors.redAccent,
                  primaryColorDark: Colors.red,
                ),
                child: new TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _controllerMobile,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Your Mobile';
                    }
                    return null;
                  },
                  onChanged: (v) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'search patient with patient mobile or name',
                      prefixText: ' ',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // dataF
            //     ? Center(child: CircularProgressIndicator())
            //     : FutureBuilder(
            //         future: isDate ? getDateTrans() : getAllTrans(),
            //         builder: (context, snapshot) {
            //           return isDate == true
            //               ? dataTransactionDate[0]['transaction_id'] == null
            //                   ? Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       crossAxisAlignment: CrossAxisAlignment.center,
            //                       children: [
            //                         Center(
            //                           child: Text('Sorry No Data Available'),
            //                         ),
            //                       ],
            //                     )
            //                   : ListView.builder(
            //                       shrinkWrap: true,
            //                       physics: ScrollPhysics(),
            //                       itemCount: dataTransactionDate.length ?? 0,
            //                       itemBuilder: (context, index) {
            //                         return accountItems(
            //                             "Transaction: ${dataTransactionDate[index]['transaction_id']}",
            //                             '${dataTransactionDate[index]['amount']} Rs',
            //                             "${dataTransactionDate[index]['transaction_date']}",
            //                             '${dataTransactionDate[index]['transaction_type']}',
            //                             oddColour: const Color(0xFFF7F7F9));
            //                       })
            //               : ListView.builder(
            //                   shrinkWrap: true,
            //                   physics: ScrollPhysics(),
            //                   itemCount: dataTransaction.length ?? 0,
            //                   itemBuilder: (context, index) {
            //                     return accountItems(
            //                         "Transaction: ${dataTransaction[index]['transaction_id']}",
            //                         '${dataTransaction[index]['amount']} Rs',
            //                         "${dataTransaction[index]['transaction_date']}",
            //                         '${dataTransaction[index]['transaction_type']}',
            //                         oddColour: const Color(0xFFF7F7F9));
            //                   });
            //         })
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
