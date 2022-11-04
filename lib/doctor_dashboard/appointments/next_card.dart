import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/avatar_image.dart';
import 'package:doctor/doctor_dashboard/appointments/save_consult/save_consult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
class NextAppointmentCard extends StatefulWidget {
  const NextAppointmentCard(
      {Key? key,
      required this.button,
      this.appointment_no,
      this.booking_type,
      this.image,
      this.date,
      this.patient_name,
      this.patient_id,
      this.age,
      this.gender,
      this.address,
      this.total_fees,
      this.received_payment,
      this.due_payment})
      : super(key: key);
  final button;
  final appointment_no,
      booking_type,
      image,
      date,
      patient_name,
      patient_id,
      age,
      gender,
      address,
      total_fees,
      received_payment,
      due_payment;

  @override
  _NextAppointmentCardState createState() => _NextAppointmentCardState();
}

class _NextAppointmentCardState extends State<NextAppointmentCard> {
  int? _value;
  bool dataF = false;
  double fontSizeName = 16;
  double fontSizeAddress = 16;
  bool fontTwoLine = false;
  var dataSkipAppointment;
  int? addressMaxlength;

  @override
  void initState() {
    addressMaxlength = widget.address.length;
    super.initState();
    if (widget.patient_name.length > 20) {
      fontSizeName = 12;
    } else if (widget.patient_name.length > 25) {
      fontSizeName = 10;
    }
    if (widget.address.length > 25) {
      fontSizeAddress = 14;
      fontTwoLine = true;
      addressMaxlength = 25;
    } else if (widget.address.length > 100) {
      fontSizeAddress = 8;
      fontTwoLine = true;
      addressMaxlength = 25;
    }
  }

  changeStatus(int changedValue, String appNo) async {
    if (changedValue == 1) {
      dataF = true;
      var API = '${API_BASE_URL}skip_appointment_api.php';
      Map<String, dynamic> body = {'appointment_no': appNo};
      http.Response response = await http
          .post(Uri.parse(API), body: body)
          .then((value) => value)
          .catchError((error) => print(error));
      if (response.statusCode == 200) {
        setState(() {
          dataF = false;
        });
        dataSkipAppointment = jsonDecode(response.body.toString());
      } else {}
    } else if (changedValue == 2) {
      dataF = true;
      var API = '${API_BASE_URL}reject_appointment_api.php';
      Map<String, dynamic> body = {'appointment_no': appNo};
      http.Response response = await http
          .post(Uri.parse(API), body: body)
          .then((value) => value)
          .catchError((error) => print(error));
      if (response.statusCode == 200) {
        setState(() {
          dataF = false;
        });
        dataSkipAppointment = jsonDecode(response.body.toString());
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 5, bottom: 5, top: 5),
      child: SizedBox(
        height: 300,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: AvatarImagePD(
                        widget.image,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .6,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Appointment No:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '  ${widget.appointment_no}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const Spacer(),
                              PopupMenuButton<int>(
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuItem<int>>[
                                        const PopupMenuItem<int>(
                                            value: 1, child: Text('Skip')),
                                        const PopupMenuItem<int>(
                                            value: 2,
                                            child: Text('Reject')),
                                      ],
                                  onSelected: (int value) {
                                    setState(() {
                                      _value = value;
                                      changeStatus(
                                          value, widget.appointment_no);
                                    });
                                  })
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Booking Type:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.booking_type}',
                              style: TextStyle(
                                  color: widget.booking_type == 'online'
                                      ? Colors.green
                                      : Colors.red,
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
                              'Name:',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              ' ${widget.patient_name[0].toUpperCase()}${widget.patient_name.length > 16 ?
                              widget.patient_name.substring(0, 16)+'...' :
                              widget.patient_name.substring(1) ?? ''}',
                              style: TextStyle(
                                  fontSize: fontSizeName,
                                  fontWeight: FontWeight.w500),
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
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Age:',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' ${widget.age}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Address:',
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              ' ${widget.address.length > 16 ?
                              widget.address.substring(0, 16)+'...' :
                              widget.address.substring(0) ?? ''}',
                              style: TextStyle(
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                  fontSize: fontSizeAddress,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        fontTwoLine
                            ? Text(
                                '${widget.address.toLowerCase().substring(26, widget.address.length)}',
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: fontSizeAddress,
                                    fontWeight: FontWeight.w400),
                              )
                            : Container(),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Date:',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.date}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(
                  color: Colors.black12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Total Fees: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        Text(
                          widget.total_fees,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Received: ',
                          style: TextStyle(

                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        Text(
                          widget.received_payment,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Due: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        Text(
                          widget.due_payment,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SaveConsultDD(
                                  appointmentNumber: widget.appointment_no,
                                  patientName: widget.patient_name,
                                  patientId: widget.patient_id,
                                )));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      child: Text(
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