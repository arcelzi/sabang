import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Garden extends StatefulWidget {
  const Garden({super.key});

  @override
  State<Garden> createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  final String FontPoppins = 'FontPoppins';
  final _formKey = GlobalKey<FormState>();
  @override
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
          "Garden Control",
          style: TextStyle(
              fontFamily: FontPoppins,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              height: 617,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color(0xFFFFFFFF),
              ),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 9,),
                        buildQuest(),
                        SizedBox(height: 9,),
                        buildQuest2(),
                        SizedBox(height: 9,),
                        buildQuest3(),
                        SizedBox(height: 9,),
                        buildPict()
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

TextFormField buildQuest() {
  return TextFormField(
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 14,
      color: Color(0xFFA9A9A9),
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0xFFE9E9E9),
      hintText: "Answer Here",
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tidak Boleh Kosong';
      }
      return null;
    },
  );
}

TextFormField buildQuest2() {
  return TextFormField(
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 14,
      color: Color(0xFFA9A9A9),
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0xFFE9E9E9),
      hintText: "Answer Here",
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tidak Boleh Kosong';
      }
      return null;
    },
  );
}

Row buildQuest3() {
  return Row(
    children: [
      Expanded(
        child: TextFormField(
          textAlign: TextAlign.start,
          style: TextStyle(
        fontSize: 14,
        color: Color(0xFFA9A9A9),
          ),
          decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: "Ya",
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
          ),
        ),
      ),
      SizedBox(width: 28 ,),
      Expanded(
        child: TextFormField(
          textAlign: TextAlign.start,
          style: TextStyle(
        fontSize: 14,
        color: Color(0xFFA9A9A9),
          ),
          decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: "Tidak",
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
          ),
        ),
      ),
    ],
  );
}

TextFormField buildPict() {
  return TextFormField(
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 14,
      color: Color(0xFFA9A9A9),
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0xFFE9E9E9),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tidak Boleh Kosong';
      }
      return null;
    },
  );
}
