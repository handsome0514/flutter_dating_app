import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static const String BASE_URL =
      "https://us-central1-ever-love.cloudfunctions.net/"
      "";

  // static const String SECURE = "SecUser";

  static final NetworkUtil _instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = const JsonDecoder();

  Future<dynamic> get(String url,
      {Map<String, String>? headers, encoding, String? baseURL}) async {
    String rawUrl = (baseURL ?? (BASE_URL + url));

    log("get request url: $rawUrl");
    headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      /*HttpHeaders.authorizationHeader*/
      // "Authorization": "Bearer ${token}",
      "Authorization": "Bearer ",
      'Accept': 'application/json',
    };
    log(headers.toString());

    return http
        .get(Uri.parse(rawUrl), headers: headers)
        .then((http.Response response) {
      String res = response.body;
      log(res);
      // int statusCode = response.statusCode;
      return _responseHandler(response);
    }).onError((error, stackTrace) {
      log("Error: $error");
      return {"status": 500, "message": error.toString()};
    });
  }

  Future<dynamic> post(String url,
      {Map<String, String>? headers, body, encoding, String? baseURL}) {
    String rawUrl =
        (baseURL ?? (BASE_URL + url)).replaceAll("/user/", "/SecUser/");

    log("post request url: $rawUrl");
    log(body);
    /*  headers = {
      "Authorization": token,
    };*/
    headers = {
      //    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      /*HttpHeaders.authorizationHeader*/

      // "Authorization": "Bearer ${token}",

      "Authorization": "Bearer ",
    };
    log('header-> $headers');
    return http
        .post(Uri.parse(rawUrl),
            body: body, encoding: encoding, headers: headers)
        .then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      log("Status code: $statusCode ");
      log(" API Response: $res");

      /* if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" +
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception(statusCode);
      return _decoder.convert(res);
    });
  }  }*/
      // log(res);
      return _responseHandler(response);
    }).onError((error, stackTrace) {
      log("Error: $error");
      return {"status": 500, "message": error.toString()};
    });
  }

  _responseHandler(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 400:
      case 401:
      case 403:
      case 405:
        return _decoder.convert(response.body);
      /*  case 400:
        return {"status": response.statusCode, "message": "Bad request!"};
      case 401:
      case 403:
        return {"status": response.statusCode, "message": "Unauthorized!"};*/
      case 500:
      default:
        return {"status": response.statusCode, "message": "Server error!"};
    }
  }

  Future<bool> isValid(String number) async {
    var response = await NetworkUtil()
        .post("user/contactvalidator", body: {"contact_no": number});
    log(response["status"]);
    return response["status"] == 200;
  }
}
