import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabang/login.dart';
import 'package:sabang/menu/profile/updateprofile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool circular = true;
  @override
  void initState() {
    super.initState();

    fecthData();
  }
  void fecthData() async {

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
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset('assets/images/people.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xFFE0ADA2)),
                        child: const Icon(
                          FontAwesomeIcons.pencil,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sabang",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text("sabang"),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => UpdateProfile())));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE0ADA2),
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: Text(
                        "Edit Profile",
                      )),
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
                  title: "Settings",
                  icon: FontAwesomeIcons.gear,
                  onPress: () {},
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
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => Login())), (route) => false);
                                    }, child: const Text("Yes")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, child: const Text("No"))
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
