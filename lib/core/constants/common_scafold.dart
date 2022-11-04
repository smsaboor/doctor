import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({Key? key,required this.txt}) : super(key: key);
// ignore: prefer_typing_uninitialized_variables
final txt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(txt,),
      centerTitle: true,),
      body: Container(),
    );
  }
}
