import 'package:sabang/services/http.dart';
import 'http.dart' as http_service;
import 'common/api_endpoints.dart';

class AuthService {
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

  static Future<HTTPResponse> changeProfile({required String name}){
    return http_service.put(
      changeProfileUrl(),
      body: {
        'fullName': name
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

  