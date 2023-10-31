import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sabang/services/auth_service.dart';
import 'package:sabang/services/common/api_endpoints.dart';
import 'package:sabang/utils/local_storage.dart';
import 'package:sabang/widgets/loading.dart';
import 'package:sabang/widgets/erro_handler.dart';
import 'package:sabang/services/http.dart' as http_service;
import 'package:sabang/widgets/pick_image.dart';
import 'package:sabang/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String avatar = LocalStorage.getAvatar();
  String token = LocalStorage.getToken();
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String? imageBase64;
  late Uint8List imageBytes;



  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
  }


  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("login")??"";
    });
  }

  getUpdate() async {
    var response = await AuthService.getProfile();
    if (response.isSuccess) {
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
          aspectRatioPresets: [
            CropAspectRatioPreset.square
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Crop Image',
                statusBarColor: Colors.black,
                activeControlsWidgetColor: Color(0xFF78937A))
          ]);
      if (croppedFile != null) {
        File croppedImage = File(croppedFile.path);
        Uint8List bytesImage = await croppedImage.readAsBytes();
        setState(() {
          imageBase64 = base64.encode(bytesImage);
          imageBytes = bytesImage;
        });
        await croppedImage.delete();
        if (context.mounted) {
          showLoadingDialogNotdismissible(context);
          var result =
              await AuthService.changeProfilePicture(base64: imageBase64 ?? '');
          if (mounted) Navigator.pop(context);
          if (result.isSuccess && mounted) {
            getUpdate();
          } else {
            errorDialogHandler(
                context: context,
                info: result.userMessage,
                status: result.status);
          }
        }
      }
      File pickedImage = File(image.path);
      await pickedImage.delete();
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
                  Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 72,
                      backgroundImage: NetworkImage(avatar),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 125,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFFE0ADA2)),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        iconSize: 18,
                        onPressed: () async {
                          var imageSource = await showModalBottomSheet(
                              barrierColor: Colors.black12,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12))),
                                    child: SafeArea(
                                        top: false,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              height: 6,
                                              width: 46,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 24),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  photoMenu(
                                                    text: 'Kamera',
                                                    icon: Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.black,
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context,
                                                          ImageSource.camera);
                                                    },
                                                  ),
                                                  photoMenu(
                                                      text: 'Gallery',
                                                      icon: Icon(
                                                        Icons.image,
                                                        color: Colors.black,
                                                      ),
                                                      onTap: () {
                                                        Navigator.pop(
                                                            context,
                                                            ImageSource
                                                                .gallery);
                                                      })
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              });
                          if (imageSource != null)
                            takeImageAndCrop(imageSource: imageSource);
                        },
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: nameController,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan nama';
                          }
                          return null;
                        },
                        onChanged: (value) {
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong masukkan email';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong masukkan No.Hp';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      updateProfile();
                      getUpdate();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE0ADA2),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: Text(
                      "Simpan",
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateProfile() async {
    if(formKey.currentState!.validate()){
    showLoadingDialogNotdismissible(context);
    final name = nameController.text;
    final mail = emailController.text;
    final phone = num.parse(phoneController.text);
    final body = {
      "name": name,
      "email": mail,
      "phone": phone  
    };
    print(body);

    final response = await http_service.patch(
      changeProfileUrl(),
      body: body,
    );
    if (response.isSuccess) {
      print("Sukses");
      setState(() {
        name;
        mail;
        phone;
      });
    } else {
      print("Gagal");
    }
  }
}
}
