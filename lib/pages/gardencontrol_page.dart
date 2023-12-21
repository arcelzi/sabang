import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import 'package:sabang/menu/addgardencontrol.dart';
import 'package:sabang/services/common/api_endpoints.dart';

import 'package:sabang/services/http.dart' as http_service;
import '../models/garden_control.dart';
import '../models/users.dart';
import '../utils/local_storage.dart';
import 'detail_garden.dart';
import 'package:hive/hive.dart';

class GardenControlPage extends StatefulWidget {
  const GardenControlPage({super.key});

  @override
  State<GardenControlPage> createState() => _GardenControlPageState();
}

class _GardenControlPageState extends State<GardenControlPage> {
  String token = LocalStorage.getToken();
  final List<GardenControl> gardenControl = [];
  String imageUrl = '';
  final String FontPoppins = 'FontPoppins';
  bool isConnected = true;
  var selectedItem = '';

  Future<void> loadCachedData() async {
    final cachedData = Hive.box<List>('garden_cache').get('garden_cache_key');
    if (cachedData != null) {
      setState(() {
        gardenControl
            .addAll(cachedData.map((item) => GardenControl.fromJson(item)));
      });
    }
  }

  Future<void> getGarden() async {
    try {
      if (isConnected) {
        final response = await http_service.get(getGardenControl());
        print(response.statusCode);
        if (response.statusCode == 200) {
          var result = response.data;
          if (result is List) {
            Hive.box<List>('garden_cache').put('garden_cache_key', result);
            // imageUrl = item['imageUrl'];
            setState(() {
              gardenControl.clear();
              gardenControl
                  .addAll(result.map((item) => GardenControl.fromJson(item)));
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

  // final List<gardencontrol> garden = [
  //   gardencontrol(
  //       question1: "Perkebunan sehat",
  //       question2: "question2",
  //       question3: "Yes",
  //       foto: 'assets/images/aren.png')
  // ];

  @override
  void initState() {
    openHiveBoxes();
    super.initState();
    checkInternetConnection();
    if (isConnected) {
      getGarden();
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
    await Hive.openBox<List>('garden_cache');
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

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getGarden();
    });
  }

  Future<Users?> getUser(String penyadapId) async {
    try {
      final response = await http_service.get(getTappers());
      if (response.isSuccess) {
        var userData = response.data;
        return Users(
            id: userData['id'],
            name: userData['name'],
            username: userData['username']);
      } else {
        print(response.data);
        return null;
      }
    } catch (e) {
      print('Error mengambil data pengguna');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6FB),
        appBar: AppBar(
          title: Text(
            "Garden Control",
            style: GoogleFonts.sourceSansPro(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
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
          actions: [
           PopupMenuButton(
            onSelected: (value) {
              setState(() {
                selectedItem = value.toString();
              });
              Navigator.pushNamed(context, value.toString());
            },
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('Data Offline', style: TextStyle(color: Colors.black),),
              value: '/dataOffline' ,),
              PopupMenuItem(child: Text("Tambah Garden Control", style: TextStyle(color: Colors.black),),
              value: '/tambahData',)
            ],)
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
                                style: ListTileStyle.list,
                                title: Text(
                                  'Tanggal : ' +
                                      DateFormat('d MMM yyyy').format(
                                          gardenControl[index].timestamp),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                subtitle: Text('Penyadp Id :' +
                                    gardenControl[index].penyadapId.toString()),
                                trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailGarden(
                                                  garden: detailItem,
                                                  imageUrl: imageUrl,
                                                )),
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

// class gardencontrol {
//   final String question1;
//   final String question2;
//   final String question3;
//   final String foto;

//   gardencontrol(
//       {required this.question1,
//       required this.question2,
//       required this.question3,
//       required this.foto});
// }
