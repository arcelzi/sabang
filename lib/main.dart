import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:sabang/splash.dart';
import 'package:sabang/utils/local_storage.dart';


import 'network.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await LocalStorage.init(); 
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => AppState()))
  ],  
  child: MyApp(token: LocalStorage.getToken()),
  ));
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

    void initial() {
      Provider.of<AppState>(context, listen: false).init();
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
