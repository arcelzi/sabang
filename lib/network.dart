import 'package:flutter/material.dart';
import 'package:sabang/utils/local_storage.dart';

class AppState with ChangeNotifier {
bool isLoggedIn = false;

void init() {
  String token = LocalStorage.getToken();
  if (!token.contains('login:') && token.isNotEmpty) {
    isLoggedIn = true;
  }
}

void loggedOut() {
  isLoggedIn = false;
}

void loggedIn() {
  isLoggedIn = true;
}
}