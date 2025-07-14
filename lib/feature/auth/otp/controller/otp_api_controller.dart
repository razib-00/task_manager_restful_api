import 'package:get/get.dart';

import '../../../../API_Model/password_recover_email_o_t_p_model.dart';
import '../../../../API_Model/user_model.dart';
import '../../../../Style/text_message_style.dart';
import '../../../../core/local data/auth_controller.dart';
import '../../../../core/network path/path_directory_page.dart';
import '../../../../core/network/network_request_response_data_controller.dart';
import '../../text controller/auth_text_controller.dart';

class OTPApiController extends GetxController{
   bool _isButtonVisible=false;
   bool get isButtonVisible=>_isButtonVisible;

  final AuthTextController authTextController=Get.put(AuthTextController());
  Future<void> otpApiCallMethod() async {
    _isButtonVisible==true;
    update();
    String tempOTP = authTextController.otpController.text;
    //AuthController.userModel?.otp
    final NetworkResponse response = await NetworkCall.getRequest(
        url: PathDirectoryUrls.recoverEmailOTPUrl(
            "${AuthController.userModel?.email}", tempOTP));
    if (response.isSuccess) {
      PasswordRecoverEmailOTPModel passwordRecoverEmailOTPModel = PasswordRecoverEmailOTPModel.fromJson(response.responseData);
      UserModel? userModel = AuthController.userModel;
      if(userModel != null && passwordRecoverEmailOTPModel.status == "success"){
        userModel.otp = tempOTP;
        await AuthController.setUserData(AuthController.accessKey ?? "", userModel);
      }
      successToast("OTP update successfully");
    } else {
      errorToast("OTP update failed");
    }
    _isButtonVisible==false;
    update();
  }

}