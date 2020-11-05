import 'package:flutter/material.dart';

import 'custompaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

import 'elements.dart';

class DosAndDonts extends StatefulWidget {
  @override
  _DosAndDontsState createState() => _DosAndDontsState();
}

class _DosAndDontsState extends State<DosAndDonts> {
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
          body: Container(
            color: Color(0xFF21298B),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SvgPicture.asset("assets/svg/dos.svg"),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35.0),
                        topLeft: Radius.circular(35.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 38),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Do's and don'ts",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.04,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'i.Physical distancing of at least 6 feet to be followed as far as feasible.\n\nii.Use of face covers/masks to be made mandatory.\n\niii.Practice frequent hand washing with soap (for at least 40-60 seconds) even when hands are not visibly dirty.i.Physical distancing of at least 6 feet to be followed as far as feasible.\n\nii.Use of face covers/masks to be made mandatory.\n\niii.Practice frequent hand washing with soap (for at least 40-60 seconds) even when hands are not visibly dirty.i.Physical distancing of at least 6 feet to be followed as far as feasible.\n\nii.Use of face covers/masks to be made mandatory.\n\niii.Practice frequent hand washing with soap (for at least 40-60 seconds) even when hands are not visibly dirty.i.Physical distancing of at least 6 feet to be followed as far as feasible.\n\nii.Use of face covers/masks to be made mandatory.\n\niii.Practice frequent hand washing with soap (for at least 40-60 seconds) even when hands are not visibly dirty.i.Physical distancing of at least 6 feet to be followed as far as feasible.\n\nii.Use of face covers/masks to be made mandatory.\n\niii.Practice frequent hand washing with soap (for at least 40-60 seconds) even when hands are not visibly dirty. ',
                                  style: TextStyle(
                                    color: Color(0xFFB79191),
                                    fontFamily: 'Roboto',
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
