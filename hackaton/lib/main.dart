import 'package:flutter/material.dart';
import 'package:hackaton/forum.dart';
import 'package:hackaton/forum2.dart';
import 'package:hackaton/home_page.dart';
import 'package:hackaton/map_page.dart';
import 'package:hackaton/map_routepage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomePage(),
    );
  }
}