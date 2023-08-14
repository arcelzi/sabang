import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  final String FontPoppins = 'FontPoppins';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        actions: [
          Container(
            width: 50,
            child: IconButton(onPressed:() {
            },
            icon:Icon(
              FontAwesomeIcons.cartShopping, 
              color: Colors.black,)),
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(FontAwesomeIcons.angleLeft, color: Colors.black,)),
            backgroundColor: Colors.transparent,
            elevation: 0,
        title: Text(
          "Purchase",
          style: TextStyle(
              fontFamily: FontPoppins,
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
