import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sabang/pages/nira_page.dart';
import 'package:sabang/models/nira.dart';

class AddNira extends StatefulWidget {
  const AddNira({super.key});

  @override
  State<AddNira> createState() => _AddNiraState();
}


class _AddNiraState extends State<AddNira> {
  final String FontPoppins = 'FontPoppins';
  final _formKey = GlobalKey<FormState>();
  final Api api = Api();
  
  int id = 0;
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Input Nira",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              width: 350,
              height: 380,
              margin: EdgeInsets.symmetric(horizontal: 80),
              padding: EdgeInsets.only(top: 5, left: 16, right: 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD8D4D4),
                    offset: const Offset(
                      0,
                      0,
                    ),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            'PH',
                            style: TextStyle(
                              fontFamily: FontPoppins,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildPh(),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            "Kadar Gula",
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildKadarField(),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 16),
                          child: Text("Volume"),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildLiterField(),
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 31),
            height: 44,
            width: 88,
            child: ElevatedButton(
                onPressed: () {
                 if(_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  api.createNira(Nira(id: 0, ph: double.parse(_phController.text), sugarlevel: double.parse(_brixController.text), volume: double.parse(_volumeController.text)));
                  Navigator.pop(context);
                 }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE0ADA2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Text(
                  "Save",
                  style: TextStyle(
                      fontFamily: FontPoppins,
                      fontSize: 14,
                      color: Color(0xFFFFFFFF)),
                )),
          ),
        ],
      ),
    );
  }

}

var _phController = TextEditingController();
var _brixController = TextEditingController();
var _volumeController = TextEditingController();

TextFormField buildPh() {
  return TextFormField(
    controller: _phController,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 14,
    ),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Input Ph',
        hintStyle: TextStyle(color: Color(0xFFA9A9A9)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tolong masukkan Ph';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

TextFormField buildKadarField() {
  return TextFormField(
    controller: _brixController,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Input BRIX',
        hintStyle: TextStyle(
          color: Color(0xFFA9A9A9),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tolong masukkan kadar gula';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

TextFormField buildLiterField() {
  return TextFormField(
    controller: _volumeController,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Masukkan Volume/liter',
        hintStyle: TextStyle(
          color: Color(0xFFA9A9A9),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tolong Masukkan Volume';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

class Api {
  final String api = 'http://192.168.102.137:3001/purchases';
Future<Nira> createNira(Nira nira) async {
  Map data = {
    'ph': nira.ph,
    'sugarlevel': nira.sugarlevel,
    'volume': nira.volume,
  };

  final response = await http.post(Uri.parse(api),
  headers: <String, String> {
    'Content-Type': 'application/json; charset=UTF-8'
  },
  body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    return Nira.fromJson(json.decode(response.body));
  } else {
    print(response);
    throw Exception('Gagal membuat nira'); 
  }
}
}
