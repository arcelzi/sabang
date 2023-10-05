
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sabang/menu/addgardencontrol.dart';



class GardenControlPage extends StatefulWidget {
  const GardenControlPage({super.key});

  @override
  State<GardenControlPage> createState() => _GardenControlPageState();
}

class _GardenControlPageState extends State<GardenControlPage> {
  final String FontPoppins = 'FontPoppins';
  final List<gardencontrol> garden = [
    gardencontrol(
        question1: "Perkebunan sehat",
        question2: "question2",
        question3: "Yes",
        foto: 'assets/images/aren.png')
  ];

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
        body: ListView(
          children: garden.map((result) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image(image: AssetImage(result.foto)),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Text('Question 1 : ' + result.question1),
                          Text('Question 2 : ' + result.question2),
                          Text('Question 3 : ' +result.question3),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
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
