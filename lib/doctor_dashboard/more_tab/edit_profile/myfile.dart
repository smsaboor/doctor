import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ImageExample extends StatelessWidget {
  const ImageExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Image Upload'),),
        body: Center(
          child: Container(
            child: TextButton(onPressed: (){
              uploadImage('image', File('assets/img.png'));
            },child: Text('Upload'),),
          ),
        ),
      ),
    );
  }
}

uploadImage(String title, File file) async{
  var request = http.MultipartRequest("POST",Uri.parse("https://api.imgur.com/3/image"));
  request.fields['title'] = "dummyImage";
  request.headers['Authorization'] = "Client-ID " +"f7........";
  var picture = http.MultipartFile.fromBytes('image', (await rootBundle.load('assets/testimage.png')).buffer.asUint8List(),
      filename: 'testimage.png');
  request.files.add(picture);
  var response = await request.send();

  var responseData = await response.stream.toBytes();

  var result = String.fromCharCodes(responseData);

  print(result);
}
