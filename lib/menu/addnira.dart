import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddNira extends StatefulWidget {
  const AddNira({super.key});

  @override
  State<AddNira> createState() => _AddNiraState();
}

class _AddNiraState extends State<AddNira> {
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
          "Input Nira",
          style: TextStyle(
              fontFamily: FontPoppins,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              width: 350,
              height: 334,
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
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(right: 31),
            height: 44,
            width: 88,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0E86F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  )
                ),
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

TextFormField buildPh() {
  return TextFormField(
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 14,
    ),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Input Ph',
        hintStyle: TextStyle(color: Color(0xFFA9A9A9)),
        focusedBorder:OutlineInputBorder(
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
  );
}

TextFormField buildKadarField() {
  return TextFormField(
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
  );
}

TextFormField buildLiterField() {
  return TextFormField(
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
  );
}
