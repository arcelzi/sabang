import 'package:sabang/services/http.dart';
import 'http.dart' as http_service;
import 'common/api_endpoints.dart';

class AuthService {
  static Future<HTTPResponse> loginAsUser({required String name, required String password}) async {
    return http_service.post(
      loginUrl(),
      body: {
        'username' : name,
        'password' : password
      },
      timeoutDuration: const Duration(seconds: 10)
      );
  }
  static Future<HTTPResponse> changeProfilePicture({required String base64}) {
    return http_service.put(
      changeProfilePictureUrl(),
      body: {
        'imageBytes': base64
      },
      timeoutDuration: const Duration(seconds: 60)
    );
  }

  static Future<HTTPResponse> getProfile(){
    return http_service.get(
      getProfileUrl(),
      timeoutDuration: const Duration(seconds: 10)
    );
  }

  static Future<HTTPResponse> changeProfile({required String name,required String email, required int phone }){
    return http_service.put(
      changeProfileUrl(),
      body: {
        'name': name,
        'email': email,
        'phone': phone
      }
    );
  }

  static Future<HTTPResponse> logout(){
    return http_service.delete(
      logoutUrl(),
      body: {},
      timeoutDuration: const Duration(seconds: 10)
    );
  }
}

  