import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}


class _AddProductState extends State<AddProduct> {
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
          icon: Icon(FontAwesomeIcons.angleLeft),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add Production",
          style: TextStyle(
              fontFamily: FontPoppins,
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              height: 450,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Color(0xFFFFFFFF)),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
