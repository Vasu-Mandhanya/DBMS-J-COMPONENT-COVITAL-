import 'dart:convert';

import 'package:covital/Home.dart';
import 'package:covital/login.dart';
import 'package:covital/registrationFailedPage.dart';
import 'package:covital/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUp2 extends StatefulWidget {
  String email;
  String password;
  String state;
  String username;

  SignUp2({this.email, this.password, this.state, this.username});

  @override
  _SignUp2State createState() => _SignUp2State(
        username,
        email,
        password,
        state,
      );
}

class _SignUp2State extends State<SignUp2> {
  String username;
  String email;
  String password;
  String state;

  _SignUp2State(
    this.username,
    this.email,
    this.password,
    this.state,
  );

  String _currentItemSelected = "Select";
  String _currentSelectedDistrictCode = "Null";
  String districtCode = "Null";
  bool loading = false;
  int maxLocId;

  TextEditingController pincode = new TextEditingController();
  TextEditingController address = new TextEditingController();
  Map<String, String> name_code = {};
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //Change this url to get list of districts in the selected state at time of registeration
    /*getMethod() async {
      String theUrl = 'https://covital.000webhostapp.com/getDistrict.php';
      var res = await http
          .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
      var responseBody = json.decode(res.body);
      print(responseBody);
      return responseBody;
    }*/

    userExistenceVerify() async {
      String theUrl =
          "https://covital.000webhostapp.com/userExistenceVerify.php";
      var res = await http.post(Uri.encodeFull(theUrl), headers: {
        "Accept": "application/json"
      }, body: {
        "Email": email,
        "UserId": username,
      });

      var responseBody = json.decode(res.body);
      print(responseBody);
      if (responseBody.toString() == '[]') {
        print("User doesn't exist");
        return false;
      } else {
        print("User exists");
        return true;
      }
    }

    insertMethod() async {
      String theUrl =
          "https://covital.000webhostapp.com/getStateCodeFromName.php";
      var res = await http.post(Uri.encodeFull(theUrl), headers: {
        "Accept": "application/json"
      }, body: {
        "Name": state,
      });

      var responseBody = json.decode(res.body);

      return responseBody;
    }

    sendRegistrationDataToServer() async {
      String theUrl = "https://covital.000webhostapp.com/RegisterFromApp2.php";
      var res = await http.post(Uri.encodeFull(theUrl), headers: {
        "Accept": "application/json"
      }, body: {
        "username": username,
        "email": email,
        "password": password,
      });

      var responseBody = json.decode(res.body);
      print(responseBody);
      return responseBody;
    }

    sendRegistrationData2ToServer(String district_code) async {
      String theUrl = "https://covital.000webhostapp.com/RegisterFromApp3.php";
      var res = await http.post(Uri.encodeFull(theUrl), headers: {
        "Accept": "application/json"
      }, body: {
        "pincode": pincode.text.trim(),
        "address": address.text.trim(),
        "districtCode": district_code.toString(),
      });

      var responseBody = json.decode(res.body);
      print(responseBody);
      return responseBody;
    }

    maxLocationId() async {
      String theUrl = 'https://covital.000webhostapp.com/GetMaxLocationId.php';
      var res = await http
          .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
      var responseBody = json.decode(res.body);
      print(responseBody[0]['id'].toString());
      setState(() {
        maxLocId = int.parse(responseBody[0]['id']);
      });

      return responseBody;
    }

    sendRegistrationData3ToServer() async {
      String theUrl =
          "https://covital.000webhostapp.com/InsertIntoUserLocation.php";
      var res = await http.post(Uri.encodeFull(theUrl), headers: {
        "Accept": "application/json"
      }, body: {
        "Id": username,
        "LocationId": maxLocId.toString(),
      });

      var responseBody = json.decode(res.body);
      print(responseBody);
      return responseBody;
    }

    List<String> districts = ["Select"];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 30),
                child: Column(
                  children: [
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 2,
                        ),
                        child: FutureBuilder(
                          future: insertMethod(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            List snap = snapshot.data;

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              print(snapshot.error);
                              return Center(
                                child: Text("${snapshot.error}"),
                              );
                            } else {
                              for (int i = 0; i < snap.length; i++) {
                                districts.add(snap[i][
                                    'Dist_Name']); //here 'Dist_Name' is key of json data from the website
                                name_code[snap[i]['Dist_Name']] =
                                    snap[i]['Dist_Code'];
                              }

                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Select your district',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    DropdownButton<String>(
                                      items: districts
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (String newValueSelected) {
                                        _onDropDownSelection(newValueSelected);
                                      },
                                      value: _currentItemSelected,
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        )),
                    TextField(
                      controller: pincode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Pincode',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    TextField(
                      controller: address,
                      decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    (loading == true)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: 1,
                          ),
                    Container(
                      height: 40.0,
                      width: 160,
                      child: GestureDetector(
                        onTap: () async {
                          if (pincode.text.length == 6 &&
                              address.text != '' &&
                              _currentItemSelected != 'Select') {
                            setState(() {
                              loading = true;
                            });
                            bool userExists = await userExistenceVerify();

                            // ignore: unrelated_type_equality_checks
                            if (userExists == false) {
                              print("We move to next page");
                              print("Selected district code is: $districtCode");

                              await sendRegistrationDataToServer();

                              await sendRegistrationData2ToServer(districtCode);

                              await maxLocationId();

                              await sendRegistrationData3ToServer();

                              setState(() {
                                loading = false;
                              });

                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Successfully Registered"),
                                    content: Text("Please click on login"),
                                    actions: [
                                      FlatButton(
                                        child: Text("Login"),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                          );
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              print("We move back");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterFail()),
                              );
                            }
                          } else {
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Invalid input"),
                                  content:
                                      Text("Please check your input again"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: Center(
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDropDownSelection(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
      this._currentSelectedDistrictCode = name_code[_currentItemSelected];
      districtCode = this._currentSelectedDistrictCode;
      print(districtCode);
    });
  }
}
