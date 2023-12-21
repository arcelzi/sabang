import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sabang/menu/addpurchase.dart';
import 'package:sabang/services/common/api_endpoints.dart';
import 'package:sabang/services/http.dart' as http_service;
import 'package:sabang/models/nira.dart';
import 'package:sabang/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  String token = LocalStorage.getToken();
  // final TextEditingController searchController = TextEditingController();
  final String FontPoppins = 'FontPoppins';
  final List<Nira> nira = [];
  bool isConnected = true;
  var selectedItem = '';

  // void main(DateTime timestamp) async {
  //   await initializeDateFormatting('id_ID', null);
  //   // formatDate(timestamp);
  //   print(DateFormat.yMMMMd('id_ID').format(DateTime.now()));
  // }

  // String formatDate(DateTime timestamp) {
  //   final DateFormat formatter = DateFormat('dd-MM-yyyy', 'Asia/Jakarta');
  //   return formatter.format(timestamp);
  // }

  Future<void> loadCachedData() async {
    nira.clear();
    final cachedData = Hive.box<List>('nira_cache').get('nira_cache_key');
    if (cachedData != null) {
      setState(() {
        nira.addAll(cachedData.map((item) => Nira.fromJson(item)));
      });
      print(nira.length);
    }
  }

  Future<void> getNira() async {
    try {
      if (isConnected) {
        final response = await http_service.get(getPurchase());
        print(response.statusCode);
        if (response.statusCode == 200) {
          var result = response.data;
          if (result is List) {
            Hive.box<List>('nira_cache').put('nira_cache_key', result);
            nira.clear();
            setState(() {
              
              nira.addAll(result.map((item) => Nira.fromJson(item)));
            });
          }
        } else {
          print(response.data);
        }
      } else {
        loadCachedData();
      }
    } catch (e) {
      print('Error mengambil data: $e');
      if (!isConnected) {
        showNoInternetToast();
      }
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    openHiveBoxes();
    getCred();
    super.initState();
    checkInternetConnection();
    if (isConnected) {
      getNira();
    } else {
      loadCachedData();
    }
  }

  Future<void> checkInternetConnection() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      setState(() {
        isConnected = connectivityResult != ConnectivityResult.none;
      });
      if (!isConnected) {
        showNoInternetToast();
      }
    } catch (e) {
      print('Error, memeriksa koneksi internet');
    }
  }

  void openHiveBoxes() async {
    await Hive.initFlutter();
    await Hive.openBox<List>('nira_cache');
  }

  void showNoInternetToast() {
    Fluttertoast.showToast(
        msg: 'Tidak ada koneksi internet',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("login") ?? "";
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getNira();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                selectedItem = value.toString();
              });
              Navigator.pushNamed(context, value.toString());
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Data offline', style: TextStyle(color: Colors.black),),
                value: '/dataOffline',
              ),

            ],
            
            elevation: 0,
            shadowColor: Colors.black,
            surfaceTintColor: Colors.black,
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
            )),
        backgroundColor: Color(0xFF78937A),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Purchases",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              // TextField(
              //   controller: searchController,
              //   onChanged: (value) => (),
              //   decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Color(0xFFE9E9E9),
              //       focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30),
              //           borderSide:
              //               BorderSide(color: Color(0xFFE9E9E9), width: 0)),
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30),
              //           borderSide:
              //               BorderSide(color: Color(0xFFE9E9E9), width: 0)),
              //       hintText: 'Search',
              //       hintStyle: TextStyle(
              //           fontFamily: FontPoppins,
              //           fontSize: 14,
              //           color: Color(0xFFA9A9A9)),
              //       prefixIcon: Icon(
              //         Icons.search_rounded,
              //         color: Color(0xFFA9A9A9),
              //       )),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFB99470),
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
                                "Kadar Gula : " +
                                    nira[index].sugarLevel.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Volume : " + nira[index].volume.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Harga: " + nira[index].amount.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Tanggal : " +
                                    DateFormat('d MMM yyyy')
                                        .format(nira[index].timestamp),
                                style: TextStyle(color: Colors.white),
                              )
                            ]),
                      ),
                    ));
                  },
                  itemCount: nira.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => AddPurchase())));
        },
        backgroundColor: Color(0xFFE5E1E1),
        child: Icon(FontAwesomeIcons.plus),
        foregroundColor: Color(0xFF78937A),
      ),
    );
  }
}
