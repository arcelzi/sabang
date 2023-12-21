import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:sabang/services/common/api_endpoints.dart';
import 'package:sabang/services/http.dart' as http_service;

class GardenOffline extends StatefulWidget {
  const GardenOffline({super.key});

  @override
  State<GardenOffline> createState() => _GardenOfflineState();
}

class _GardenOfflineState extends State<GardenOffline> {
  late Box offlineDataBox;
  List offlineDataList = [];
  @override
  void initState() {
    super.initState();

    initial();
  }
  initial() async {
    offlineDataBox = await Hive.openBox('gardenControl');
    offlineDataList = offlineDataBox.values.toList();
    setState(() {
      
    });
  }
  void uploadData(Map<String,dynamic> data) async {
    try {
      final response = await http_service.post(addGardenControl(), body: data);

      if (response.isSuccess) {
        Fluttertoast.showToast(
          msg: 'Upload sukses',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0
          );
          Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: 'Upload gagal',
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
          Navigator.pop(context);
      } 
    } catch (e) {
      print('Error saat sedang upload');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        title: Text(
          'Data Offline',
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(FontAwesomeIcons.angleLeft),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: buildOfflineDataList(),
    );
  }

  Widget buildOfflineDataList() {
    return ListView.builder(
      itemCount: offlineDataList.length,
      itemBuilder: (context, index) {
       var gardenData = offlineDataList[index];
        return ListTile(
          title: Text('${gardenData}'),
          trailing: IconButton(onPressed: (){
            showDialog(
              context: context, builder: ((context) {
                return AlertDialog(
                  content: IntrinsicHeight(
                    child: Column(
                      children: [
                        Text('Apakah anda yakin ingin upload?'),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // TODO upload
                                  uploadData(gardenData);
                                  // delete
                                  offlineDataBox.delete(gardenData['uid']);
                                }, 
                                child: const Text('Ya'),
                                ),
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                }, 
                                child: const Text('Tidak'))
                            ],
                          ))
                      ],
                    ),
                  ),
                );
              }));
          }, icon: Icon(Icons.cloud_upload)),
        );
      });

  }
  
}
