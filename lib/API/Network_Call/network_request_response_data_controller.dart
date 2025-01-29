import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as h;
import 'package:rest_api02/API/Data%20Controller/Auth_Controller/auth_controller.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String? errorMessage;

  NetworkResponse(
      {required this.statusCode,
      this.responseData,
      required this.isSuccess,
      this.errorMessage});
}

class NetworkCall {

  //get request
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL=>$url');
      h.Response response = await h.get(
          uri,
          headers: {
            'token': AuthController.accessToken??''
          }
      );

       debugPrint('Response Code=>${response.statusCode}');
      debugPrint('Response Data=>${response.body}');

      if (response.statusCode == 200) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: responseDecode);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  ///post Request
  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL=>$url');
      debugPrint('Body=>${jsonEncode(body)}');
      h.Response response = await h.post(uri,
          headers: {
        "Content-Type": "application/json",
            'token': AuthController.accessToken??''
          },
          body: jsonEncode(body),

      );
      debugPrint('Response Code=>${response.statusCode}');
      debugPrint(' ${AuthController.accessToken}');
      debugPrint("${response.statusCode}");
      if (response.statusCode == 200) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: responseDecode);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }
}
