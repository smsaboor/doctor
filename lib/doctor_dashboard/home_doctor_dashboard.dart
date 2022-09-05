import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:doctor/doctor_dashboard/appointments/appointment_tab.dart';
import 'package:doctor/doctor_dashboard/home_tab/home_tab.dart';
import 'package:doctor/doctor_dashboard/more_tab/more_tab.dart';
import 'package:doctor/doctor_dashboard/transaction_tab/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDashBoard extends StatefulWidget {
  @override
  _DoctorDashBoardState createState() => _DoctorDashBoardState();
}

class _DoctorDashBoardState extends State<DoctorDashBoard>
    with TickerProviderStateMixin {
  int currentPage = 0;
  int tabIndex = 0;


  var data;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString('userDetails');
    print('--44-------------------------${user}');
    setState(() {
      data = jsonStringToMap(user!);
    });
    print('--44-------------------------${data}');
  }

  jsonStringToMap(String data) {
    Map<String, dynamic> result = {};
    try{
      List<String> str = data
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll("'", "")
          .split(",");
      for (int i = 0; i < str.length; i++) {
        List<String> s = str[i].split(":");
        result.putIfAbsent(s[0].trim(), () => s[1].trim());
      }
    }catch(e){
      print('-------------------555$e');
    }
    return result;
  }


  // final List<Widget> _pages = [
  //   HomeTabDD(),
  //   TabAppointmentDD(doctor_id: data == null ? 'null' : data['user_id'],),
  //   TransactionTabDD(),
  //   MoreTabDD()
  // ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 70;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return Scaffold(
      body:data==null?Center(child: CircularProgressIndicator(),):getBody(data['user_id'],currentPage,data),
      bottomNavigationBar: CircleBottomNavigationBar(
        initialSelection: currentPage,
        barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        circleOutline: 15.0,
        shadowAllowance: 0.0,
        circleSize: 50.0,
        blurShadowRadius: 50.0,
        circleColor: Colors.blue,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey,
        tabs: getTabsData(),
        onTabChangedListener: (index) => setState(() => currentPage = index),
      ),
    );
  }
  getBody(String? userId, int currentPage, var data){
    switch(currentPage){
      case 0:
         return HomeTabDD(doctorId: userId,userData:data);
      case 1:
        return TabAppointmentDD(doctor_id: userId,userData:data);
      case 2:
        return TransactionTabDD(doctor_id:userId,userData:data);
        break;
      case 3:
        return MoreTabDD(userData:data,userID:data['user_id']);
    }
  }
}

List<TabData> getTabsData() {
  return [
    TabData(
      icon: Icons.home,
      iconSize: 25.0,
      title: 'Home',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.library_books,
      iconSize: 25,
      title: 'Appointment',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: LineAwesomeIcons.history,
      iconSize: 25,
      title: 'Transactions',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.more_horiz,
      iconSize: 25,
      title: 'More',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  ];
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'Appointment',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'Earning',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Alarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'Profile ',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}