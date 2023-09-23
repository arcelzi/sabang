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
  List<Nira> niraList = [];

 Future<List<Nira?>> getNira() async {
  Uri api = Uri.parse("http://192.168.102.137:3001/purchases");
  var response = await http.get(api);
  List<Nira> nira = [];

  print(response.statusCode);
  if(response.statusCode == 200) {
    var result = json.decode(response.body);
    for (var item in result){
      print(item);
      nira.add(Nira.fromJson(item));
    }
    setState(() {
      
    });
    return nira;
  } else {
    return nira;
  }
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
              child: FutureBuilder(
                future: getNira(),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
                      return ListView.builder(itemBuilder: (context, index){
                        return Card(
                          child: Padding(padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(niraList[index].ph.toString()),
                              Text(niraList[index].sugarlevel.toString()),
                              Text(niraList[index].volume.toString())
                            ],
                          ),),
                        );
                      },
                      itemCount: niraList.length,);
                    } else {
                      return Center(child: Text("TIDAK ADA NIRA"),);
                    }
                  }
                }),
            )
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

