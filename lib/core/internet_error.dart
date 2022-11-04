import 'package:doctor/doctor_dashboard/home_doctor_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/bottom_nav/bottom_nav_cubit.dart';
import 'package:flutter_package1/components.dart';


class InternetError extends StatelessWidget {
  const InternetError({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.red,
                onPrimary: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
              ),
              onPressed: () {
                BlocProvider.of<NavigationCubit>(context).setNavBarItem(0);
                navigateAndFinsh(context, DoctorDashBoard());
              },
              child: const Text(
                'try again',
                style: TextStyle(fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
