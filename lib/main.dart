import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sabang/services/auth_service.dart';
import 'package:sabang/splash.dart';
import 'package:sabang/utils/local_storage.dart';

import 'models/auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init(); 
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp(token: LocalStorage.getToken()));
}


class MyApp extends StatefulWidget {
  final String? token;
  const MyApp({super.key, required this.token});
  @override
  State<MyApp> createState() => _MyApp();
}
  class _MyApp extends State<MyApp> {
    String username = '';
    String password = '';
    @override
    void setState(VoidCallback fn) {
      if(mounted) super.setState(fn);
    }
    
    @override
    void initState() {
      super.initState();
    }

    loginAsUser() async {
      var result = await AuthService.loginAsUser(
        name: username, 
        password: password
      );
      if (result.isSuccess) {
        var user = Auth.fromJson(result.data);
        LocalStorage.setAvatar(user.avatar);
        LocalStorage.setToken(user.token);
        LocalStorage.setUserId(user.id as String);
        LocalStorage.setName(user.name as String);
      }
    }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SABANG',
      theme: ThemeData(fontFamily: 'FontPoppins'),
      home: Splash(),
    );
  }
}
