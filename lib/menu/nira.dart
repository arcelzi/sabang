import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabang/menu/addnira.dart';

class Nira extends StatefulWidget {
  const Nira({super.key});

  @override
  State<Nira> createState() => _NiraState();
}

class _NiraState extends State<Nira> {
  final String FontPoppins = 'FontPoppins';
  List<Map<String, dynamic>> _allNira = [
    {"id": 1, "tappers": "Sabang", "volume": 10}
  ];
  List<Map<String, dynamic>> _foundNira = [];
  @override
  initState() {
    _foundNira = _allNira;
    super.initState();
  }
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> result = [];
    if (enteredKeyword.isEmpty) {
      result = _allNira;
    } else {
      result = _allNira
      .where((nira) => nira['tappers'].toLowerCase().contains(enteredKeyword.toLowerCase()))
      .toList();
    }

    setState(() {
      _foundNira = result;
    });
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
              onChanged: (value) => _runFilter(value),
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
                  itemCount: _foundNira.length,
                  itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundNira[index]["id"]),
                        color: Color(0xFF78937A),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundNira[index]["id"].toString(),
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          title: Text(_foundNira[index]['tappers']),
                          titleTextStyle: TextStyle(color: Colors.white),
                          subtitle: Text(
                              '${_foundNira[index]["volume"].toString()} Liter'),
                          textColor: Colors.white,
                        ),
                      )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => AddNira())));
        },
        backgroundColor: Color(0xFFE5E1E1),
        child: Icon(FontAwesomeIcons.plus),
        foregroundColor: Color(0xFFE0ADA2),
      ),
    );
  }
}
