import 'package:get/get.dart';

import '../../../API_Model/password_recover_email_o_t_p_model.dart';
import '../../../API_Model/user_model.dart';
import '../../Path_Directory/path_directory_page.dart';
import '../Auth_Controller/auth_controller.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class OTPController extends GetxController{
  final bool _getInProgress=false;
  bool get inProgress=>_getInProgress;
  String? _errorMsg;
  String? get errorMsg=>_errorMsg;

  Future<bool> otpApiCallMethod(String otp) async {
    bool isSuccess=false;
    _getInProgress==true;
    update();
    String tempOTP =otp;
    final NetworkResponse response = await NetworkCall.getRequest(
        url: PathDirectoryUrls.recoverEmailOTPUrl(
            "${AuthController.userModel?.email}", tempOTP));
    if (response.isSuccess) {
      isSuccess=true;
      update();
      PasswordRecoverEmailOTPModel passwordRecoverEmailOTPModel = PasswordRecoverEmailOTPModel.fromJson(response.responseData);
      UserModel? userModel = AuthController.userModel;
      update();
      if(userModel != null && passwordRecoverEmailOTPModel.status == "success"){
        userModel.otp = tempOTP;
        await AuthController.setUserData(AuthController.accessKey ?? "", userModel);
      }
      _errorMsg==null;
    }
   _getInProgress==false;
    update();
    return isSuccess;
  }
}