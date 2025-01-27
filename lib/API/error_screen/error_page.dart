import 'package:http/http.dart' ;

import '../../Style/text_message_style.dart';

class ErrorPage {
  static void throwError(Response response) {
    switch (response.statusCode) {
      case 400:
        errorToast('Bad Request: ${response.body} \n${response.statusCode}');
        break;
      case 401:
        errorToast('Unauthorized: ${response.body} \n${response.statusCode}');
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
