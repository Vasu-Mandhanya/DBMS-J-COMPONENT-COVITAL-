import 'dart:convert';

import 'package:covital/hospitalList2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'elements.dart';

class HospitalList extends StatefulWidget {
  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  String _currentItemSelected = "Andhra Pradesh";
  String _currentDistrictSelected = "Select";

  insertMethod() async {
    String theUrl =
        "https://covital.000webhostapp.com/getStateCodeFromName.php";
    var res = await http.post(Uri.encodeFull(theUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "Name": _currentItemSelected,
    });

    var responseBody = json.decode(res.body);

    return responseBody;
  }

  /*Future<List<HospitalCard>> getHospitals() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/clRrKZnoya?indent=2");
    var jsonData = json.decode(data.body);

    List<HospitalCard> hospitalCard = [];

    for (var u in jsonData) {
      HospitalCard card = HospitalCard(
          u["imgUrl"],
          u["name"],
          u["address"],
          u["otherServices"],
          u["availableBeds"],
          u["pricePerBed"],
          u["contactNumber"]);

      hospitalCard.add(card);
    }

    return hospitalCard;
  }
  */

  Map<String, String> name_code = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var _states = [
      "Andhra Pradesh",
      "Arunachal Pradesh ",
      "Assam",
      "Bihar",
      "Chhattisgarh",
      "Goa",
      "Gujarat",
      "Haryana",
      "Himachal Pradesh",
      "Jammu and Kashmir",
      "Jharkhand",
      "Karnataka",
      "Kerala",
      "Madhya Pradesh",
      "Maharashtra",
      "Manipur",
      "Meghalaya",
      "Mizoram",
      "Nagaland",
      "Odisha",
      "Punjab",
      "Rajasthan",
      "Sikkim",
      "Tamil Nadu",
      "Telangana",
      "Tripura",
      "Uttar Pradesh",
      "Uttarakhand",
      "West Bengal",
      "Andaman and Nicobar Islands",
      "Chandigarh",
      "Dadra and Nagar Haveli",
      "Daman and Diu",
      "Lakshadweep",
      "National Capital Territory of Delhi",
      "Puducherry"
    ];

    List<String> districts = ["Select", "Unknown"];

    return MaterialApp(
      title: "CoVital",
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Search hospital',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'State: ',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
                        items: _states.map((String dropDownStringItem) {
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
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HospitalList2(
                                  state: _currentItemSelected,
                                )),
                      );
                    },
                    child: Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: Center(
                            child: Text(
                              'NEXT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        )),
                  ),
                  /* FutureBuilder(
                    future: insertMethod(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        for (int i = 0; i < snapshot.data.length; i++) {
                          districts.add(snapshot.data[i][
                              'Dist_Name']); //here 'Dist_Name' is key of json data from the website
                          name_code[snapshot.data[i]['Dist_Name']] =
                              snapshot.data[i]['Dist_Code'];
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
                                items:
                                    districts.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  _onDropDownSelection2(newValueSelected);
                                },
                                value: _currentDistrictSelected,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )*/

                  /* FutureBuilder(
                    initialData: [],
                    future: getHospitals(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.hasData) {
                              return Hospitals(
                                size: size,
                                name: snapshot.data[index].name,
                                address: snapshot.data[index].address,
                                otherServices: snapshot.data[index].otherServices,
                                availableBeds: snapshot.data[index].availableBeds,
                                pricePerBed: snapshot.data[index].pricePerBed,
                                contactNumber: snapshot.data[index].contactNumber,
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          });
                    },
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDropDownSelection(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}

class HospitalCard {
  String imgUrl;
  String name;
  String address;
  String otherServices;
  int availableBeds;
  int pricePerBed;
  int contactNumber;

  HospitalCard(
      {this.imgUrl,
      this.name,
      this.address,
      this.availableBeds,
      this.contactNumber});
}
