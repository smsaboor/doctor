import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List? _myActivities;
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = ['1'];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MultiSelect Formfield Example'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: AutovalidateMode.disabled,
                  chipBackGroundColor: Colors.blue,
                  chipLabelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blue,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: const Text(
                    "Languages you speak",
                    style: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },
                  dataSource: const [
                    {
                      "language": "Running",
                      "index": "1",
                    },
                    {
                      "language": "Climbing",
                      "index": "2",
                    },
                    {
                      "language": "Walking",
                      "index": "3",
                    },
                    {
                      "language": "Swimming",
                      "index": "4",
                    },
                    {
                      "language": "Soccer Practice",
                      "index": "5",
                    },
                    {
                      "language": "Baseball Practice",
                      "index": "6",
                    },
                    {
                      "language": "Football Practice",
                      "index": "7",
                    },
                  ],
                  textField: 'language',
                  valueField: 'index',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: const Text('Please select language'),
                  initialValue: const [],
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Save'),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              )
            ],
          ),
        ),
      ),
    );
  }
}