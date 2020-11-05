import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ShowDoctors extends StatefulWidget {
  @override
  _ShowDoctorsState createState() => _ShowDoctorsState();
}

class _ShowDoctorsState extends State<ShowDoctors> {
  List<Material> cards = [];
  getDoctors() async {
    String theUrl = 'https://covital.000webhostapp.com/GetDoctorsApp.php';
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
    var responseBody = json.decode(res.body);
    print(responseBody);
    return responseBody;
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
          child: Column(
            children: [
              FutureBuilder(
                  future: getDoctors(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.length);
                      for (int i = 0; i < snapshot.data.length; i++) {
                        cards.add(
                          Material(
                            elevation: 50,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 25,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.white30,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Dr. ${snapshot.data[i]["First_Name"]} ${snapshot.data[i]["Last_Name"]}',
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
                                            'Specialization: ${snapshot.data[i]["Specialization"]}\nQualification: ${snapshot.data[i]["Qualification"]}', //snapshot.data[index].address
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
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                UrlLauncher.launch(
                                                    "tel://${snapshot.data[i]["Phone"]}");
                                              },
                                              child: Container(
                                                height: size.height * 0.06,
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Column(children: cards);
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
