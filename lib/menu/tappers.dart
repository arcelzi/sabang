import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Tappers extends StatefulWidget {
  const Tappers({super.key});

  @override
  State<Tappers> createState() => _TappersState();
}

class _TappersState extends State<Tappers> {
  final String FontPoppins = 'FontPoppins';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        title: Text(
          "Tappers",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              width: 350,
              height: 260,
              padding: EdgeInsets.only(top: 5, right: 16, left: 16),
              margin: EdgeInsets.symmetric(horizontal: 80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD8D4D4),
                    offset: Offset(0, 0),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
                color: Color(0xFFFFFFFF),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Nama Tapper",style: TextStyle(fontSize: 16,),
                          ),),
                          SizedBox(height: 6,),
                          buildTapper(),
                          Padding(padding: EdgeInsets.all(15),
                          child: Text("Nama Kolektor", style: TextStyle(fontSize: 16),),),
                          SizedBox(height: 6,),
                          buildDay()
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(right: 31),
            height: 44,
            width: 88,
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE0ADA2),
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

TextFormField buildTapper() {
  return TextFormField(
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: "Masukkan Nama Tapper",
        hintStyle: TextStyle(color: Color(0xFFA9A9A9)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tolong masukkan Nama Tappers';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

TextFormField buildDay() {
  return TextFormField(
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: "Masukkan nama kolektor",
        hintStyle: TextStyle(color: Color(0xFFA9A9A9)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tolong masukkan nama kolektor';
      }
      return null;
    },
    onChanged: (value) {},
  );
}
