import 'dart:convert';

import 'package:covital/hospitalList3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HospitalList2 extends StatefulWidget {
  String state;

  HospitalList2({this.state});
  @override
  _HospitalList2State createState() => _HospitalList2State(
        state,
      );
}

class _HospitalList2State extends State<HospitalList2> {
  String state;
  _HospitalList2State(
    this.state,
  );

  Map<String, String> name_code = {};
  String _currentItemSelected = "Select";
  String _currentSelectedDistrictCode = "Null";
  String districtCode = "Null";
  bool loading = false;

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

  @override
  void initState() {
    insertMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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

    List<String> districts = ["Select"];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 30),
                child: (Column(
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
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HospitaList3(
                                                    DistrictCode: districtCode,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                          height: 40.0,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            shadowColor: Colors.greenAccent,
                                            color: Colors.green,
                                            elevation: 7.0,
                                            child: Center(
                                              child: Text(
                                                'Search',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat'),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        )),
                  ],
                )),
              )
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
