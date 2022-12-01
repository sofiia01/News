import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/screens/firstScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Color.fromARGB(255, 200, 225, 223),
  ));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
