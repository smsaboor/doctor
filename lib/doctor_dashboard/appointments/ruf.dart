// import 'package:doctor/screens/doctors_tab/payment_sheet.dart';
// import 'package:doctor/screens/doctors_tab/request_sheet.dart';
// import 'package:doctor/screens/home/data/json.dart';
// import 'package:doctor/screens/home/theme/colors.dart';
// import 'package:doctor/screens/home/widgets/avatar_image.dart';
// import 'package:doctor/screens/home/widgets/doctor_info_box.dart';
// import 'package:doctor/screens/home/widgets/mybutton.dart';
// import 'package:flutter/material.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:intl/intl.dart';
//
// enum SingingCharacter { Normal, Emergency }
//
// class AddDozes extends StatefulWidget {
//   const AddDozes({Key? key})
//       : super(key: key);
//   @override
//   _AddDozesState createState() => _AddDozesState();
// }
//
// class _AddDozesState extends State<AddDozes> {
//   SingingCharacter? _character = SingingCharacter.Normal;
//   int index = 0;
//   final TextEditingController _startDateController =
//   new TextEditingController();
//
//   void _modalMenu() {
//     showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return PaymentSheet();
//       },
//     );
//   }
//
//   String? symptoms = 'Symptom';
//   var symptomsList = [
//     "Symptom",
//     "Fever",
//     "Cough",
//     "Pain",
//     "Headche",
//     "Sneezing",
//     "Joint Pain",
//     "Heart Pain",
//     "Kindney Pain",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           "Booking Schedule",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: getBody(),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//         child: MyButton(
//             disableButton: false,
//             bgColor: primary,
//             title: "Book Now",
//             onTap: () {
//               _modalMenu();
//             }),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
//
//   getBody() {
//     return SingleChildScrollView(
//       padding: EdgeInsets.only(left: 15, right: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 25,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width * .15,
//                   height: MediaQuery.of(context).size.width * .15,
//                   child: CircleAvatar(
//                     backgroundColor: Color(0xff125ace),
//                     child: Text(
//                       'saboor'.toString()[0].toUpperCase(),
//                       style: TextStyle(
//                           fontSize: MediaQuery.of(context).size.width * .10,
//                           color: Colors.white),
//                     ), //Text
//                   ), //circleAvatar,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 18.0, top: 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('saboor'.toString(),
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w700)),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text('brother'.toString(),
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.pink)),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "Age: '23.toString()}",
//                       style: TextStyle(color: Colors.black87, fontSize: 14),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Gender: ",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           "male",
//                           style: TextStyle(
//                               color: Colors.blueAccent,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.white70, borderRadius: BorderRadius.circular(10)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // ContactBox(icon: Icons.videocam_rounded, color: Colors.blue,),
//                 Center(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * .9,
//                     height: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.8),
//                           spreadRadius: 1,
//                           blurRadius: 1,
//                           offset: Offset(1, 1), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 8.0, left: 1),
//                       child: Column(
//                         children: [
//                           Text('angora'.toString(),
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.w700)),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text('dr Prashant'.toString(),
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.w500)),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             children: [
//                               Flexible(
//                                 flex: 1,
//                                 child: RadioListTile<SingingCharacter>(
//                                   title: const Text('Normal'),
//                                   value: SingingCharacter.Normal,
//                                   groupValue: _character,
//                                   onChanged: (SingingCharacter? value) {
//                                     setState(() {
//                                       _character = value;
//                                       index = 0;
//                                     });
//                                   },
//                                 ),
//                               ),
//                               Flexible(
//                                 flex: 1,
//                                 child: RadioListTile<SingingCharacter>(
//                                   title: const Text('Emergency'),
//                                   value: SingingCharacter.Emergency,
//                                   groupValue: _character,
//                                   onChanged: (SingingCharacter? value) {
//                                     setState(() {
//                                       _character = value;
//                                       index = 1;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             margin: const EdgeInsets.all(15.0),
//                             padding: const EdgeInsets.only(left: 5.0),
//                             //decoration: myBoxDecoration(),
//                             height: 80,
//                             width: MediaQuery.of(context).size.width,
//                             child: Row(
//                               children: <Widget>[
//                                 Theme(
//                                   data: new ThemeData(
//                                     primaryColor: Colors.redAccent,
//                                     primaryColorDark: Colors.red,
//                                   ),
//                                   child: Expanded(
//                                     child: DateTimeField(
//                                       controller: _startDateController,
//                                       //editable: false,
//                                       validator: (value) {
//                                         if (_startDateController.text.length ==
//                                             0) {
//                                           return 'Enter Booking Date';
//                                         }
//                                         return null;
//                                       },
//                                       decoration: new InputDecoration(
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Colors.red, width: 1.0),
//                                         ),
//                                         enabledBorder: const OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: Colors.black26,
//                                               width: 1.0),
//                                         ),
//                                         border: const OutlineInputBorder(),
//                                         labelText: 'Booking Date',
//                                         labelStyle: const TextStyle(
//                                           fontSize: 14.0,
//                                         ),
//                                       ),
//                                       format: DateFormat("dd-MM-yyyy"),
//                                       onShowPicker: (context, currentValue) {
//                                         return showDatePicker(
//                                           context: context,
//                                           initialDate: DateTime.now(),
//                                           firstDate: DateTime.now().subtract(
//                                               new Duration(days: 400)),
//                                           lastDate: DateTime.now().add(
//                                               new Duration(days: 400)),);
//                                       },
//                                       onChanged: (dt) {
//                                         setState() {}
//                                         // _endDateController.text =
//                                         //     new DateFormat("yyyy-MM-dd").format(dt?.add(new Duration(days: 354)) ?? DateTime.now());
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Theme(
//                             data: new ThemeData(
//                               primaryColor: Colors.redAccent,
//                               primaryColorDark: Colors.red,
//                             ),
//                             child: Container(
//                               margin: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 15),
//                               padding: const EdgeInsets.only(left: 10.0),
//                               decoration: myBoxDecoration(),
//                               height: 60,
//                               width: MediaQuery.of(context).size.width,
//                               //          <// --- BoxDecoration here
//                               child: DropdownButton(
//                                 // Initial Value
//                                   menuMaxHeight:
//                                   MediaQuery.of(context).size.height,
//                                   value: symptoms,
//                                   dropdownColor: Colors.white,
//                                   focusColor: Colors.blue,
//                                   isExpanded: true,
//                                   // Down Arrow Icon
//                                   icon: const Icon(Icons.keyboard_arrow_down),
//                                   // Array list of items
//                                   items: symptomsList.map((String items) {
//                                     return DropdownMenuItem(
//                                       value: items,
//                                       child: Text(items),
//                                     );
//                                   }).toList(),
//                                   // After selecting the desired option,it will
//                                   // change button value to selected value
//                                   onChanged: (spec) {
//                                     if (mounted) {
//                                       setState(() {
//                                         symptoms = spec.toString();
//                                       });
//                                     }
//                                     print('------------------${spec}');
//                                   }),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 18.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text('Current Status',
//                                         style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w600
//                                         )),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text('Book No: 125',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             color: Colors.pink,
//                                             fontWeight: FontWeight.w600)),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: 50,
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text('Appointment Fees',
//                                         style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w600)),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text('Rs: 500',
//                                         style: TextStyle(
//                                             fontSize: 20,
//                                             color: Colors.pink,
//                                             fontWeight: FontWeight.w500)),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 0.0,top: 25),
//                             child: Container(
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                                   child: Container(
//                                     width: 250,
//                                     height: 40,
//                                     color: Colors.orange,
//                                     child: Stack(
//                                       fit: StackFit.expand,
//                                       children: <Widget>[
//                                         Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                           children: <Widget>[
//                                             Text(
//                                               'Estimate Time: 2 Hours',
//                                               style: TextStyle(
//                                                   fontSize: 17,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.white),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//         ],
//       ),
//     );
//   }
//
//   BoxDecoration myBoxDecoration() {
//     return BoxDecoration(
//       border: Border.all(width: 1.0, color: Colors.black26),
//       borderRadius: BorderRadius.all(
//           Radius.circular(5.0) //                 <--- border radius here
//       ),
//     );
//   }
// }
