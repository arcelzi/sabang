// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabang/models/garden_control.dart';
import 'package:sabang/widgets/toast.dart';
// import 'package:sabang/pages/gardencontrol_page.dart';
// import 'package:sabang/services/http.dart' as http_service;

// import '../services/common/api_endpoints.dart';

// class Items {
//   GardenControl items;

//   Items({required this.items});
// }

class DetailGarden extends StatefulWidget {
  final GardenControl garden;
  final String imageUrl;

  DetailGarden({required this.garden, required this.imageUrl});

  @override
  State<DetailGarden> createState() => _DetailGardenState();
}

class _DetailGardenState extends State<DetailGarden> {
  late GardenControl _garden;
  late String imageUrl;
  final List<GardenControl> gardenControl = [];
  final List<GardenControlItems> itemGarden = [];

  // Future<void> getDetail() async {
  //   try {
  //     final response = await http_service.get(getGardenControl());
  //     if (response.isSuccess) {
  //       print(response.data);
  //       for (var item in response.data) {
  //         print(item);
  //         gardenControl.add(GardenControl.fromJson(item));
  //       }
  //       setState(() {});
  //     }
  //   } on SocketException {
  //     throw Exception('No internet');
  //   } catch (e) {
  //     print(e);
  //     throw Exception('Error mengambil data');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _garden = widget.garden;
    imageUrl = widget.imageUrl;
    // getDetail();
  }

  // Future<void> _refresh() async {
  //   await Future.delayed(Duration(seconds: 2));

  //   setState(() {});
  // }
  void _showImageDialog(String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Tutup dialog saat gambar ditekan
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain, // Untuk menampilkan gambar dengan ukuran aslinya
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
            'Detail',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_garden.items.isNotEmpty) Text('Item Details : '),
                for (GardenControlItems detail in _garden.items)
                  ListTile(
                      title: Text(
                        '${detail.title}',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      subtitle: detail.type == 'check'
                          ? Text(detail.value == 'true' ? 'Ya' : 'Tidak',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade800))
                          : detail.type == 'text'
                              ? Text('${detail.value}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade800))
                              : GestureDetector(
                                onTap: (){
                                  if(detail.value != null) {
                                  _showImageDialog(detail.value!);
                                  } else {
                                    CustomToast.show(context, 'Error', isSuccess: false);
                                  }
                                },
                                child: Container(
                                  width: screenWidth * 0.3 ,
                                  height: screenHeight * 0.2 ,
                                  child: Image.network(
                                      '${detail.value ?? ''}',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                ),
                              ))
              ],
            ),
          ),
        ));
  }
}
