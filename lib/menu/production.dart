import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabang/menu/addproduct.dart';

class Production extends StatefulWidget {
  const Production({super.key});

  @override
  State<Production> createState() => _ProductionState();
}

class _ProductionState extends State<Production> {
  final String FontPoppins = 'FontPoppins';
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
        centerTitle: true,
        title: Text(
          "Production",
          style: TextStyle(
              fontFamily: FontPoppins,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 56, left: 16, right: 16),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 100),
          height: 52,
          width: 309,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Color(0xFFA9A9A9),
                ),
                filled: true,
                fillColor: Color(0xFFE9E9E9),
                hintText: 'Search Production',
                hintStyle: TextStyle(
                    fontFamily: FontPoppins,
                    fontSize: 14,
                    color: Color(0xFFA9A9A9)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => AddProduct())));
          },
          backgroundColor: Colors.black,
          child: Icon(FontAwesomeIcons.database),
          tooltip: 'Add Product',
          foregroundColor: Color(0xFF437FF4)),
    );
  }
}
