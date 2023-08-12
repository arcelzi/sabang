import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabang/menu/addnira.dart';
import 'package:sabang/menu/payment.dart';
import 'package:sabang/menu/production.dart';

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
      "title": "Add Nira",
      "color": Color(0xFF9EEDE6)
    },
    {
      "icon": FontAwesomeIcons.wallet,
      "title": "Payment",
      "color": Color(0xFFAFA3FA)
    },
    {
      "icon": FontAwesomeIcons.boxOpen,
      "title": "Production",
      "color": Color(0xFFFAE994)
    },
    {
      "icon": FontAwesomeIcons.users,
      "title": "Tappers",
      "color": Color(0xFFE7C3D0)
    },
    {
      "icon": FontAwesomeIcons.seedling,
      "title": "Garden Control",
      "color": Color(0xFFA5FC90)
    },
    {
      "icon": FontAwesomeIcons.cartShopping,
      "title": "Purchase",
      "color": Color(0xFFFDA37C)
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
                      style: TextStyle(
                          fontFamily: FontPoppins,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/people.png'),
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
                      color: Color(0xFF00BBD8),
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
                              style: TextStyle(
                                  fontFamily: FontPoppins,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Nira Hari ini',
                              style: TextStyle(
                                fontFamily: FontPoppins,
                                fontSize: 14,
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
                              style: TextStyle(
                                  fontFamily: FontPoppins,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Production',
                              style: TextStyle(
                                  fontFamily: FontPoppins, fontSize: 14),
                            )
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
                                  size: 35,
                                ),
                                SizedBox(height: 17,),
                                Text(
                                  item["title"],
                                  style: TextStyle(
                                      fontFamily: FontPoppins,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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