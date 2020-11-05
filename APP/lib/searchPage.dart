import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'package:covital/custompaint.dart';
import 'package:covital/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'elements.dart';
import 'package:add_comma/add_comma.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int code = 0;
  int code2 = 0;
  int totalCases;
  int recovered;
  int deaths;
  int todayCases;
  int todayRecovered;
  int todayDeaths;
  int DistrictActive;
  int DistrictRecovered;
  int DistrictDeaths;
  int DistrictTotal;
  String DistrictName = "District";

  Future<void> getData() async {
    var res = await http.get(
        'https://disease.sh/v3/covid-19/countries/india?yesterday=true&twoDaysAgo=false&strict=true');
    if (res.statusCode == 200) {
      setState(() {
        code = 200;
      });
      String data = res.body;
      setState(() {
        totalCases = jsonDecode(data)['cases'];
        recovered = jsonDecode(data)['recovered'];
        deaths = jsonDecode(data)['deaths'];
        todayCases = jsonDecode(data)['todayCases'];
        todayRecovered = jsonDecode(data)['todayRecovered'];
        todayDeaths = jsonDecode(data)['todayDeaths'];
      });
    }
  }

  getDistrictData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String UserId = prefs.getString('UserId');
    String theUrl = "https://covital.000webhostapp.com/GetDistrictCases.php";
    var res = await http.post(Uri.encodeFull(theUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "UserId": UserId,
    });

    var responseBody = json.decode(res.body);

    print(responseBody);
    setState(() {
      DistrictActive = int.parse(responseBody[0]['Active']);
      DistrictRecovered = int.parse(responseBody[0]['Recovered']);
      DistrictDeaths = int.parse(responseBody[0]['Deaths']);
      DistrictTotal = DistrictActive + DistrictRecovered + DistrictDeaths;
      code2 = 200;
    });
    return responseBody;
  }

  getDistrictName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String UserId = prefs.getString('UserId');
    String theUrl = "https://covital.000webhostapp.com/GetDistrictName.php";
    var res = await http.post(Uri.encodeFull(theUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "UserId": UserId,
    });

    var responseBody = json.decode(res.body);

    print(responseBody);
    setState(() {
      DistrictName = responseBody[0]['District'];
    });
    print(DistrictName);
    return responseBody;
  }

  final putComma = addCommas();

  @override
  void initState() {
    getDistrictName();
    getData();
    getDistrictData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    const spinkit = SpinKitWave(
      color: Colors.greenAccent,
      size: 50.0,
      duration: const Duration(milliseconds: 500),
    );

    /*final spinkit = SpinKitWave(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );*/

    return MaterialApp(
      title: "Covital",
      home: SafeArea(
        child: Scaffold(
          body: Container(
            color: Color(0xFFEFF6FF),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF6B4DF8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/boy.svg",
                                allowDrawingOutsideViewBox: true,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Lets Fight',
                                    style: TextStyle(
                                      fontFamily: 'Martel',
                                      fontSize: size.height * 0.029,
                                      color: Colors.white,
                                      letterSpacing: 4,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              '\nWe stand with \nour warriors',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontSize: size.height * 0.021)),
                                    ]),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Your location',
                                style: TextStyle(
                                  fontSize: size.height * 0.0315,
                                  color: Colors.white,
                                  letterSpacing: 7,
                                  fontFamily: 'Quattro',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.018,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 0.8,
                                height: size.height * 0.041,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/svg/pin.svg"),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      (DistrictName != 'District')
                                          ? Text(
                                              '$DistrictName',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 2,
                                              ),
                                            )
                                          : Text(
                                              'Loading...',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 2,
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.0255,
                  ),
                  SizedBox(
                    height: size.height * 0.035,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: (code == 200)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Country stats',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LiveDataContainer(
                                    size: size,
                                    value: '${putComma(totalCases)}',
                                    tag: 'Positive',
                                    iconName: 'virus',
                                    valueColor: Color(0xFF6247E2),
                                    tagColor: Color(0xFF696969),
                                  ),
                                  LiveDataContainer(
                                    size: size,
                                    value: '${putComma(recovered)}',
                                    tag: 'Recovered',
                                    iconName: 'recovered',
                                    valueColor: Color(0xFF3DCF7B),
                                    tagColor: Color(0xFF979797),
                                  ),
                                  LiveDataContainer(
                                    size: size,
                                    value: '${putComma(deaths)}',
                                    tag: 'Deaths',
                                    iconName: 'deaths',
                                    valueColor: Color(0xFFF41605),
                                    tagColor: Color(0xFF5F5F5F),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Center(
                            child: spinkit,
                          ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: (code2 == 200)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  '$DistrictName stats',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LiveDataContainer(
                                    size: size,
                                    value: '${putComma(DistrictTotal)}',
                                    tag: 'Positive',
                                    iconName: 'virus',
                                    valueColor: Color(0xFF6247E2),
                                    tagColor: Color(0xFF696969),
                                  ),
                                  LiveDataContainer(
                                    size: size,
                                    value: '${putComma(DistrictRecovered)}',
                                    tag: 'Recovered',
                                    iconName: 'recovered',
                                    valueColor: Color(0xFF3DCF7B),
                                    tagColor: Color(0xFF979797),
                                  ),
                                  LiveDataContainer(
                                    size: size,
                                    value: '${putComma(DistrictDeaths)}',
                                    tag: 'Deaths',
                                    iconName: 'deaths',
                                    valueColor: Color(0xFFF41605),
                                    tagColor: Color(0xFF5F5F5F),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Center(
                            child: spinkit,
                          ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.230,
                      color: Color(0xFFDFBA81),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/svg/doctor.svg"),
                                Spacer(),
                                RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                      text: 'Find Hospitals',
                                      style: TextStyle(
                                        fontFamily: 'Martel',
                                        fontSize: size.height * 0.029,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        letterSpacing: 2,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '\nUse hospital finder \nto check hospital \navailability',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Roboto',
                                                fontSize: size.height * 0.021,
                                                fontWeight: FontWeight.w300)),
                                      ]),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
