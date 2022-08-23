import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:doctor/dashboard_patient/tabs/tab_profile/patient_profile_home.dart';
import 'package:doctor/dashboard_patient/tabs/tab_home/patient_home_tab.dart';
import 'package:doctor/dashboard_patient/upcomming_appointments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class PatientDashboard extends StatefulWidget {
  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard>
    with TickerProviderStateMixin {
  int currentPage = 0;
  int tabIndex = 0;

  final List<Widget> _pages = [
    TabHomePatient(),
    UpcomingApointments(),
    Search(),
    PatientProfilePD()
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body:_pages[currentPage],
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
        circleColor: Colors.purple,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey,
        tabs: getTabsData(),
        onTabChangedListener: (index) => setState(() => currentPage = index),
      ),
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
      icon: Icons.perm_identity,
      iconSize: 25,
      title: 'Profile',
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

//
// class HomeDoctorDashBoard extends StatefulWidget {
//   const HomeDoctorDashBoard({Key? key}) : super(key: key);
//
//   @override
//   _HomeDoctorDashBoardState createState() => _HomeDoctorDashBoardState();
// }
//
// class _HomeDoctorDashBoardState extends State<HomeDoctorDashBoard> {
//   int pageIndex = 0;
//
//   final CKL_SELECTPAGE = [
//     Container(
//       child: Center(
//         child: Text('body 1'),
//       ),
//     ),
//     Container(
//       child: Center(
//         child: Text('body 2'),
//       ),
//     ),
//     Container(
//       child: Center(
//         child: Text('body 3'),
//       ),
//     ),
//     Container(
//       child: Center(
//         child: Text('body 4'),
//       ),
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Doctor Dashboard'),
//       ),
//       body: CKL_SELECTPAGE.elementAt(pageIndex),
//       bottomNavigationBar: bottomNav(context),
//     );
//   }
//
//   Widget bottomNav(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       type: BottomNavigationBarType.fixed,
//       currentIndex: pageIndex,
//       onTap: (index) => {
//         setState(() {
//           pageIndex = index;
//         })
//       },
//       selectedFontSize: 24,
//       unselectedFontSize: 20,
//       elevation: 0,
//       items: [
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             'assets/images/navigation_icon/svg/home_nfill.svg',
//             color:
//                 Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
//             width: 24,
//           ),
//           label: 'Home',
//           activeIcon: SvgPicture.asset(
//             'assets/images/navigation_icon/svg/home_nfill.svg',
//             color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
//             width: 24,
//           ),
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             'assets/images/navigation_icon/svg/search.svg',
//             color: Colors.pink,
//             width: 24,
//           ),
//           label: 'Appointment',
//           activeIcon: SvgPicture.asset(
//             'assets/images/navigation_icon/svg/search.svg',
//             color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
//             width: 24,
//           ),
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             'assets/images/navigation_icon/svg/quran_nfill.svg',
//             width: 24,
//             color:
//                 Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
//           ),
//           label: 'Earning',
//           activeIcon: SvgPicture.asset(
//             'assets/images/navigation_icon/svg/quran_nfill.svg',
//             color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
//             width: 24,
//           ),
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             'assets/images/navigation_icon/svg/bookmark_nfill.svg',
//             color:
//                 Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
//             width: 24,
//           ),
//           label: 'Profile',
//           activeIcon: SvgPicture.asset(
//             'assets/images/navigation_icon/svg/bookmark_nfill.svg',
//             color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
//             width: 24,
//           ),
//         ),
//       ],
//     );
//   }
// }
