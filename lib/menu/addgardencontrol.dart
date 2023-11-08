import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sabang/services/common/api_endpoints.dart';
import 'package:sabang/view/selectphoto.dart';
import 'package:sabang/services/http.dart' as http_service;

import '../models/search.dart';
import '../utils/local_storage.dart';

class AddGarden extends StatefulWidget {
  const AddGarden({super.key});

  @override
  State<AddGarden> createState() => _AddGardenState();
}

class _AddGardenState extends State<AddGarden> {
  String token = LocalStorage.getToken();
  final String FontPoppins = 'FontPoppins';
  final _formKey = GlobalKey<FormState>();
  final List<Check> checks = [];
  String selectValue = '';
  File? _image;

  Future<void> getCheck() async {
    print('ipakimsa');
    try {
      final response = await http_service.get(checkGardenControl());
      if (response.isSuccess) {
        print(response.data);
        for (var item in response.data) {
          print(item);
          checks.add(Check(id: item['id'], title: item['title'], type: item['type']));
        }
        setState(() {});
      }
    } on SocketException {
      throw Exception('No internet');
    } catch (e) {
      print(e);
      throw Exception('Error mengambil data');
    }
  }

  @override
  void initState() {
    super.initState();
    getCheck();
  }

  Future _pickImage(ImageSource source) async {
    try {
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
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
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
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: SelectPhotoOptions(
                  ontap: _pickImage,
                ),
              );
            })));
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 80, vertical: 25),
                padding: EdgeInsets.only(left: 20, right: 20),
                // height: 617,
                // width: 350,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for(var check in checks) ...[
                        Text(check.title),
                        check.type == 'text' ? 
                          buildQuest() :
                          check.type == 'image' ?
                          buildPhoto() : 
                          buildCheck()
                      ]
                    ],
                  ),
                )),
            SizedBox(
              height: 10,
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
      ),
    );
  }

  Container buildPhoto() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFE9E9E9)
      ),
      child: IconButton(
        onPressed: (){
          _showSelectPhotoOptions(context);
        }, 
        icon: Icon(Icons.add_photo_alternate_rounded),
        color: Color(0xFF6D6B6B),
        iconSize: 30,),
    );
  }
 Row buildCheck() {
  return Row(
    children: [
       Expanded(
         child: RadioListTile(
          activeColor: Color(0xFF78937A),
          title: Text('Yes'),
          value: 'yes', 
          groupValue: selectValue, 
          onChanged: (value) {
            setState(() {
              selectValue = value.toString();
            });
          },),
       ),
      Expanded(
        child: RadioListTile(
          activeColor: Color(0xFF78937A),
          title: Text('No'),
          value: 'no', 
          groupValue: selectValue, 
          onChanged: (value) {
            selectValue = value.toString();
          },))
 
    

    ],
  );
 }
}




var answerController = TextEditingController();
var jawabController = TextEditingController();

TextFormField buildQuest() {
  return TextFormField(
    controller: answerController,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14, color: Colors.black),
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
    controller: jawabController,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14, color: Colors.black),
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
