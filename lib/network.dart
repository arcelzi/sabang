import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String api = 'http:192.168.102.137:3001';
  var token;

  getToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token').toString())['token'];
  }
  auth(data, apiUrl) async {
    var fullUrl = api + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: setHeader(),
    );
  }

  getData(apiUrl) async {
    var fullUrl = api + apiUrl;
    await getToken();
    return await http.get(Uri.parse(fullUrl),
    headers: setHeader(),
    );
  }

  setHeader() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
}