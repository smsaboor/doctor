import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PauseAppointmentCard extends StatefulWidget {
  const PauseAppointmentCard(
      {Key? key,
      required this.button,
      this.appointment_no,
        this.image,
      this.booking_type,
      this.date,
      this.patient_name,
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
      date,
      image,
      patient_name,
      age,
      gender,
      address,
      total_fees,
      received_payment,
      due_payment;

  @override
  _PauseAppointmentCardState createState() => _PauseAppointmentCardState();
}

class _PauseAppointmentCardState extends State<PauseAppointmentCard> {
  bool dataF = false;
  var dataSkipAppointment;

  changeStatus(String appNo) async {
    dataF = true;
    var API = '${API_BASE_URL}reactive_pause_appointment_api.php';
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

  double fontSizeName = 16;
  double fontSizeAddress = 16;
  bool fontTwoLine=false;

  @override
  void initState() {
    super.initState();
    if(widget.patient_name.length>20){
      fontSizeName = 14;
    }else if(widget.patient_name.length>30){
      fontSizeName = 14;
    }
    else if(widget.patient_name.length>40){
      fontSizeName = 12;
    }
    if(widget.address.length>25){
      fontSizeAddress = 14;
      fontTwoLine=true;
    }else if(widget.address.length>100){
      fontSizeAddress = 8;
      fontTwoLine=true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 5, bottom: 5, top: 5),
      child: SizedBox(
        height: 290,
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
                      padding: EdgeInsets.only(left: 15.0),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Appointment:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${widget.appointment_no}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Booking Type:',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                              'Date:',
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
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
                                  '  ${widget.age}',
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
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: fontSizeAddress, fontWeight: FontWeight.w400),
                            ),
                            fontTwoLine?Text(
                              '  ${widget.address.substring(26, widget.address.length)}',
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: fontSizeAddress, fontWeight: FontWeight.w400),
                            ):Container(),
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
                        changeStatus(widget.appointment_no);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      child: dataF
                          ? const Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            )
                          : Text(
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