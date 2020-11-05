import 'dart:convert';

import 'package:covital/test_json_format.dart';
import 'package:flutter/material.dart';
import 'package:blur_bottom_bar/blur_bottom_bar.dart';
import 'package:http/http.dart' as http;

int _selectedIndex = 0;

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  TextEditingController newName = new TextEditingController();
  TextEditingController newCity = new TextEditingController();
  TextEditingController newContact = new TextEditingController();
  TextEditingController newId = new TextEditingController();

  _insertMethod() async {
    String theUrl = "https://covital.000webhostapp.com/insertData.php";
    var res = await http.post(Uri.encodeFull(theUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "Id": newId.text,
      "Name": newName.text,
      "City": newCity.text,
      "Contact": newContact.text,
    });

    var resBody = json.decode(res.body);
    print(resBody);
  }

  getMethod() async {
    String theUrl = 'https://covital.000webhostapp.com/getData.php';
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
    var responseBody = json.decode(res.body);
    print(responseBody);
    return responseBody;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 30),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 2,
                      maxHeight: size.height * 0.4,
                    ),
                    child: FutureBuilder(
                      future: getMethod(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        List snap = snapshot.data;

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Center(
                            child: Text("Error fetching data"),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 2,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('ID: ${snap[index]['id']}'),
                                          Spacer(),
                                          Text('Name: ${snap[index]['Name']}'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text('City: ${snap[index]['City']}'),
                                          Spacer(),
                                          Text(
                                              'Contact: ${snap[index]['Contact']}'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                    )),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      controller: newName,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter your id',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      controller: newId,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter your city',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      controller: newCity,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter your contact',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      controller: newContact,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Center(
                    child: FlatButton(
                      child: Text('SUBMIT'),
                      onPressed: _insertMethod,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*

Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          controller: newName,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            hintText: 'Enter your id',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          controller: newId,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            hintText: 'Enter your city',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          controller: newCity,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            hintText: 'Enter your contact',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          controller: newContact,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                        child: FlatButton(
                          child: Text('SUBMIT'),
                          onPressed: sendData,
                        ),
                      )
                    ],
                  )





ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.hasData) {
                          TestTable t = snapshot.data[index];

                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 2,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('ID: ${t.id}'),
                                    Spacer(),
                                    Text('Name: ${t.name}'),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text('City: ${t.city}'),
                                    Spacer(),
                                    Text('Contact: ${t.contact}'),
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      });

                */
