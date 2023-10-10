import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sabang/menu/profile/profile.dart';
import 'package:sabang/services/auth_service.dart';
import 'package:sabang/utils/local_storage.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}
  class _UpdateProfileState extends State<UpdateProfile>{
  String name = LocalStorage.getName();
  String avatar = LocalStorage.getAvatar();
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  String editName = '';
  String? imageBase64;
  late Uint8List imageBytes;

  @override
  void setState(VoidCallback fn) {
    if(mounted) super.setState(fn); 
  }

  @override
  void initState() {
    super.initState();
  }

  getUpdate() async{
    var response = await AuthService.getProfile();
    if (response.isSuccess){
      setState(() {
        LocalStorage.setAvatar(response.data['avatar']);
        avatar = LocalStorage.getAvatar();
      });
    }
  }

  takeImageAndCrop({required ImageSource imageSource}) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressQuality: 50,
        maxHeight: 1000,
        maxWidth: 1000,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            statusBarColor: Colors.black,
            activeControlsWidgetColor: Color(0xFF78937A)
          )
        ]);
        if (croppedFile != null) {
          File croppedImage = File(croppedFile.path);
          Uint8List bytesImage = await croppedImage.readAsBytes();
          setState(() {
            imageBase64 = base64.encode(bytesImage);
            imageBytes = bytesImage;
          });
          await croppedImage.delete();
          if(context.mounted) {
            
          }

        }
    }
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset('assets/images/people.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFFE0ADA2)),
                      child: Icon(
                        FontAwesomeIcons.camera,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text("Name"),
                      prefixIcon: Icon(FontAwesomeIcons.idCard),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color(0xFF78937A),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text("Email"),
                      prefixIcon: Icon(FontAwesomeIcons.envelope),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color(0xFF78937A),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text("Phone"),
                      prefixIcon: Icon(FontAwesomeIcons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color(0xFF78937A),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text("Password"),
                      prefixIcon: Icon(FontAwesomeIcons.key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color(0xFF78937A),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                    ),
                  ),
                ],
              ),),
              SizedBox(height: 50,),
              SizedBox(
                height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => Profile())));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE0ADA2),
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: Text(
                        "Edit Profile",
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }

}
