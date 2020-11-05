import 'package:covital/Home.dart';
import 'package:covital/login.dart';
import 'package:covital/registrationFailedPage.dart';
import 'package:covital/signUp.dart';
import 'package:covital/signUp2.dart';
import 'package:covital/test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool check = false;
  getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      check = prefs.getBool('loggedIn');
    });
  }

  @override
  void initState() {
    getLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (check == false)
          ? LoginPage()
          : (check == null) ? LoginPage() : HomePage(),
    );
  }
}
