import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  static String routeName = 'Dashboard';
  final String FontPoppins = 'FontPoppins';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Dashboard',
                    style: TextStyle(
                        fontFamily: FontPoppins,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/people.png'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 66),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 50, top: 20, right: 75.82,),

                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 107,
                  width: 336,
                  decoration: BoxDecoration(
                      color: Color(0xFF00BBD8),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '10 Liter',
                            style: TextStyle(
                                fontFamily: FontPoppins,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '100 KG',
                            style: TextStyle(
                                fontFamily: FontPoppins,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text(
                            "Nira Hari ini",
                            style: TextStyle(
                                fontFamily: FontPoppins,
                                fontSize: 14,
                                color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
