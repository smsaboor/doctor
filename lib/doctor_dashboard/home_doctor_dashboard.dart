import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter_package1/bottom_nav/bottom_nav_cubit.dart';
import 'package:flutter_package1/bottom_nav/nav_bar_items.dart';
import 'package:doctor/doctor_dashboard/appointments/appointment_tab.dart';
import 'package:doctor/doctor_dashboard/home_tab/home_tab.dart';
import 'package:doctor/doctor_dashboard/more_tab/more_tab.dart';
import 'package:doctor/doctor_dashboard/transaction_tab/transaction.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    setState(() {
      data = jsonStringToMap(user!);
    });
  }

  jsonStringToMap(String data) {
    Map<String, dynamic> result = {};
    try {
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
    } catch (e) {
      print(e);
    }
    return result;
  }

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
      body: data == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
              if (state.navbarItem == NavbarItem.index1) {
                return HomeTabDD(doctorId: data['user_id'], userData: data);
              } else if (state.navbarItem == NavbarItem.index2) {
                return TabAppointmentDD(doctor_id: data['user_id'], userData: data);
              } else if (state.navbarItem == NavbarItem.index3) {
                return TransactionTabDD(doctor_id: data['user_id'], userData: data);
              } else if (state.navbarItem == NavbarItem.index4) {
                return  MoreTabDD(userData: data, userID: data['user_id']);
              }
              return Container();
            }),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return CircleBottomNavigationBar(
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
          onTabChangedListener: (index) {
            if (index == 0) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.index1);
            } else if (index == 1) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.index2);
            } else if (index == 2) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.index3);
            } else if (index == 3) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.index4);
            }
          },
        );
      }),
    );
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
    return const Scaffold(
      body: Center(
        child: Text(
          'Home',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Appointment',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Earning',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Alarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Profile ',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
