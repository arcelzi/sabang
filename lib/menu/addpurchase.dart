import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
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
          "Purchase",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              width: 350,
              height: 530,
              margin: EdgeInsets.symmetric(horizontal: 80),
              padding: EdgeInsets.only(top: 5, left: 16, right: 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD8D4D4),
                    offset: Offset(0, 0),
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
                          padding: EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            "Tappers",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildTap(),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            "PH",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildPh2(),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            "Brix",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildBrix(),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            "Volume",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildNira(),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            "Total Harga",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildTotal()
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(right: 31),
            width: 88,
            height: 44,
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
                        borderRadius: BorderRadius.circular(30))),
                child: Text("Save", style: TextStyle(fontSize: 14, color: Colors.white),)),
          )
        ],
      ),
    );
  }
}

TextFormField buildTap() {
  return TextFormField(
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 14,
    ),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Input Tapper',
        hintStyle: TextStyle(color: Color(0xFFA9A9A9)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tolong masukkan nama tapper';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

TextFormField buildPh2() {
  return TextFormField(
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Input Ph',
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
        return 'Tolong masukkan Ph';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

TextFormField buildBrix() {
  return TextFormField(
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Masukkan Kadar gula',
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
        return 'Tolong Masukkan Kadar gula';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

TextFormField buildNira() {
  return TextFormField(
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Masukkan Volume nira',
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
        return 'Tolong Masukkan Volume nira';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

TextFormField buildTotal() {
  return TextFormField(
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Masukkan total harga',
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
        return 'Tolong Masukkan total harga';
      }
      return null;
    },
    onChanged: (value) {},
  );
}
