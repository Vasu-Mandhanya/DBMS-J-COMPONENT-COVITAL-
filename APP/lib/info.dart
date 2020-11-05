import 'package:flutter/material.dart';
import 'detailedGuidelines.dart';
import 'dos_and_donts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

import 'elements.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: "Covital",
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF21298B),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Coronavirus \nknowledge',
                    style: TextStyle(
                      fontFamily: 'Martel',
                      fontSize: size.height * 0.029,
                      color: Colors.white,
                      letterSpacing: 8,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                SvgPicture.asset("assets/svg/infoPage.svg"),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35.0),
                      topLeft: Radius.circular(35.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailedGuidelines()),
                              );
                            },
                            child: InfoPageTabs(
                              size: size,
                              title: 'Detailed Guidelines',
                              tag:
                                  'i.Physical distancing of at least 6 feet....',
                              icon: 'sanitizer2',
                            )),
                        SizedBox(height: size.height * 0.1),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DosAndDonts()),
                              );
                            },
                            child: InfoPageTabs(
                              size: size,
                              title: "Do's and don'ts",
                              tag:
                                  'Use of face covers/masks to be...',
                              icon: 'sanitizer2',
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
