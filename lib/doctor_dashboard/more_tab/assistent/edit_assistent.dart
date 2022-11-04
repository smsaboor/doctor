import 'dart:convert';
import 'package:doctor/core/constants/apis.dart';
import 'package:doctor/core/custom_form_field.dart';
import 'package:doctor/core/custom_snackbar.dart';
import 'package:doctor/core/avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/core/constants/urls.dart';

class EditAssistent extends StatefulWidget {
  const EditAssistent({Key? key, required this.button, required this.data})
      : super(key: key);
  final button;
  final data;

  @override
  _EditAssistentState createState() => _EditAssistentState();
}

class _EditAssistentState extends State<EditAssistent> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _controllerName =  TextEditingController();
  final TextEditingController _controllerMobile =  TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerName.text = widget.data['assistant_name'];
    _controllerMobile.text = widget.data['number'];
    _controllerAddress.text = widget.data['address'];
    status = widget.data['status_order'];
  }

  bool isAssistantAdded = false;

  String? status = 'Active';
  var statusList = [
    "Active",
    "Left",
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Dr. Bakhshish',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'MBBS',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: AvatarImagePD(
              AppUrls.user,
              radius: 35,
              height: 40,
              width: 40,
            ),
          ),
        ],
        titleSpacing: 0.00,
        title: Image.asset(
          'assets/img_2.png',
          width: 150,
          height: 90,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: Colors.blue,
              title: Text("Edit Assistant ${widget.data['status_order']}"),
            ),
            SizedBox(
              height: 450,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomFormField(
                            controller: _controllerName,
                            errorMsg: 'Enter Assistant Name',
                            labelText: 'Assistant Name',
                            readOnly: false,
                            icon: Icons.person,
                            textInputType: TextInputType.text),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        CustomFormField(
                            controller: _controllerMobile,
                            errorMsg: 'Enter Your Mobile',
                            labelText: 'Mobile',
                            readOnly: false,
                            icon: Icons.phone_android,
                            textInputType: TextInputType.number),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Theme(
                          data: ThemeData(
                            primaryColor: Colors.redAccent,
                            primaryColorDark: Colors.red,
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 18.0, right: 18.0, bottom: 15),
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: myBoxDecoration(),
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            //          <// --- BoxDecoration here
                            child: DropdownButton(
                                // Initial Value
                                menuMaxHeight:
                                    MediaQuery.of(context).size.height,
                                value: status,
                                dropdownColor: Colors.white,
                                focusColor: Colors.blue,
                                isExpanded: true,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // Array list of items
                                items: statusList.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (spec) {
                                  if (mounted) {
                                    setState(() {
                                      status = spec.toString();
                                    });
                                  }
                                }),
                          ),
                        ),
                        CustomFormField(
                            controller: _controllerAddress,
                            errorMsg: 'Enter Full Address',
                            labelText: 'Address',
                            readOnly: false,
                            icon: Icons.person,
                            textInputType: TextInputType.text),
                        const Divider(
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .87,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _add(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              child: isAssistantAdded
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(
                                      widget.button,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<String> updateAssistent(
      {String? id,
      String? AssistName,
      String? number,
      String? address,
      String? status_order}) async {
    var Api =API_BASE_URL+API_DD_ASSISTENT_EDIT;
    Map<String, dynamic> body = {
      'assistant_id': id,
      'assistant_name': AssistName,
      'number': number,
      'address': address,
      'status_order': status_order,
    };
    http.Response response = await http
        .post(Uri.parse(Api), body: body)
        .then((value) => value)
        .catchError(
            (error) => print(error));
    var data = jsonDecode(response.body);
    return data[0]['assistant_name'];
  }

  _add(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isAssistantAdded = true;
      });
      String assistantName = await updateAssistent(
          id: widget.data['assistant_id'],
          address: _controllerAddress.text.toString(),
          status_order: status,
          number: _controllerMobile.text.toString(),
          AssistName: _controllerName.text.toString());
      if (assistantName == _controllerName.text) {
        CustomSnackBar.snackBar(
            context: context,
            data: 'Added Successfully !',
            color: Colors.green);
        setState(() {
          isAssistantAdded = false;
        });
        if (!mounted) return;
        Navigator.pop(context);
      } else {
        CustomSnackBar.snackBar(
            context: context,
            data: 'Failed to Registration !',
            color: Colors.red);
      }
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }
}
