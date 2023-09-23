import 'dart:async';

import 'package:flutter/material.dart';


import 'login.dart';

class Splash extends StatefulWidget {
  static String routeName = 'Splash';
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login())));
  }

  final String FontPoppins = 'FontPoppins';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color(0xFFF5F6FB)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/palm.png',
                  height: 400.0,
                  width: 400.0,
                ),
                Text(
                  "SABANG",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontPoppins,
                    color: Color(0xFF78937A),
                    fontWeight: FontWeight.bold,
                    fontSize: 68.0,
                  ),
                )
              ],
            ),
            CircularProgressIndicator(
              color: Colors.grey,
            ),
          ],
        ),
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}
