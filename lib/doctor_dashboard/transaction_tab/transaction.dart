import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/internet_error.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/data_connection_checker/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_package1/loading/loading_transaction.dart';

class TransactionTabDD extends StatefulWidget {
  const TransactionTabDD({Key? key, required this.userData, this.doctor_id})
      : super(key: key);
  final userData;
  final doctor_id;

  @override
  _TransactionTabDDState createState() => _TransactionTabDDState();
}

class _TransactionTabDDState extends State<TransactionTabDD> {
  var dataTransaction;
  var dataTransactionDate;
  bool dataF = true;
  bool dataFF = true;
  bool isDate = false;

  String? name = '2022-08-09';
  var data2;

  Future<void> getAllTrans() async {
    setState(() {
      dataF = true;
    });
    var API = '${API_BASE_URL}all_transactions_api.php';
    Map<String, dynamic> body = {'doctor_id': widget.doctor_id};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      setState(() {
        dataF = false;
      });
      dataTransaction = jsonDecode(response.body.toString());
      print('---dataTransaction---------------------------${dataTransaction}');
      print(
          '---dataTransaction---------------------------${dataTransaction.length}');
    } else {}
  }

  Future<void> getDateTrans(String date) async {
    dataF = true;
    print('date: $date');
    var API = '${API_BASE_URL}datewise_transactions_api.php';
    Map<String, dynamic> body = {'doctor_id': widget.doctor_id, 'date': date};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      setState(() {
        dataF = false;
        isDate = true;
      });
      dataTransaction = jsonDecode(response.body.toString());
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

  callApis() {
    getAllTrans();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
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
    return BlocConsumer<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state == NetworkState.initial) {
          // showToast(msg: 'Network Searching....');
        } else if (state == NetworkState.gained) {
          callApis();
          // showToast(msg: 'TX_ONLINE');
        } else if (state == NetworkState.lost) {
          // showToast(msg: 'TX_OFFLINE');
        } else {
          // showToast(msg: 'error');
        }
      },
      builder: (context, state) {
        if (state == NetworkState.initial) {
          return const InternetError(text: TX_CHECK_INTERNET);
        } else if (state == NetworkState.gained) {
          print('----------------------23');
          return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBar(
                isleading: false,
              ),
            ),
            body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: const WaterDropMaterialHeader(
                    color: Colors.white, backgroundColor: Colors.blue),
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                controller: _refreshController,
                child: getBody()),
          );
        } else if (state == NetworkState.lost) {
          return const InternetError(text: TX_LOST_INTERNET);
        } else {
          return const InternetError(text: 'error');
        }
      },
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.blue,
            automaticallyImplyLeading: false,
            title: const Text('All Transactions'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset('assets/images/cal.jpg'),
                  ),
                ),
              )
            ],
          ),
          dataF
              ? Column(
                  children: const [
                    LoadingCardTransaction(),
                    LoadingCardTransaction(),
                    LoadingCardTransaction(),
                    LoadingCardTransaction(),
                    LoadingCardTransaction(),
                  ],
                )
              : dataTransaction.length == 0
                  ? const Text(
                      'No Transaction Found!',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: dataTransaction.length ?? 0,
                      itemBuilder: (context, index) {
                        return accountItems(
                            "Id: ${dataTransaction[index]['transaction_id']}",
                            'Paid  : ${dataTransaction[index]['amount_paid']} Rs',
                            "Date: ${dataTransaction[index]['transaction_date']}",
                            'Type: ${dataTransaction[index]['booking_type']}',
                            'Appointment No: ${dataTransaction[index]['receipt_no']}',
                            'Total : ${dataTransaction[index]['amount']} Rs',
                            'Due   : ${dataTransaction[index]['amount_due']} RS',
                            'status: ${dataTransaction[index]['transaction_status']}',
                            oddColour: const Color(0xFFF7F7F9));
                      })
        ],
      ),
    );
  }

  Container accountItems(
          String tran_id,
          String amount_paid,
          String date,
          String tran_type,
          String apntmnt_no,
          String total_amount,
          String amount_due,
          String status,
          {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        // padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Transaction Details',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(tran_id,
                            style: const TextStyle(fontSize: 14.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(apntmnt_no,
                            style: const TextStyle(fontSize: 14.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child:
                            Text(date, style: const TextStyle(fontSize: 14.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(status,
                            style: const TextStyle(fontSize: 14.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(tran_type,
                            style: const TextStyle(fontSize: 14.0)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Amount Details',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(total_amount,
                            style: const TextStyle(fontSize: 14.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(amount_paid,
                            style: const TextStyle(fontSize: 14.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(amount_due,
                            style: const TextStyle(fontSize: 14.0)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.black,
            )
          ],
        ),
      );
}
