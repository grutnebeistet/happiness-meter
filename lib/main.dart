import 'package:flutter/material.dart';
import 'package:happiness_meter/home_page.dart';
import 'meter_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Happiness Meter',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
        home: HomePage()
    );
  }
}