import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sabang/menu/addgardencontrol.dart';
import 'package:sabang/services/common/api_endpoints.dart';

import 'package:sabang/services/http.dart' as http_service;
import '../models/garden_control.dart';
import '../utils/local_storage.dart';
import 'detail_garden.dart';

class GardenControlPage extends StatefulWidget {
  const GardenControlPage({super.key});

  @override
  State<GardenControlPage> createState() => _GardenControlPageState();
}

class _GardenControlPageState extends State<GardenControlPage> {
  String token = LocalStorage.getToken();
  final List<GardenControl> gardenControl = [];

  Future<List<GardenControl?>> getGarden() async {
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
  // final List<gardencontrol> garden = [
  //   gardencontrol(
  //       question1: "Perkebunan sehat",
  //       question2: "question2",
  //       question3: "Yes",
  //       foto: 'assets/images/aren.png')
  // ];

  @override
  void initState() {
    getGarden();
    super.initState();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getGarden();
    });
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => AddGarden())));
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
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
              itemCount: gardenControl.length,
              itemBuilder: (context, index) {
                GardenControl detailItem = gardenControl[index];
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   width: 200,
                        //   height: 200,
                        //   // child: Image(image: AssetImage(result.)),
                        // ),
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   height: 70,
                              // ),

                              ListTile(
                                title: Text(
                                  'Tanggal : ' +
                                      gardenControl[index].timestamp.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailGarden(garden: detailItem)
                                          ),
                                          );
                                         
                                    },
                                    icon: Icon(Icons.remove_red_eye_outlined)),
                              ),

                              // Text('Question 2 : ' + result.question2),
                              // Text('Question 3 : ' +result.question3),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } // toList(),
              ),
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
