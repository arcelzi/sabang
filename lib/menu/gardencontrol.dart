import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabang/menu/addgardencontrol.dart';

class GardenControl extends StatefulWidget {
  const GardenControl({super.key});

  @override
  State<GardenControl> createState() => _GardenControlState();
}

class _GardenControlState extends State<GardenControl> {
  final String FontPoppins = 'FontPoppins';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        title: Text(
          "Garden Control",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 56, left: 16, right: 16),
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
                  hintText: 'Search Garden',
                  hintStyle: TextStyle(
                    fontFamily: FontPoppins,
                    fontSize: 14,
                    color: Color(0xFFA9A9A9),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)
                  )
              ),
            ),
          ),
        ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: ((context) => AddGarden())));
        },
        backgroundColor: Color(0xFFE5E1E1),
        child: Icon(FontAwesomeIcons.plus),
        foregroundColor: Color(0xFFE0ADA2),
        ),
    );
  }
}
