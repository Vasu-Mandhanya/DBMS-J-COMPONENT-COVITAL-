import 'dart:convert';

import 'package:covital/hospitalList.dart';
import 'package:covital/info.dart';
import 'package:covital/logout.dart';
import 'package:covital/info.dart';
import 'package:covital/logout.dart';
import 'package:covital/profile.dart';
import 'package:covital/searchPage.dart';
import 'package:covital/showDoctors.dart';
import 'package:flutter/material.dart';
import 'animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int code = 0;
  int totalCases;
  int recovered;
  int deaths;
  int todayCases;
  int todayRecovered;
  int todayDeaths;

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

  PageController _pageController;
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    getData();

    _pages = [
      {
        'page': SearchPage(),
        'title': 'Home',
      },
      {
        'page': InfoPage(),
        'title': 'Refresh',
      },
      {
        'page': HospitalList(),
        'title': 'Hospital List',
      },
      {
        'page': ShowDoctors(),
        'title': 'Doctors',
      },
      {
        'page': LogOut(),
        'title': 'Profile',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 300),
        buttonBackgroundColor: Colors.blueAccent,
        color: Colors.blueAccent,
        backgroundColor: Colors.white.withOpacity(0),
        height: MediaQuery.of(context).size.height * 0.08,
        items: <Widget>[
          Icon(
            Icons.home,
            size: (_selectedPageIndex == 0) ? 30 : 20,
            color: (_selectedPageIndex == 0) ? Color(0xFFDFBA81) : Colors.white,
          ),
          Icon(
            Icons.info_outline,
            size: (_selectedPageIndex == 1) ? 30 : 20,
            color: (_selectedPageIndex == 1) ? Color(0xFFDFBA81) : Colors.white,
          ),
          Icon(
            Icons.search,
            size: (_selectedPageIndex == 2) ? 30 : 20,
            color: (_selectedPageIndex == 2) ? Color(0xFFDFBA81) : Colors.white,
          ),
          Icon(
            Icons.local_pharmacy,
            size: (_selectedPageIndex == 3) ? 30 : 20,
            color: (_selectedPageIndex == 3) ? Color(0xFFDFBA81) : Colors.white,
          ),
          Icon(
            Icons.account_box,
            size: (_selectedPageIndex == 4) ? 30 : 20,
            color: (_selectedPageIndex == 4) ? Color(0xFFDFBA81) : Colors.white,
          ),
        ],
        onTap: (index) {
          //Handle button tap
          _selectPage(index);
        },
      ),
    );
  }
}
