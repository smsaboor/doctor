import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown(
      {Key? key,
      required this.boxDecoration,
      required this.dropdownValue,
      required this.list,
      required this.setStateValue,
      final this.onClicked
      })
      : super(key: key);
  final boxDecoration;
  final dropdownValue;
  final list;
  String? setStateValue;
  final Function? onClicked;

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Theme(
        data: new ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
        ),
        child: Container(
          margin: const EdgeInsets.all(1.0),
          padding: const EdgeInsets.only(left: 5.0),
          decoration: widget.boxDecoration,
          height: 60,
          //
          width: MediaQuery.of(context).size.width,
          //          <// --- BoxDecoration here
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DropdownButton(
                // Initial Value
                menuMaxHeight: MediaQuery.of(context).size.height,
                value: widget.dropdownValue,
                dropdownColor: Colors.white,
                focusColor: Colors.blue,
                isExpanded: true,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: widget.list.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: widget.onClicked!())
          ),
        ),
      ),
    );
  }
}
