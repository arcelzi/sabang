import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HTTPResponseStatus { success, failed, timeout, error, noInternet }

class HTTPResponse<T> {
  HTTPResponse({
    required this.status,
    this.data,
    this.statusCode,
    this.additionalData,
    this.userMessage,
    this.errorCode
  });

  final HTTPResponseStatus status;
  final T? data;
  final int? statusCode;
  final dynamic additionalData;
  final String? userMessage;
  final String? errorCode;

  get isSuccess => status == HTTPResponseStatus.success;
}

// class ConnectivityWrapper {
//   ConnectivityWrapper(this.onReceivedCallback) : super();

//   final Function(ConnectivityResult) onReceivedCallback;

//   final Connectivity _connectivity = Connectivity();
//   // ignore: unused_field
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;

//   void listen() {
//     _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   Future<void> initConnectivity() async {
//     var result = ConnectivityResult.none;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       log(e.toString());
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     // if (!mounted) {
//     //   return Future.value(null);
//     // }

//     return _updateConnectionStatus(result);
//   }

//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     switch (result) {
//       case ConnectivityResult.wifi:
//       case ConnectivityResult.mobile:
//       case ConnectivityResult.none:
//         onReceivedCallback(result);
//         break;
//       default:
//         onReceivedCallback(result);
//         break;
//     }
//   }

// }

// class HttpService {

get token async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  // Box userBox = await Hive.openBox('user');
  // String token = userBox.get('authToken') ?? '';
  // log(token);
  return 'Bearer $token';
}

Future<HTTPResponse> get(url, {Duration timeoutDuration = const Duration(seconds: 20)}) async {
  try {
    // var connectivity = ConnectivityResult.none;
    // var monde = ConnectivityWrapper((e) => connectivity = e);
    // await monde.initConnectivity();
    // monde.listen();

    // log(connectivity.toString());
    // if (connectivity == ConnectivityResult.none) {
    //   log('$connectivity, no Internet, trying in 10 seconds');
    //   await Future.delayed(const Duration(seconds: 10));
    //   if (connectivity == ConnectivityResult.none) {
    //     log('$connectivity, second try still no internet');
    //     return HTTPResponse(
    //       status: HTTPResponseStatus.noInternet,
    //       userMessage: 'Anda tidak terhubung ke Internet'
    //     );
    //   }
    // }
    // log('$connectivity, finally have internet');
    final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : await token
        }
    ).timeout(timeoutDuration);

    return responseCheck(response);
  } on TimeoutException catch(e) {
    log(e.toString());
    return HTTPResponse(
      status: HTTPResponseStatus.timeout,
      userMessage: 'Timeout, Coba periksa koneksi anda'
    );
  } on Exception catch(e) {
    log(e.toString());
    return HTTPResponse(
      status: HTTPResponseStatus.error,
      userMessage: 'Terjadi kesalahan'
    );
  }
}

Future<HTTPResponse> post(url, {Object? body, Duration timeoutDuration = const Duration(seconds: 20)}) async {
  try {
    // var connectivity = ConnectivityResult.none;
    // var monde = ConnectivityWrapper((e) => connectivity = e);
    // await monde.initConnectivity();
    // monde.listen();

    // log(connectivity.toString());
    // if (connectivity == ConnectivityResult.none) {
    //   log('$connectivity, no Internet, trying in 10 seconds');
    //   await Future.delayed(const Duration(seconds: 10));
    //   if (connectivity == ConnectivityResult.none) {
    //     log('$connectivity, second try still no internet');
    //     return HTTPResponse(
    //       status: HTTPResponseStatus.noInternet,
    //       userMessage: 'Anda tidak terhubung ke Internet'
    //     );
    //   }
    // }
    // log('$connectivity, finally have internet');
    final response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : await token
        },
        body: json.encode(body)
    ).timeout(timeoutDuration);

    return responseCheck(response);
  } on TimeoutException catch(e) {
    log(e.toString());
    return HTTPResponse(
      status: HTTPResponseStatus.timeout, 
      userMessage: 'Timeout, Coba periksa koneksi anda'
    );
  } on Exception catch(e) {
    log(e.toString());
    return HTTPResponse(
      status: HTTPResponseStatus.error,
      userMessage: 'Terjadi kesalahan'
    );
  }
}

Future<HTTPResponse> put(url, {Object? body, Duration timeoutDuration = const Duration(seconds: 20)}) async {
  try {
    // var connectivity = ConnectivityResult.none;
    // var monde = ConnectivityWrapper((e) => connectivity = e);
    // await monde.initConnectivity();
    // monde.listen();

    // log(connectivity.toString());
    // if (connectivity == ConnectivityResult.none) {
    //   log('$connectivity, no Internet, trying in 10 seconds');
    //   await Future.delayed(const Duration(seconds: 10));
    //   if (connectivity == ConnectivityResult.none) {
    //     log('$connectivity, second try still no internet');
    //     return HTTPResponse(
    //       status: HTTPResponseStatus.noInternet,
    //       userMessage: 'Anda tidak terhubung ke Internet'
    //     );
    //   }
    // }
    // log('$connectivity, finally have internet');
    final response = await http.put(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : await token
        },
        body: json.encode(body)
    ).timeout(timeoutDuration);

    return responseCheck(response);
  } on TimeoutException catch(e) {
    log(e.toString());
    return HTTPResponse(
      status: HTTPResponseStatus.timeout,
      userMessage: 'Timeout, Coba periksa koneksi anda'  
    );
  } on Exception catch(e) {
    log(e.toString());
    return HTTPResponse(
      status: HTTPResponseStatus.error,
      userMessage: 'Terjadi kesalahan'
    );
  }
}

Future<HTTPResponse> patch(url, {Object? body, Duration timeoutDuration = const Duration(seconds: 20)}) async {
  try {
    // var connectivity = ConnectivityResult.none;
    // var monde = ConnectivityWrapper((e) => connectivity = e);
    // await monde.initConnectivity();
    // monde.listen();

    // log(connectivity.toString());
    // if (connectivity == ConnectivityResult.none) {
    //   log('$connectivity, no Internet, trying in 10 seconds');
    //   await Future.delayed(const Duration(seconds: 10));
    //   if (connectivity == ConnectivityResult.none) {
    //     log('$connectivity, second try still no internet');
    //     return HTTPResponse(
    //       status: HTTPResponseStatus.noInternet,
    //       userMessage: 'Anda tidak terhubung ke Internet'
    //     );
    //   }
    // }
    // log('$connectivity, finally have internet');
    final response = await http.patch(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : await token
        },
        body: json.encode(body)
    ).timeout(timeoutDuration);

    return responseCheck(response);
  } on TimeoutException catch(e) {
    log(e.toString());
    return HTTPResponse(
      status: HTTPResponseStatus.timeout,
      userMessage: 'Timeout, Coba periksa koneksi anda'  
    );
  } on Exception catch(e) {
    log(e.toString());
    return HTTPResponse(
      status: HTTPResponseStatus.error,
      userMessage: 'Terjadi kesalahan'
    );
  }
}

Future<HTTPResponse> delete(url, {Object? body, Duration timeoutDuration = const Duration(seconds: 20)}) async {
  try {
    // var connectivity = ConnectivityResult.none;
    // var monde = ConnectivityWrapper((e) => connectivity = e);
    // await monde.initConnectivity();
    // monde.listen();

    // log(connectivity.toString());
    // if (connectivity == ConnectivityResult.none) {
    //   log('$connectivity, no Internet, trying in 10 seconds');
    //   await Future.delayed(const Duration(seconds: 10));
    //   if (connectivity == ConnectivityResult.none) {
    //     log('$connectivity, second try still no internet');
    //     return HTTPResponse(
    //       status: HTTPResponseStatus.noInternet,
    //       userMessage: 'Anda tidak terhubung ke Internet'
    //     );
    //   }
    // }
    // log('$connectivity, finally have internet');
    final response = await http.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : await token
        },
        body: json.encode(body)
    ).timeout(timeoutDuration);

    return responseCheck(response);
  } on TimeoutException catch(e) {
    log(e.toString());
    return HTTPResponse(status: HTTPResponseStatus.timeout);
  } on Exception catch(e) {
    log(e.toString());
    return HTTPResponse(status: HTTPResponseStatus.error);
  }
}

HTTPResponse responseCheck(Response response) {
  log(response.body);
  var result = jsonDecode(response.body);
    if ([200, 201].contains(response.statusCode)) {
      // if (result['isSuccess']) {
        return HTTPResponse(
            status: HTTPResponseStatus.success,
            statusCode: response.statusCode,
            data: result, // TODO result['data'],
            userMessage: 'ok', // result['userMessage'] ?? result['message'] ??  'Berhasil'
        );
      // } else {
      //   return HTTPResponse(status: HTTPResponseStatus.failed,
      //       statusCode: result['data']['status'] ?? 500,
      //       data: result['data'],
      //       additionalData: result,
      //       userMessage: result['userMessage'] ?? result['message'] ??  'Terjadi kesalahan pada server'
      //   );
      // }
    } else {
      return HTTPResponse(
          status: HTTPResponseStatus.error,
          statusCode: response.statusCode,
          errorCode: result['errorCode'],
          data: result['data'],
          userMessage: result['userMessage'] ?? result['message'] ??  'Terjadi kesalahan pada server'
      );
    }
}