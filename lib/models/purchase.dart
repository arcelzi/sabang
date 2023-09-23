import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabang/menu/addpurchase.dart';
import '../menu/list/listpurchase.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final String FontPoppins = 'FontPoppins';
  final List<Purchases> purchases = [];
  
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
                icon: Icon(
                  FontAwesomeIcons.cartPlus,
                  color: Colors.black,
                  size: 25,
                ),
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
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF78937A),
                    borderRadius: BorderRadius.circular(15)),
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
                          Text(
                            pu.tappers,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'PH : ' + pu.ph.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Brix : ' + pu.brix.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Volume : ' + pu.volume.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Harga : Rp.' + pu.harga.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            pu.date.toString(),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }
}
