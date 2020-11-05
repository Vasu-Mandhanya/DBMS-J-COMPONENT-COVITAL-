import 'dart:convert';

import 'package:covital/Home.dart';
import 'package:covital/signUp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool loading = false;
  String UserId;

  loginVerify() async {
    String theUrl = "https://covital.000webhostapp.com/LoginFromApp.php";
    var res = await http.post(Uri.encodeFull(theUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "email": email.text.trim(),
      "password": password.text.trim(),
    });

    var responseBody = json.decode(res.body);
    print(responseBody);
    if (responseBody.toString() == '[]') {
      print("Invalid credentials");
      return false;
    } else {
      print("Login success");
      setState(() {
        UserId = responseBody[0]['UserName'];
        print(UserId);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('UserId', UserId);
      prefs.setString('Email', email.text);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                child: Text(
                  '.',
                  style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              )
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      // hintText: 'EMAIL',
                      // hintStyle: ,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                      labelText: 'PASSWORD ',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                SizedBox(height: 50.0),
                (loading == true)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        height: 0.1,
                      ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    if (email.text == "" || password.text == "") {
                      setState(() {
                        loading = false;
                      });
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Empty Field"),
                            content:
                                Text("Check if any of the fields is empty"),
                            actions: [
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      bool loginVerified = await loginVerify();
                      setState(() {
                        loading = false;
                      });
                      if (loginVerified == true) {
                        print("Taking to next page");
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('loggedIn', true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        print("taken back");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Invalid Credentials"),
                              content:
                                  Text("Check your credentials and try again"),
                              actions: [
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 40.0,
                    width: double.infinity,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: InkWell(
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 40.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Center(
                        child: Text('REGISTER',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ]),
    ));
  }
}
