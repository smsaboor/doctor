import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({Key? key,required this.txt}) : super(key: key);
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
