import 'package:get/get.dart';

import '../../../API_Model/user_model.dart';
import '../../Path_Directory/path_directory_page.dart';
import '../../error_screen/error_page.dart';
import '../Auth_Controller/auth_controller.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class LoginController extends GetxController{
  final bool _getInProgress=false;
  bool get inProgress=>_getInProgress;

  String? _errorMsg;
  String? get errorMsg=>_errorMsg;

  Future<bool> loginPostRequester(String email,String password) async {
    bool isSuccess=false;
    _getInProgress == true;
    update();

    Map<String, dynamic> loginResponseBody = {
      "email": email,
      "password": password
    };
    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.loginUrl, body: loginResponseBody);

    if (response.isSuccess) {

      String token=response.responseData!["token"];
      UserModel userModel=UserModel.fromJson(response.responseData!["data"]);
      await AuthController.setUserData(token,userModel);
      isSuccess=true;
      _errorMsg=null;
      update();
    } else {
      ErrorPage.throwError;
    }
    _getInProgress == false;
    update();
    return isSuccess;
  }
}