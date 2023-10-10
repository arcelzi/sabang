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

  // Avatar
  static Future setAvatar(String avatar) async {
    await _preferences.setString('avatar', avatar);
  }

  static String getAvatar(){
    return _preferences.getString('avatar') ?? '';
  }



  // Clear Local Storage
  static Future clearPrefs() async {
    await _preferences.clear();
  }
}