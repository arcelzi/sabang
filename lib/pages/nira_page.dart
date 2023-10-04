import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabang/menu/addnira.dart';
import 'package:http/http.dart' as http;
import 'package:sabang/models/nira.dart';

class NiraPage extends StatefulWidget {
  const NiraPage({super.key});

  @override
  State<NiraPage> createState() => _NiraPageState();
}

class _NiraPageState extends State<NiraPage> {
  final String FontPoppins = 'FontPoppins';
  final List<Nira> nira = [];

  Future<List<Nira?>> getNira() async {
    Uri api = Uri.parse("http://192.168.102.10:3001/purchases");
    var response = await http.get(api);

    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      for (var item in result) {
        nira.add(Nira.fromJson(item));
      }
    }
    setState(() {});
    return nira;
  }

  @override
  void initState() {
    getNira();
    super.initState();
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
        centerTitle: true,
        title: Text(
          "Nira",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => (),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFE9E9E9),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(color: Color(0xFFE9E9E9), width: 0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(color: Color(0xFFE9E9E9), width: 0)),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontFamily: FontPoppins,
                      fontSize: 14,
                      color: Color(0xFFA9A9A9)),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Color(0xFFA9A9A9),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF78937A),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PH : " + nira[index].ph.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "BRIX : " + nira[index].sugarLevel.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Volume : " + nira[index].volume.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Amount: " + nira[index].amount.toString(),
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                  ),
                ));
              },
              itemCount: nira.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => AddNira())));
        },
        backgroundColor: Color(0xFFE5E1E1),
        child: Icon(FontAwesomeIcons.plus),
        foregroundColor: Color(0xFFE0ADA2),
      ),
    );
  }
}
