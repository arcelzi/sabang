import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

  final String FontPoppins = 'FontPoppins';
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
            margin: EdgeInsets.only(top: 66),
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
              padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
              child: Column(
                children: [
                  LayoutBuilder(builder: (context, constraint) {
                    return Wrap(
                      spacing: 20,
                      runSpacing: 27,
                      children: List.generate(6, (index) {
                        return Container(
                          height: 129.0,
                          width: 159.0,
                          decoration: BoxDecoration(
                              color: Color(0xFF9EEDE6),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.box,
                                size: 35,
                              ),
                              SizedBox(height: 17,),
                              Text(
                                "BOX",
                                style: TextStyle(
                                    fontFamily: FontPoppins,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
