import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tappers extends StatefulWidget {
  const Tappers({super.key});

  @override
  State<Tappers> createState() => _TappersState();
}

class _TappersState extends State<Tappers> {
  final String FontPoppins = 'FontPoppins';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        title: Text(
          "Tappers",
          style: TextStyle(
              fontFamily: FontPoppins,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(FontAwesomeIcons.angleLeft, color: Colors.black,)),
      ),
    );
  }
}
