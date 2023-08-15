import 'package:flutter/material.dart';
import 'package:sabang/view/dashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String FontPoppins = 'FontPoppins';
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: Container(
                height: 100,
                child: Text(
                  "SABANG",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontPoppins,
                    fontSize: 50,
                    color: Color(0xFF78937A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xFF78937A),
                  ),
                  labelText: 'Username',
                  hintText: 'Enter a Username'),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 0, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFF78937A),
                  ),
                  labelText: 'Password',
                  hintText: 'Enter a Password'),
            ),
          ),
          SizedBox(
            height: 75,
          ),
          Container(
            height: 55,
            width: 320,
            decoration: BoxDecoration(
                color: Color(0xFF78937A),
                borderRadius: BorderRadius.circular(25)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF78937A)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
              },
              child: Text("Sign in",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            height: 130,
          )
        ],
      )
    ))
    );
    

  }
}