import 'package:get/get.dart';
import '../../../../Style/text_message_style.dart';
import '../../../../core/network path/path_directory_page.dart';
import '../../../../core/network/network_request_response_data_controller.dart';
import '../../login/screen/login_screen.dart';
import '../../text controller/auth_text_controller.dart';

class SignUpApiController extends GetxController {
  bool _isVisibility = false;
  bool get isVisibility => _isVisibility;

  bool _isButtonVisibility = false;
  bool get isButtonVisibility => _isButtonVisibility;

  final AuthTextController authTextController = Get.put(AuthTextController());

  void toggleVisibility() {
    _isVisibility = !_isVisibility;
    update();
  }

  Future<void> postRegistration() async {
    _isButtonVisibility = true;
    update();

    Map<String, dynamic> registrationRequestBody = {
      "email": authTextController.emailController.text.trim(),
      "firstName": authTextController.firstNameController.text.trim(),
      "lastName": authTextController.lastNameController.text.trim(),
      "mobile": authTextController.phoneController.text.trim(),
      "password": authTextController.passwordController.text,
      "photo": "",
    };

    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.registrationUrl, body: registrationRequestBody);

    _isButtonVisibility = false;
    update();

    if (response.isSuccess) {
      _clearText();
      Get.toNamed(LoginScreen.name);
      successToast('Sign Up Successful');
    } else {
      errorToast("Sign Up Failed!");
    }
  }


  void _clearText() {
    authTextController.emailController.clear();
    authTextController.firstNameController.clear();
    authTextController.lastNameController.clear();
    authTextController.phoneController.clear();
    authTextController.passwordController.clear();
  }
}
