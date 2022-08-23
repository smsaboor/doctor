import 'package:flutter/material.dart';
class CustomFormFieldFlexibleDD extends StatelessWidget {
  const CustomFormFieldFlexibleDD(
      {Key? key,required this.label})
      : super(key: key);
  // final TextEditingController controlller;
  // final errorMsg;
  // final labelText;
  // final icon;
  // final textInputType;
  // final readOnly;
  final label;

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: Theme(
        data: new ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
        ),
        child: SizedBox(
          height: 90,
          width: MediaQuery.of(context).size.width*.4,
          child: new TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.red),
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.all(8),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              labelText: label,
              disabledBorder: InputBorder.none,
              labelStyle: TextStyle(fontSize: 14,color: Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}
