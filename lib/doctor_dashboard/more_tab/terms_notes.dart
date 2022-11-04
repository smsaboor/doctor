import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/doctor_dashboard/custom_widgtes/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TermsOfServices extends StatefulWidget {
  const TermsOfServices({Key? key}) : super(key: key);
  @override
  State<TermsOfServices> createState() => _TermsOfServicesState();
}

class _TermsOfServicesState extends State<TermsOfServices> {
  var data;
  bool dataHomeFlag=true;
  Future<void> getTerms() async {
    var API = '${API_BASE_URL}term_condition_api.php';
    http.Response response = await http
        .post(Uri.parse(API))
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      setState(() {
        dataHomeFlag=false;
      });
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTerms();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(50),child: CustomAppBar(isleading: false),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: const Text('Terms And Conditions'),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'TERMS & CONDITIONS AND PRIVACY POLICY',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                  'Effective Date: May 2015',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black),
                ),
          ),
          dataHomeFlag?const Center(child: CircularProgressIndicator(),):Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child:Text(
                  '${data[0]['content']}',
                  style: const TextStyle(
                      fontSize: 12, color: Colors.black),
                ),)
          ),
        ],
      ),
    );
  }
}
