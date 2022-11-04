import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/core/avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/core/constants/urls.dart';
class SearchPatientCard extends StatefulWidget {
  const SearchPatientCard(
      {Key? key,
        required this.button,
        this.appointment_no,
        this.name,
        this.booking_type,
        this.date,
        this.patient_name,
        this.patient_id,
        this.doctor_id,
        this.member_id,
        this.age,
        this.gender,
        this.address,
        this.total_fees,
        this.received_payment,
        this.due_payment})
      : super(key: key);
  final button;
  final appointment_no,
  name,
      booking_type,
      date,
      patient_name,
      patient_id,
      doctor_id,
      member_id,
      age,
      gender,
      address,
      total_fees,
      received_payment,
      due_payment;

  @override
  _SearchPatientCardState createState() => _SearchPatientCardState();
}

class _SearchPatientCardState extends State<SearchPatientCard> {
  int? _value;
  bool dataF = false;
  var dataBookAppointment;

  bookAppointments(String doctorId,String patientId,String memberId) async {
    setState(() {
      dataF = true;
    });
    var API = '${API_BASE_URL}member_appointment_api.php';
    Map<String, dynamic> body = {'doctor_id': doctorId,'patient_id': patientId,'member_id': memberId};
    http.Response response = await http
        .post(Uri.parse(API), body: body)
        .then((value) => value)
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      dataBookAppointment = jsonDecode(response.body.toString());
      setState(() {
        dataF = false;
      });
      CustomSnackBar.snackBar(
          context: context,
          data: 'Appointment Booked Successfully !',
          color: Colors.green);
    } else {
      setState(() {
        dataF = false;
      });
      CustomSnackBar.snackBar(
          context: context,
          data: 'Failed to Book Appointment !',
          color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 5, bottom: 5, top: 5),
      child: SizedBox(
        height: 210,
        width: MediaQuery.of(context).size.width * .9,
        child: Card(
          elevation: 10,
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: AvatarImagePD(
                        AppUrls.userPatient,
                      height: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ' ${widget.name.length > 16 ?
                              widget.name.substring(0, 16)+'...' :
                              widget.name.substring(0) ?? ''}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.appointment_no}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400,color: Colors.red),
                            ),],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            const Text(
                              'Relation:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              ' ${widget.booking_type.length > 16 ?
                              widget.booking_type.substring(0, 16)+'...' :
                              widget.booking_type.substring(0) ?? ''}',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Age:',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.age}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Sex:',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '  ${widget.gender},',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                       bookAppointments(widget.doctor_id, widget.patient_id, widget.member_id);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      child: dataF?const Center(child: CircularProgressIndicator(),):Text(
                        widget.button,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
