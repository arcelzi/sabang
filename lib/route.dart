import 'package:sabang/dashboard.dart';
import 'package:sabang/splash.dart';
import 'package:sabang/login.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  Login.routeName: (context) => Login(),
  Dashboard.routeName:(context) => Dashboard(),
};
