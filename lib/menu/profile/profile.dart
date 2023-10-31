

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabang/login.dart';
import 'package:sabang/menu/profile/editprofile.dart';
import 'package:sabang/services/auth_service.dart';
import 'package:sabang/utils/local_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';



class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String token = LocalStorage.getToken();
  String name = LocalStorage.getName();
  String avatar = LocalStorage.getAvatar();
  String? imageBase64;
  late Uint8List imageBytes;

  initial() {
    if (token.contains('login:')) return;
    getUpdate();
  }
  
  getUpdate() async {
    var response = await AuthService.getProfile();
    if(response.isSuccess) {
      setState(() {
        LocalStorage.setAvatar(response.data['avatar']);
        avatar = LocalStorage.getAvatar();
      });
    }
  }

  
  @override
  void setState(VoidCallback fn){
    if(mounted) super.setState(fn);
  }
  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
    token = pref.getString("login")??"";
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6FB),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(FontAwesomeIcons.angleLeft),
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Profile",
            style: GoogleFonts.sourceSansPro(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 72,
                        backgroundImage: NetworkImage(avatar),
                        backgroundColor: Color(0xFFF5F6FB),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Color(0xFFF5F6FB),
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenu(
                  title: "Pengaturan",
                  icon: FontAwesomeIcons.gear,
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => EditProfile())));
                  },
                ),
                ProfileMenu(
                    title: "Logout",
                    icon: FontAwesomeIcons.rightFromBracket,
                    textColor: Colors.redAccent,
                    endIcon: false,
                    onPress: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                content: Row(
                              children: [
                                Text("Are you Sure?"),
                                TextButton(
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      await pref.clear();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => Login(),
                                          ),
                                          (route) => false);
                                    },
                                    child: const Text("Yes")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"))
                              ],
                            ));
                          });
                    })
              ],
            ),
          ),
        ));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xFF78937A),
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.white,
        ),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: const Icon(
                FontAwesomeIcons.angleRight,
                size: 18,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
