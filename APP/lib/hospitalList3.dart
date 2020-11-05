import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covital/hospitalList.dart';
import 'package:covital/Home.dart';
import 'package:covital/info.dart';
import 'package:covital/logout.dart';
import 'package:covital/profile.dart';
import 'package:covital/searchPage.dart';
import 'package:flutter/material.dart';

import 'elements.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// ignore: must_be_immutable
class HospitaList3 extends StatefulWidget {
  String DistrictCode;

  HospitaList3({this.DistrictCode});

  @override
  _HospitaList3State createState() => _HospitaList3State(
        DistrictCode,
      );
}

class _HospitaList3State extends State<HospitaList3> {
  String DistrictCode;
  _HospitaList3State(
    this.DistrictCode,
  );

  List<Material> cards = [];

  getHospitals() async {
    String theUrl = "https://covital.000webhostapp.com/GetHospitalListApp.php";
    var res = await http.post(Uri.encodeFull(theUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "DistrictCode": DistrictCode,
    });

    var responseBody = json.decode(res.body);

    print(responseBody);
    return responseBody;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                FutureBuilder(
                    future: getHospitals(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data.length);
                        if (snapshot.data.length == 0) {
                          return Center(
                              child: Text(
                            'No hospitals found',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ));
                        } else {
                          for (int i = 0; i < snapshot.data.length; i++) {
                            cards.add(
                              Material(
                                elevation: 10,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 25,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 200,
                                          child: Image.network(
                                            '${snapshot.data[i]["image"]}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                '${snapshot.data[i]["name"]}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${snapshot.data[i]["address"]}', //snapshot.data[index].address
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            CardButtons(
                                                size: size,
                                                tag: 'Normal Beds',
                                                value: int.parse(snapshot.data[i][
                                                    "normal"]) //snapshot.data[index].availableBeds
                                                ),
                                            CardButtons(
                                                size: size,
                                                tag: 'ICU',
                                                value: int.parse(snapshot.data[i][
                                                    "icu"]) //snapshot.data[index].availableBeds
                                                ),
                                            CardButtons(
                                                size: size,
                                                tag: 'Ventilators',
                                                value: int.parse(snapshot.data[i][
                                                    "ventilators"]) //snapshot.data[index].availableBeds
                                                ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  UrlLauncher.launch(
                                                      "tel://${snapshot.data[i]["phone"]}");
                                                },
                                                child: Container(
                                                  height: size.height * 0.1,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      border: Border(
                                                          right: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.5,
                                                      ))),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8,
                                                        horizontal: 2),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.call,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          return Column(children: cards);
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Container(
                      height: 40.0,
                      width: size.width * 0.4,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'BACK TO HOME',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
