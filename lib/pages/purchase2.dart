// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:sabang/menu/addpurchase.dart';
// import 'package:sabang/models/purchases.dart';
// import 'package:http/http.dart' as http;

// class PurchasePage extends StatefulWidget {
//   const PurchasePage ({super.key});

//   @override
//   State<PurchasePage> createState() => _PurchasePageState();
// }

// class _PurchasePageState extends State<PurchasePage> {
//   final String FontPoppins = 'FontPoppins';
//  final List<Purchases> purchase = [];

//  Future<List<Purchases?>> getPurchase() async {
//   Uri api = Uri.parse("http://192.168.102.182:3001/purchases");
//   var response = await http.get(api);

//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     var result = json.decode(response.body);
//     for (var item in result) {
//       purchase.add(Purchases.fromJson(item));
//     }
//   }
//   setState(() {});
//   return purchase;
//  }
//  @override
//  void initState() {
//   getPurchase();
//   super.initState();
//  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xFFF5F6FB),
//         appBar: AppBar(
//           actions: [
//             Container(
//               width: 80,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: ((context) => AddPurchase())));
//                 },
//                 icon: Icon(
//                   FontAwesomeIcons.cartPlus,
//                   color: Colors.black,
//                   size: 25,
//                 ),
//                 tooltip: "Add Purchase",
//               ),
//             )
//           ],
//           title: Text(
//             "Purchase",
//             style: GoogleFonts.sourceSansPro(
//                 fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 FontAwesomeIcons.angleLeft,
//                 color: Colors.black,
//               )),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Column(
//             children: [
//               SizedBox(height: 10,),
//               Expanded(child: ListView.builder(
//                 itemBuilder: ((context, index) {
//                   return Card(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFF78937A),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(8),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "PH : " + purchase[index].ph.toString(),
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             Text(
//                               "Brix : " + purchase[index].sugarLevel.toString(),
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             Text("Volume : " + purchase[index].volume.toString(),
//                             style: TextStyle(color: Colors.white),
//                             ),
//                             Text("Harga : " + purchase[index].amount.toString(),
//                             style: TextStyle(color: Colors.white),
//                             ),
//                             Text(purchase[index].timestamp.toString(),
//                             style: TextStyle(color: Colors.white),)
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
                  
//                 }),
//                 itemCount: purchase.length,
//                 ))
//             ],
//           ),
//         ));
//   }
// }
