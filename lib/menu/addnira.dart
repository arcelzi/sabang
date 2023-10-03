import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sabang/models/users.dart';
import 'package:sabang/pages/nira_page.dart';
import 'package:sabang/models/nira.dart';
import 'package:location/location.dart';

class AddNira extends StatefulWidget {
  const AddNira({super.key});

  @override
  State<AddNira> createState() => _AddNiraState();
}

Location location = new Location();
late bool _serviceEnabled;
late PermissionStatus _permissionGranted;
late LocationData _locationData;

Future<dynamic> getLocation() async {
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) _serviceEnabled = await location.requestService();

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }

  _locationData = await location.getLocation();
  return _locationData;
}

// Future<Nira?> postNira(
//     num penyadapId, num purchaserld, num ph, num sugarLevel, num volume) async {
//   var response =
//       await http.post(Uri.parse("192.168.102.137:3001/purchases"), body: {
//     "penyadapId": penyadapId,
//     "purchaserId": purchaserld,
//     "ph": 1,
//     "sugarLevel": 1,
//     "volume": 1
//   });
//   var data = response.body;
//   print(data);

//   if (response.statusCode == 201) {
//     String responseNum = response.body;
//     niraFromJson(responseNum);
//   } else
//     return null;
// }

class _AddNiraState extends State<AddNira> {
  final String FontPoppins = 'FontPoppins';
  final _formKey = GlobalKey<FormState>();

 

  Future<List<Dropdownmodel>> getPost() async {
    try {
      List<Dropdownmodel> dropdownList = await dropdownmodelFromJson('id');
    final response = await http.get(Uri.parse('http://192.168.102.137:3001/users/penyadap'));
    final body = json.decode(response.body) as List ;
    if(response.statusCode == 200) {
      return body.map((e){
        final map = e as Map<String, dynamic> ;
        return Dropdownmodel(
          id: map['id'],
          name: map['name'],
          username: map['username']
        );
      }).toList();
    }
    }on SocketException{
      throw Exception('No internet');
    }
    throw Exception('Error mengambil data');
  }
  
  var selectedValue;
  
  @override
  Widget build(BuildContext context) {
    // getUser();
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
          "Input Nira",
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
              width: 400,
              height: 430,
              margin: EdgeInsets.symmetric(horizontal: 80),
              padding: EdgeInsets.only(top: 5, left: 16, right: 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD8D4D4),
                    offset: const Offset(
                      0,
                      0,
                    ),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 16),
                          child: 
                          
                          Text(
                            'Penyadap',
                            style: TextStyle(
                              fontFamily: FontPoppins,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 6,),
                        FutureBuilder<List<Dropdownmodel>>(
                          future: getPost(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return DropdownButton(
                                hint: Text('Pilih Penyadap'),
                                isExpanded: true,
                                value: selectedValue,
                                items: snapshot.data!.map((e){
                                  return DropdownMenuItem(
                                    value: e.id.toString(),
                                    child: Text(e.name.toString()));
                                }).toList(), 
                                onChanged: (value){
                                  selectedValue = value;
                                  setState(() {
                                    
                                  });
                                });

                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                        
                        SizedBox(height: 6,),
                        Text("PH", style: TextStyle(fontFamily: FontPoppins, fontSize: 16),),
                        SizedBox(
                          height: 6,
                        ),
                        buildPh(),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            "Kadar Gula",
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildKadarField(),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 16),
                          child: Text("Volume"),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        buildLiterField(),
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 31),
            height: 44,
            width: 88,
            child: ElevatedButton(
                onPressed: (){
                  submitNira();
                  getLocation().then((value){
                    print(value);
                  });
                },
                // () async {
                //   num ph = num.parse(_phController.text);
                //   num sugarLevel = num.parse(_brixController.text);
                //   num volume = num.parse(_volumeController.text);

                //   //  getLocation().then((value){
                //   //     print(value);
                //   //   });
                // },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE0ADA2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Text(
                  "Save",
                  style: TextStyle(
                      fontFamily: FontPoppins,
                      fontSize: 14,
                      color: Color(0xFFFFFFFF)),
                )),
          ),
        ],
      ),
    );
  }

Future<void> submitNira() async {
  final penyadapId = num.parse(getPost().toString());
  final purchaserId = num.parse(getPost().toString());
  final ph = num.parse(_phController.text);
  final sugarLevel = num.parse(_brixController.text);
  final volume = num.parse(_volumeController.text);
  final body = {
    "penyadapId": penyadapId,
    "purchaserId": purchaserId,
    "ph": ph,
    "sugarLevel": sugarLevel,
    "volume": volume,
  };

  final url = 'http://192.168.102.137:3001/purchases';
  final uri = Uri.parse(url);
  final response = await http.post(uri,body: jsonEncode(body),
  headers: {'Content-Type': 'application/json; charset=UTF-8'});

  if(response.statusCode == 201) {
    print('Creation Succes');

  } else {
  print('Creation Failed');
  print(response.body);
  }
}
// List data = [];
// int _value = 1;
//  getUser() async {
//   final res = await http.get(Uri.parse('http://192.168.102.137:3001/users'));
//   data = jsonDecode(res.body);
//   setState(() {
    
//   });
//  }
}

var _phController = TextEditingController();
var _brixController = TextEditingController();
var _volumeController = TextEditingController();




TextFormField buildPh() {
  return TextFormField(
    controller: _phController,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 14,
    ),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Input Ph',
        hintStyle: TextStyle(color: Color(0xFFA9A9A9)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tolong masukkan Ph';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

TextFormField buildKadarField() {
  return TextFormField(
    controller: _brixController,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Input BRIX',
        hintStyle: TextStyle(
          color: Color(0xFFA9A9A9),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tolong masukkan kadar gula';
      }
      return null;
    },
    onChanged: (value) {},
  );
}

TextFormField buildLiterField() {
  return TextFormField(
    controller: _volumeController,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        hintText: 'Masukkan Volume/liter',
        hintStyle: TextStyle(
          color: Color(0xFFA9A9A9),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Tolong Masukkan Volume';
      }
      return null;
    },
    onChanged: (value) {},
  );
}
