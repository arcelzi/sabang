import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sabang/view/selectphoto.dart';
import 'package:sabang/widgets/imagepicker.dart';

class AddGarden extends StatefulWidget {
  const AddGarden({super.key});

  @override
  State<AddGarden> createState() => _AddGardenState();
}

class _AddGardenState extends State<AddGarden> {
  final String FontPoppins = 'FontPoppins';
  final _formKey = GlobalKey<FormState>();
  String selectValue = '';
  File? _image;

  Future _pickImage(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions (BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ), 
      builder: ((context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController){
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptions(
               ontap: _pickImage,
              ),
            );
          }
        )
      )
    );
  }
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
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 80, vertical: 25),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 617,
              width: 350,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD8D4D4),
                    offset: const Offset(0, 0),
                    blurRadius: 6,
                    spreadRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.circular(14),
                color: Color(0xFFFFFFFF),
              ),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Question",
                            style: TextStyle(
                                fontSize: 14, fontFamily: FontPoppins),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        buildQuest(),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("Question",
                              style: TextStyle(
                                  fontFamily: FontPoppins, fontSize: 14)),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        buildQuest2(),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Question",
                            style: TextStyle(
                                fontFamily: FontPoppins, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                  activeColor: Color(0xFF78937A),
                                  title: Text("Yes"),
                                  value: 'yes',
                                  groupValue: selectValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectValue = value.toString();
                                    });
                                  }),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  activeColor: Color(0xFF78937A),
                                  title: Text("No"),
                                  value: 'no',
                                  groupValue: selectValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectValue = value.toString();
                                    });
                                  }),
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Tambah Foto",
                                style: TextStyle(
                                    fontFamily: FontPoppins, fontSize: 14))),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          height: 185,
                          width: 215,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFE9E9E9),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _showSelectPhotoOptions(context);
                            },
                            icon: Icon(Icons.add_photo_alternate_rounded),
                            color: Color(0xFF6D6B6B),
                            iconSize: 45,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 44,
            width: 88,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE0ADA2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                      fontFamily: FontPoppins,
                      fontSize: 14,
                      color: Color(0xFFFFFFFF)),
                )),
          )
        ],
      ),
    );
  }
}


var questController = TextEditingController();
var quest1Controller = TextEditingController();



TextFormField buildQuest() {
  return TextFormField(
    controller: questController,
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
    controller: quest1Controller,
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
