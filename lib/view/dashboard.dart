import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabang/pages/gardencontrol_page.dart';
import 'package:sabang/pages/purchase_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabang/menu/profile/profile.dart';
import 'package:sabang/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  String token = LocalStorage.getToken();
  final String FontPoppins = 'FontPoppins';
    List menuList = [
    {
      "icon": FontAwesomeIcons.cartShopping,
      "title": "Purchases",
      "color": Color(0xFF78937A)
    },
    {
      "icon": FontAwesomeIcons.seedling,
      "title": "Garden Control",
      "color": Color(0xFF78937A)
    },
    // {
    //   "icon": FontAwesomeIcons.cartShopping,
    //   "title": "Purchase",
    //   "color": Color(0xFF78937A)
    // },
  ];
  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
    token = pref.getString("dashboard")??"";
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PurchasePage()));
                              if (index == 1)
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => GardenControlPage())));
                              // if (index == 2)
                              // Navigator.push(context, MaterialPageRoute(builder: ((context) => PurchasePage())));
                            },
                            child: Container(
                              height: 129.0,
                              width: 338.0,
                              decoration: BoxDecoration(
                                  color: item["color"],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    item["icon"],
                                    size: 60,
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
      ),
    );
  }
}

