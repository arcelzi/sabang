import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sabang/menu/addgardencontrol.dart';
import 'package:sabang/models/checklits.dart';
import 'package:sabang/models/kuisoner.dart';
import 'package:sabang/models/users.dart';
import 'package:sabang/pages/garden_offline.dart';
import 'package:sabang/pages/purchases_offline.dart';

import 'package:sabang/splash.dart';
import 'package:sabang/utils/local_storage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';


import 'network.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('gardenControl');
  await initializeDateFormatting('id_ID', null);
  await Hive.initFlutter();
  Hive.registerAdapter(KuisionerAdapter());
  Hive.registerAdapter(CheckAdapter());
  Hive.registerAdapter(UsersAdapter());
  await Hive.openBox<Users>('users');
  await Hive.openBox<Kuisioner>('kuisoner');
  await Hive.openBox<Check>('checkBox');
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
      routes: {
        '/dataOffline': (context) => const PurchaseOffline(),
        '/tambahData': (context) => const AddGarden(),
        '/offlineGarden': (context) => const GardenOffline()
      },
    );
  }
}
