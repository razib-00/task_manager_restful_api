import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' ;
import 'package:rest_api02/Screen/User_LogIn_Registration_LogOut/login_screen.dart';


import '../../Style/text_message_style.dart';

class ErrorPage {

   static void throwError(Response response,BuildContext context) {
    switch (response.statusCode) {
      case 400:
        errorToast('Bad Request: ${response.body} \n${response.statusCode}');
        break;
      case 401:
        errorToast('Unauthorized: ${Navigator.pushNamedAndRemoveUntil(context, LoginScreen.name, (predicate)=>false)}');
        break;
      case 404:
        errorToast('Not Found: ${response.body} \n${response.statusCode}');
        break;
      case 500:
        errorToast('Server Error: ${response.body} \n${response.statusCode}');
        break;
      default:
        errorToast('Unknown Error: ${response.body}');
    }
  }
}
