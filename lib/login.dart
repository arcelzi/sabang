import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sabang/view/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:sabang/widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color(0xFFF5F6FB),
            body: SingleChildScrollView(
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
                    validator: (String? arg) {
                      if (arg == null || arg.isEmpty) {
                        return 'Please input username';
                      } else {
                        return null;
                      }
                    },
                    controller: usernameController,
                    onSaved: (String? val) {
                      usernameController.text = val!;
                    },
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
                    validator: (String? arg) {
                      if (arg == null || arg.isEmpty) {
                        return 'Please Input Password';
                      } else {
                        return null;
                      }
                    },
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
                     _validateInputs();
                    
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
            )));
  }
  void _validateInputs() {
  if (_formKey.currentState!.validate());
  _formKey.currentState!.save();
  doLogin(usernameController.text, passwordController.text);
}
  doLogin(username, password) async {
    final GlobalKey<State> _keyLoader = GlobalKey<State>();
    Dialogs.loading(context, _keyLoader, "Proses...");
    
    
   try {
      final response = await http.post(Uri.parse('http://192.168.102.137:3001/auth/login'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        "username": username,
        "password": password,
      }));
      
      final output = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(),));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${username} is Logged In', style: TextStyle(fontSize: 16),))
        );

  
      } else {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(output.toString(), style: TextStyle(fontSize: 16),))
        );
      }
    } catch (e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
      Dialogs.popUp(context, '$e');
    }
  }
  saveSessions(String username) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("username", username);
      await pref.setBool("is_login", true);

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => Dashboard())), (route) => false);  
    }
  
}