import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sabang/view/dashboard.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sabang/services/http.dart' as http_service;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String FontPoppins = 'FontPoppins';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if (val != null) {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Dashboard()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6FB),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Padding(
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
              ),
              Padding(
                //padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: usernameController,
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
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  onSaved: (String? val) {
                    passwordController.text = val!;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF78937A),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter a Password'),
                      validator: (value) {
                            if (value!.isEmpty) return 'Password tidak boleh kosong';
                            return null;
                          },
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF78937A)),
                  onPressed: () {
                    login();
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
          )),
        ));
  }

  void login() async {
    if (passwordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      var response = await http_service
          .post("http://192.168.102.10:3001/auth/login", body: {
        "username": usernameController.text,
        "password": passwordController.text,
      });
      // await http.post(Uri.parse("http://192.168.102.10:3001/auth/login"),
      //     body: ({
      //       "username": usernameController.text,
      //       "password": passwordController.text,
      //     }));
      if (response.isSuccess) {
        final body = jsonDecode(response.data);
        // print("Login Token"+ body["token"]);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Berhasil Login")));

        gotoDashboard(body['token']);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Username/password salah")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Masukkan username/password")));
    }
  }

  void gotoDashboard(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
  }
}
