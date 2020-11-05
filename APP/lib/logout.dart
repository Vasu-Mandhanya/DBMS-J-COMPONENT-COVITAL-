import 'package:covital/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  String email;
  String userid;
  userDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('Email');
      userid = prefs.getString('UserId');
    });
  }

  @override
  void initState() {
    userDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left:16.0,right: 16),
            child: Column(

              children: [

                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'USER PROFILE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,

                      ),
                    )
                  ],
                ),

                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage("assets/svg/profile.jpg"),
                      
                    )
                  ],
                ),

                SizedBox(height: 60,),

                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'UserId:',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width*0.25,),
                    Flexible(
                      child: Text(
                        '$userid',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Email:',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width*0.25,),


                    Flexible(
                      child: Text(
                        '$email',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 40,
                ),
                Material(
                  elevation: 20,
                  child: FlatButton(
                    child: Text('Logout'),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('loggedIn', false);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
