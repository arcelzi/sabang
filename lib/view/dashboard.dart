import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabang/menu/addnira.dart';
import 'package:sabang/menu/gardencontrol.dart';
import 'package:sabang/menu/payment.dart';
import 'package:sabang/menu/production.dart';
import 'package:sabang/menu/purchase.dart';
import 'package:sabang/menu/tappers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabang/menu/profile/profile.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  _DashboardState createState() => _DashboardState();
  
}
class _DashboardState extends State<Dashboard>{
  final String FontPoppins = 'FontPoppins';
    List menuList = [
    {
      "icon": FontAwesomeIcons.box,
      "title": "Nira",
      "color": Color(0xFF78937A)
    },
    {
      "icon": FontAwesomeIcons.wallet,
      "title": "Payment",
      "color": Color(0xFF78937A)
    },
    {
      "icon": FontAwesomeIcons.boxOpen,
      "title": "Production",
      "color": Color(0xFF78937A)
    },
    {
      "icon": FontAwesomeIcons.users,
      "title": "Tappers",
      "color": Color(0xFF78937A)
    },
    {
      "icon": FontAwesomeIcons.seedling,
      "title": "Garden Control",
      "color": Color(0xFF78937A)
    },
    {
      "icon": FontAwesomeIcons.cartShopping,
      "title": "Purchase",
      "color": Color(0xFF78937A)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 55,
          ),
          Padding(
            padding: EdgeInsets.only(left: 26, right: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dashboard",
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Color(0xFFE0ADA2),
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.user, color: Colors.white,),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: ((context) => Profile())));
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 107,
                  width: 336,
                  decoration: BoxDecoration(
                      color: Color(0xFF78937A),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 50, top: 20),
                        child: Column(
                          children: [
                            Text(
                              '10 Liter',
                              style:GoogleFonts.sourceSansPro(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Nira Hari ini',
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 75.82, top: 20),
                        child: Column(
                          children: [
                            Text(
                              "100KG",
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Production',
                              style: GoogleFonts.sourceSansPro(
                                 fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 55, left: 20, right: 20),
              child: Column(
                children: [
                  LayoutBuilder(builder: (context, constraint) {
                    return Wrap(
                      spacing: 20,
                      runSpacing: 27,
                      children: List.generate(menuList.length, (index) {
                        var item = menuList[index];
                        return InkWell(
                          onTap: (){
                            if (index == 0) 
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNira()));
                            if (index == 1)
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => Payment())));
                            if (index == 2)
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => Production())));
                            if (index == 3)
                            Navigator.push(context,MaterialPageRoute(builder: ((context) => Tappers())));
                            if (index == 4)
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => Garden())));
                            if (index == 5)
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => Purchase())));
                          },
                          child: Container(
                            height: 129.0,
                            width: 159.0,
                            decoration: BoxDecoration(
                                color: item["color"],
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  item["icon"],
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 17,),
                                Text(
                                  item["title"],
                                  style: GoogleFonts.sourceSansPro(
                                    color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

