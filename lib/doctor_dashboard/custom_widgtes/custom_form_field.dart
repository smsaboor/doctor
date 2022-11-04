import 'package:flutter/material.dart';
class CustomFormFieldFlexibleDD extends StatelessWidget {
  const CustomFormFieldFlexibleDD(
      {Key? key,required this.label})
      : super(key: key);
  final label;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
        ),
        child: SizedBox(
          height: 90,
          width: MediaQuery.of(context).size.width*.4,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20.0, color: Colors.red),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.all(8),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              labelText: label,
              disabledBorder: InputBorder.none,
              labelStyle: const TextStyle(fontSize: 14,color: Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}
