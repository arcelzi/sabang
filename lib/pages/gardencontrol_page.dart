
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sabang/menu/addgardencontrol.dart';
import 'package:sabang/services/common/api_endpoints.dart';

import 'package:sabang/services/http.dart' as http_service;
import '../models/garden_control.dart';
import '../utils/local_storage.dart';



class GardenControlPage extends StatefulWidget {
  const GardenControlPage({super.key});

  @override
  State<GardenControlPage> createState() => _GardenControlPageState();
}

class _GardenControlPageState extends State<GardenControlPage> {
  String token = LocalStorage.getToken();
  final List<GardenControl> gardenControl= [];

  Future<List<GardenControl?>> getGarden() async{
    final response = await http_service.get(getGardenControl());

    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = response.data;
      if (result is List) {
        for (var item in result) {
          gardenControl.add(GardenControl.fromJson(item));
        }
      }
    } else {
      print(response.data);
    }
    setState(() {});
    return gardenControl;
  }
  final String FontPoppins = 'FontPoppins';
  final List<gardencontrol> garden = [
    gardencontrol(
        question1: "Perkebunan sehat",
        question2: "question2",
        question3: "Yes",
        foto: 'assets/images/aren.png')
  ];
  
  @override 
  void initState() {
    getGarden();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6FB),
        appBar: AppBar(
          title: Text(
            "Garden Control",
            style: GoogleFonts.sourceSansPro(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
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
          centerTitle: true,
          actions: [
            Container(
              width: 80,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => AddGarden())));
                },
                icon: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.black,
                  size: 25,
                ),
                tooltip: "Add Garden",
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            
          }),
          toList(),
        ));
  }
}



class gardencontrol {
  final String question1;
  final String question2;
  final String question3;
  final String foto;

  gardencontrol(
      {required this.question1,
      required this.question2,
      required this.question3,
      required this.foto});
}
