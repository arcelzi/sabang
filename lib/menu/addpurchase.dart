import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabang/services/common/api_endpoints.dart';
// import 'package:http/http.dart' as http;
import 'package:sabang/services/http.dart' as http_service;
import 'package:sabang/models/users.dart';

import 'package:location/location.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
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

class _AddPurchaseState extends State<AddPurchase> {
  final String FontPoppins = 'FontPoppins';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getPenyadap();
  }

  List<Users> listpenyadap = [];
  getPenyadap() async {
    try {
      final response =
          await http_service.get('http://192.168.102.182:3001/users/penyadap');
      if (response.isSuccess) {
        print(response.data);
        for (var item in response.data) {
          print(item);
          listpenyadap.add(Users(
              id: item['id'], name: item['name'], username: item['username']));
        }
        setState(() {});
      }
    } on SocketException {
      throw Exception('No internet');
    } catch (e) {
      throw Exception('Error mengambil data');
    }
  }

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
          "Add Purchases",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                width: 420,
                height: 450,
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
                            child: Text(
                              'Penyadap',
                              style: TextStyle(
                                fontFamily: FontPoppins,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          DropdownButton(
                              hint: Text('Pilih Penyadap'),
                              isExpanded: true,
                              value: selectedPenyadap,
                              items: listpenyadap.map((e) {
                                return DropdownMenuItem<int>(
                                    value: e.id, child: Text(e.name.toString()));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedPenyadap = value as int;
                                });
                              }),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "PH",
                            style:
                                TextStyle(fontFamily: FontPoppins, fontSize: 16),
                          ),
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
                  onPressed: () {
                    submitNira();

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
      ),
    );
  }

  Future<void> submitNira() async {
    if (_formKey.currentState!.validate()) {
      getLocation().then((value) {
        print(value);
      });

      var currentLocation = await getLocation();

      final ph = num.parse(_phController.text);
      final sugarLevel = num.parse(_brixController.text);
      final volume = num.parse(_volumeController.text);
      final body = {
        "penyadapId": selectedPenyadap,
        "purchaserId": 0,
        "ph": ph,
        "sugarLevel": sugarLevel,
        "volume": volume,
        "lat": currentLocation.latitude,
        "lng": currentLocation.longitude
      };
      print(body);

      final response = await http_service.post(
        addNira(),
        body: body,
      );

      if (response.isSuccess) {
        print('Creation Succes');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Creation Succes")));
        Navigator.pop(context);
      } else {
        print('Creation Failed');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Creation Failed")));
        print(response.data);
      }
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
int? selectedPenyadap = null;

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
