import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.angleLeft), color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        
      ),
    );
  }
}
