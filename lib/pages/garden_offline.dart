import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:sabang/pages/gardencontrol_page.dart';
import 'package:sabang/services/common/api_endpoints.dart';
import 'package:sabang/services/http.dart' as http_service;
import 'package:sabang/widgets/toast.dart';

class GardenOffline extends StatefulWidget {
  const GardenOffline({super.key});

  @override
  State<GardenOffline> createState() => _GardenOfflineState();
}

class _GardenOfflineState extends State<GardenOffline> {
  late Box offlineGardenBox;
  List offlineGardenList = [];
  @override
  void initState() {
    super.initState();

    initial();
  }

  initial() async {
    offlineGardenBox = await Hive.openBox('gardenControl');
    offlineGardenList = offlineGardenBox.values.toList();
    setState(() {});
  }

  void refreshData() {
    setState(() {
      offlineGardenList = offlineGardenBox.values.toList();
    });
  }

  Future<void> uploadData(Map<String, dynamic> data) async {
    try {
      final response = await http_service.post(addGardenControl(), body: data);

      if (response.isSuccess) {
        CustomToast.show(context, 'Upload sukses', isSuccess: true);
      } else {
        CustomToast.show(context, 'Upload gagal', isSuccess: false);
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
          'Garden Offline',
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
        itemCount: offlineGardenList.length,
        itemBuilder: (context, index) {
          var gardenData = offlineGardenList[index];
          return ListTile(
            title: Text('Penyadap Id: ${gardenData['penyadapId']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
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
                                          onPressed: () async {
                                            // TODO upload
                                            try {
                                              print(gardenData);
                                              uploadData(gardenData).then(
                                                  (value) => refreshData());
                                              // delete
                                              offlineGardenBox
                                                  .delete(gardenData['uid']);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        GardenControlPage(),
                                                  ));
                                            } catch (e) {
                                              // TODO
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
                                          },
                                          child: const Text('Ya'),
                                        ),
                                        TextButton(
                                            onPressed: () {
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
                    },
                    icon: Icon(Icons.cloud_upload)),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: IntrinsicHeight(
                            child: Column(
                              children: [
                                Text('Apakah anda yakin ingin hapus?'),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          //delete
                                          offlineGardenBox
                                              .delete(gardenData['uid'])
                                              .then((value) => refreshData());
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ya')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Tidak'))
                                  ],
                                ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: Color(0xFFEC5353),
                ),
              ],
            ),
          );
        });
  }
}
