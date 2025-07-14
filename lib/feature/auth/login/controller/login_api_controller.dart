import 'package:get/get.dart';
import '../../../../API_Model/user_model.dart';
import '../../../../Style/text_message_style.dart';
import '../../../../core/local data/auth_controller.dart';
import '../../../../core/network path/path_directory_page.dart';
import '../../../../core/network/network_request_response_data_controller.dart';
import '../../../UI/Bottom & Drawer/bottom_navigation_bar.dart';
import '../../text controller/auth_text_controller.dart';

class LoginApiController extends GetxController{
  bool _isVisibility = false;
  bool get isVisibility => _isVisibility;

   bool _isButtonVisibility = false;
   bool get isButtonVisibility=>_isButtonVisibility;
  AuthTextController authTextController=Get.put(AuthTextController());
  Future<void> loginPostRequester() async {
    _isButtonVisibility == true;
    update();

    Map<String, dynamic> loginResponseBody = {
      "email": authTextController.emailController.text.trim(),
      "password": authTextController.passwordController.text
    };
    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.loginUrl, body: loginResponseBody);

    if (response.isSuccess) {

      String token=response.responseData!["token"];
      UserModel userModel=UserModel.fromJson(response.responseData!["data"]);
      await AuthController.setUserData(token,userModel);

      Get.offAllNamed(BottomNavigationBarScreen.name);
      successToast('Login successful');
    } else {
      _isButtonVisibility ==false;
      update();
      errorToast("login fail!");
    }
  }
  void toggleVisibility() {
    _isVisibility = !_isVisibility;
    update(); // notify GetBuilder or Obx widgets
  }
}