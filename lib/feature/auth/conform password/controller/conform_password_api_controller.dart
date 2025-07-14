import 'package:get/get.dart';
import '../../../../Style/text_message_style.dart';
import '../../../../core/network path/path_directory_page.dart';
import '../../../../core/network/network_request_response_data_controller.dart';
import '../../login/screen/login_screen.dart';
import '../../text controller/auth_text_controller.dart';
import '../../../../API_Model/recover_reset_pass.dart';
import '../../../../core/local data/auth_controller.dart';

class ConFormPasswordApiController extends GetxController {
  bool _isVisibilityPassword = false;
  bool get isVisibilityPassword => _isVisibilityPassword;

  bool _isVisibilityConfirmPassword = false;
  bool get isVisibilityConfirmPassword => _isVisibilityConfirmPassword;

  bool _isButtonVisibility = false;
  bool get isButtonVisibility => _isButtonVisibility;

  final AuthTextController authTextController = Get.put(AuthTextController());

  /// Toggle methods
  void togglePasswordVisibility() {
    _isVisibilityPassword = !_isVisibilityPassword;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    _isVisibilityConfirmPassword = !_isVisibilityConfirmPassword;
    update();
  }

  Future<void> confirmPasswordApiCallMethod() async {
    _isButtonVisibility = true;
    update();

    Map<String, dynamic> responseBody = {
      "email": AuthController.userModel?.email ?? '',
      "OTP": AuthController.userModel?.otp ?? '',
      "password": authTextController.confirmPasswordController.text
    };

    final NetworkResponse response = await NetworkCall.postRequest(
      url: PathDirectoryUrls.recoverResetPasswordUrl,
      body: responseBody,
    );

    _isButtonVisibility = false;
    update();

    if (response.isSuccess) {
      try {
        RecoverResetPass.fromJson(response.responseData!["data"]);
        _clearData();
        successToast('Password is updated!');
        Get.offAllNamed(LoginScreen.name);
      } catch (e) {
        errorToast(e.toString());
      }
    } else {
      errorToast('Password update failed!');
    }
  }

  void _clearData() {
    authTextController.passwordController.clear();
    authTextController.confirmPasswordController.clear();
  }
}
