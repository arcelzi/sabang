
// import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:sabang/services/common/api_endpoints.dart';
// import 'package:sabang/view/selectphoto.dart';
import 'package:sabang/services/http.dart' as http_service;
// import 'dart:html' as html;

import '../models/checklits.dart';
import '../utils/local_storage.dart';

class Kuisioner {
  Check question;
  dynamic value;

  Kuisioner({required this.question, this.value});
}

class AddGarden extends StatefulWidget {
  const AddGarden({super.key});

  @override
  State<AddGarden> createState() => _AddGardenState();
}

Location location = new Location();
late bool _serviceEnabled;
late PermissionStatus _permissionGranted;
late LocationData _locationData;

Future<LocationData> getLocation() async {
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) _serviceEnabled = await location.requestService();

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }

  _locationData = await location.getLocation();
  return _locationData;
}

class _AddGardenState extends State<AddGarden> {
  String token = LocalStorage.getToken();
  final String FontPoppins = 'FontPoppins';
  final _formKey = GlobalKey<FormState>();
  final List<Check> checks = [];
  String selectValue = '';
  // File? _image;
  Map<String, TextEditingController> controllers = {};
  final List<Kuisioner> kuisioneResult = [];
  // List<int>? _selectedFile;
 

  Future<void> getCheck() async {
    // print('ipakimsa');
    try {
      final response = await http_service.get(checkGardenControl());
      if (response.isSuccess) {
        print(response.data);
        for (var item in response.data) {
          print(item);
          kuisioneResult.add(Kuisioner(
              question: Check(
                  id: item['id'], title: item['title'], type: item['type']),
              value: null));
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

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // webFilePicker() async {
  //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //   uploadInput.multiple = true;
  //   uploadInput.draggable = true;
  //   uploadInput.click();

  //   uploadInput.onChange.listen((event) {
  //     final files = uploadInput.files;
  //     final file = files![0];
  //     final reader = html.FileReader();

  //     reader.onLoadEnd.listen((event) {
  //       setState(() {
  //         _bytesData = Base64Decoder().convert(reader.result.toString().split(',').last);
  //         _selectedFile = _bytesData;
  //       });
  //     });
  //     reader.readAsDataUrl(file);
  //   });
  // }

  // Future _pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     File? img = File(image.path);
  //     img = await _cropImage(imageFile: img);
  //     setState(() {
  //       _image = img;
  //       Navigator.of(context).pop();
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //     Navigator.of(context).pop();
  //   }
  // }

  Future _pickFromGallery(Kuisioner kuisioner) async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      kuisioner.value = File(returnImage.path);
      
      // _image = File(returnImage.path);
      // selectedImage = File(returnImage.path).readAsBytesSync();
    });
    Navigator.pop(context);
  }

  //camera
  Future _pickFromCamera(Kuisioner kuisioner) async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      kuisioner.value = File(returnImage.path);
      // _image = File(returnImage.path);
      // selectedImage = File(returnImage.path).readAsBytesSync();
    });
    Navigator.pop(context);
  }

  Future _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'cropper',
        ),
        WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: CroppieBoundary(width: 100, height: 100),
            viewPort: CroppieViewPort(width: 100, height: 100, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true)
      ],
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void showImageOption(BuildContext context, Kuisioner kuisioner) {
    showModalBottomSheet(
      context: context, 
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      _pickFromGallery(kuisioner);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.image, size: 40),
                          Text('Gallery')
                        ],
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      _pickFromCamera(kuisioner);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, size: 40),
                          Text('Camera')
                        ],
                      ),
                    ),
                  ))
              ],
            ),
          ),
          );
      });
  }

  // void _showSelectPhotoOptions(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(10),
  //         ),
  //       ),
  //       builder: ((context) => DraggableScrollableSheet(
  //           initialChildSize: 0.28,
  //           maxChildSize: 0.4,
  //           minChildSize: 0.28,
  //           expand: false,
  //           builder: (context, scrollController) {
  //             return SingleChildScrollView(
  //               controller: scrollController,
  //               child: SelectPhotoOptions(
  //                 ontap: _pickImage,
  //               ),
  //             );
  //           })));
  // }

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
                // margin: EdgeInsets.symmetric(horizontal: 80, vertical: 25),
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                      // for (var check in checks) ...[
                      //   Text(check.title, ),
                      //   check.type == 'text'
                      //       ? buildQuest(check.id)
                      //       : check.type == 'image'
                      //           ? buildPhoto()
                      //           : buildCheck(check.id),
                      // ]
                      for (var item in kuisioneResult) ...[
                        Text(item.question.title),
                        if (item.question.type == 'check')
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: item.value == true
                                        ? Color(0xFF78937A)
                                        : Colors.grey.shade400),
                                onPressed: () {
                                  setState(() {
                                    item.value = true;
                                  });
                                },
                                child: Text('Ya'),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: item.value == false
                                        ? Color(0xFF78937A)
                                        : Colors.grey.shade400),
                                onPressed: () {
                                  setState(() {
                                    item.value = false;
                                  });
                                },
                                child: Text('Tidak'),
                              ),
                            ],
                          ),
                        if (item.question.type == 'text')
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFE9E9E9),
                              hintText: 'Answer here',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xFFE9E9E9), width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Color(0xFFE9E9E9), width: 0)),
                            ),
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            onChanged: (text) {
                              setState(() {
                                item.value = text;
                              });
                            },
                          ),
                        if (item.question.type == 'image') 
                        
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFE9E9E9)
                          ),
                          child: item.value != null ? Image.memory(item.value.readAsBytesSync()!, fit: BoxFit.cover) 
                          : IconButton(
                          onPressed: (){
                             showImageOption(context, item);
                          }, icon: Icon(Icons.add_photo_alternate_rounded),
                          color: Color(0xFF6D6B6B),
                          iconSize: 30,)
                        ) 
                        // buildPhoto() 
                        // Tambahkan widget untuk memilih gambar
                        // Contoh: ImagePicker
                      ]
                    ],
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            
            Container(
              margin: EdgeInsets.only(right: 20, bottom: 5),
              height: 44,
              width: 88,
              child: ElevatedButton(
                  onPressed: () {
                    print(kuisioneResult.map(
                        (e) => {'title': e.question.title, 'value': e.value}));
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

  Future<void> submitGarden() async {
    if (_formKey.currentState!.validate()) {
      getLocation().then((value) {
        print(value);
      });

      var currentLocation = await getLocation();
    }
  }

  // Container buildPhoto() {
  //   return Container(
  //     height: 100,
  //     width: 100,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(15), color: Color(0xFFE9E9E9)),
  //     child: IconButton(
  //       onPressed: () {
  //         // _showSelectPhotoOptions(context);
  //       showImageOption(context);
  //       },
  //       icon: Icon(Icons.add_photo_alternate_rounded),
  //       color: Color(0xFF6D6B6B),
  //       iconSize: 30,
  //     ),
  //   );
  // }
//   TextFormField buildQuest(int checkId) {
//   return TextFormField(
//     key: Key('text_form_field_$checkId'),
//     controller: controllers[checkId] ?? TextEditingController(),
//     textAlign: TextAlign.start,
//     style: TextStyle(fontSize: 14, color: Colors.black),
//     decoration: InputDecoration(
//       filled: true,
//       fillColor: Color(0xFFE9E9E9),
//       hintText: "Answer Here",
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
//       enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
//     ),
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'Tidak Boleh Kosong';
//       }
//       return null;
//     },
//   );
// }

  // Row buildCheck(int checkId) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: RadioListTile(
  //           key: Key('radio_yes_$checkId'),
  //           activeColor: Color(0xFF78937A),
  //           title: Text('Yes'),
  //           value: 'yes',
  //           groupValue: selectValue,
  //           onChanged: (value) {
  //             setState(() {
  //               selectValue = value.toString();
  //             });
  //           },
  //         ),
  //       ),
  //       Expanded(
  //           child: RadioListTile(
  //             key: Key('radio_no_$checkId'),
  //         activeColor: Color(0xFF78937A),
  //         title: Text('No'),
  //         value: 'no',
  //         groupValue: selectValue,
  //         onChanged: (value) {
  //           setState(() {

  //           selectValue = value.toString();
  //           });
  //         },
  //       ))
  //     ],
  //   );
  // }
}

// var answerController = TextEditingController();
// var jawabController = TextEditingController();



// TextFormField buildQuest2() {
//   return TextFormField(
//     controller: jawabController,
//     textAlign: TextAlign.start,
//     style: TextStyle(fontSize: 14, color: Colors.black),
//     decoration: InputDecoration(
//       filled: true,
//       fillColor: Color(0xFFE9E9E9),
//       hintText: "Answer Here",
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
//       enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
//     ),
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'Tidak Boleh Kosong';
//       }
//       return null;
//     },
//   );
// }
