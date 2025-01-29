import 'package:get/get.dart';

import '../../Path_Directory/path_directory_page.dart';
import '../../error_screen/error_page.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class SingUPController extends GetxController{
  bool _getInProgress=false;
  bool get inProgress=>_getInProgress;
  String? _errorMsg;
  String? get errorMsg=>_errorMsg;

  Future<bool> postRegistration(String email, String firstName, String lastName,
      String phone, String password) async {
    bool isSuccess = false;

    _getInProgress = true;
    update();

    Map<String, dynamic> registrationRequestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": phone,
      "password": password,
      "photo": "",
    };

    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.registrationUrl, body: registrationRequestBody);
    _getInProgress = false;
    update();

    if (response.isSuccess) {
      isSuccess = true;
      update();
    } else {
      ErrorPage.throwError;
    }
    return isSuccess;
  }
}