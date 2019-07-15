import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/MainMenu.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(new MaterialApp(
    home: new MainMenu(),
    debugShowCheckedModeBanner: false,
  ));
}
