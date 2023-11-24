

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // User id
  static Future setUserId(String userId) async {
    await _preferences.setString('userId', userId);
  }

  static String? getUserId() {
    return _preferences.getString('userId');
  }

  // Token
  static Future setToken(String token) async {
    await _preferences.setString('token', token);
  }

  static String getToken() {
    return _preferences.getString('token') ?? '';
  }

  // Name
  static Future setName(String name) async {
    await _preferences.setString('name', name);
  }

  static String getName() { 
    return _preferences.getString('name') ?? '';
  }

  //Email
  static Future setEmail(String email) async {
    await _preferences.setString('email', email);
  }

  static String getEmail() {
    return _preferences.getString('email') ?? '';
  }


  //Phone
  static Future setPhone(String phone) async {
    await _preferences.setString('phone', phone);
  }

  static String getPhone(){
    return _preferences.getString('phone') ?? '';
  }

  // Avatar
  static Future setAvatar(String avatar) async {
    await _preferences.setString('avatar', avatar);
  }

  static String getAvatar(){
    return _preferences.getString('avatar') ?? 'https://cdn4.iconfinder.com/data/icons/political-elections/50/48-512.png';
  }



  // Clear Local Storage
  static Future clearPrefs() async {
    await _preferences.clear();
  }
}