// import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
// import 'package:doctor/doctor_dashboard/appointments/save_consult.dart';
// import 'package:flutter/material.dart';
//
// class CustomAppointmentCardWithButton extends StatefulWidget {
//   const CustomAppointmentCardWithButton({Key? key, required this.button})
//       : super(key: key);
//   final button;
//
//   @override
//   _CustomAppointmentCardWithButtonState createState() =>
//       _CustomAppointmentCardWithButtonState();
// }
//
// class _CustomAppointmentCardWithButtonState
//     extends State<CustomAppointmentCardWithButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10.0, right: 5, bottom: 5, top: 5),
//       child: SizedBox(
//         height: 290,
//         width: MediaQuery
//             .of(context)
//             .size
//             .width * .9,
//         child: Card(
//           elevation: 10,
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             side: BorderSide(color: Colors.white),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8.0, top: 15),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15.0),
//                       child: AvatarImagePD(
//                         "https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               'Appointment:',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text(
//                               '  #2346688',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               'Booking Type:',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text(
//                               '  Online',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               'Date:',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text(
//                               '  15/6/2022',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               'Name:',
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.pink,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text(
//                               '  Arjun Singh',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   'Sex:',
//                                   style: TextStyle(
//                                       color: Colors.pink,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 Text(
//                                   ' Male,',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   'Age:',
//                                   style: TextStyle(
//                                       color: Colors.pink,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 Text(
//                                   ' 36',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               'Address:',
//                               style: TextStyle(
//                                   color: Colors.pink,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text(
//                               '  New Delhi',
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 Divider(
//                   color: Colors.black12,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'Total Fees: ',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87),
//                         ),
//                         Text(
//                           '1700',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black87),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           'Received: ',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87),
//                         ),
//                         Text(
//                           '1000',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           'Due: ',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87),
//                         ),
//                         Text(
//                           '700',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Divider(
//                   color: Colors.black12,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: MediaQuery
//                         .of(context)
//                         .size
//                         .width * .8,
//                     height: 50,
//                     child: Container(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (_) =>
//                                   SaveConsultDD(
//                                     appointmentNumber:, patientName:,)));
//                         },
//                         style: ElevatedButton.styleFrom(
//                             primary: Colors.pink,
//                             textStyle: TextStyle(
//                                 fontSize: 30, fontWeight: FontWeight.bold)),
//                         child: Text(
//                           widget.button,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 20),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //   children: [
//                 //   Text(
//                 //     'Total',
//                 //     style: TextStyle(
//                 //         fontSize: 16,
//                 //         fontWeight: FontWeight.w600,
//                 //         color: Colors.black87),
//                 //   ),
//                 //   Text(
//                 //     'Received',
//                 //     style: TextStyle(
//                 //         fontSize: 16,
//                 //         fontWeight: FontWeight.w600,
//                 //         color: Colors.black87),
//                 //   ),
//                 //   Text(
//                 //     'Due',
//                 //     style: TextStyle(
//                 //         fontSize: 16,
//                 //         fontWeight: FontWeight.w600,
//                 //         color: Colors.black87),
//                 //   ),
//                 // ],),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //   children: [
//                 //     Text(
//                 //       '1200 Rs',
//                 //       style: TextStyle(
//                 //           fontSize: 16,
//                 //           fontWeight: FontWeight.w400,
//                 //           color: Colors.black87),
//                 //     ),
//                 //     Text(
//                 //       '800',
//                 //       style: TextStyle(
//                 //           fontSize: 16,
//                 //           fontWeight: FontWeight.w400,
//                 //           color: Colors.black87),
//                 //     ),
//                 //     Text(
//                 //       '400',
//                 //       style: TextStyle(
//                 //           fontSize: 16,
//                 //           fontWeight: FontWeight.w400,
//                 //           color: Colors.black87),
//                 //     ),
//                 //   ],)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
