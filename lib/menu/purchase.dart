import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabang/menu/addpurchase.dart';
import '../menu/list/listpurchase.dart';

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  final String FontPoppins = 'FontPoppins';
  final List<Purchases> purchases = [
    Purchases(
        id: 1,
        tappers: 'Sabang',
        ph: 2,
        brix: 3,
        volume: 5,
        harga: 3000,
        date: DateTime.now())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6FB),
        appBar: AppBar(
          actions: [
            Container(
              width: 80,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => AddPurchase())));
                },
                icon: Icon(FontAwesomeIcons.cartPlus, color: Colors.black, size: 25, ),
                tooltip: "Add Purchase",
                
              ),
            )
          ],
          title: Text(
            "Purchase",
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
        ),
        body: ListView(
          children: purchases.map((pu) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pu.tappers),
                        Text('PH : ' + pu.ph.toString()),
                        Text('Brix : ' + pu.brix.toString()),
                        Text('Volume : ' + pu.volume.toString()),
                        Text('Harga : Rp.' + pu.harga.toString()),
                        Text(pu.date.toString())
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ));
  }
}
