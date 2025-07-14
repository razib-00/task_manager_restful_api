import 'package:get/get.dart';
import '../../../../API_Model/PasswordRecoverEmailModel.dart';
import '../../../../API_Model/user_model.dart';
import '../../../../Style/text_message_style.dart';
import '../../../../core/local data/auth_controller.dart';
import '../../../../core/network path/path_directory_page.dart';
import '../../../../core/network/network_request_response_data_controller.dart';
import '../../text controller/auth_text_controller.dart';

class ForgetPasswordApiController extends GetxController{
  bool _isButtonVisible=false;
  bool get isButtonVisible=>_isButtonVisible;
  final AuthTextController authTextController=Get.put(AuthTextController());
  Future<void> forgetPasswordAPI()async{
    _isButtonVisible==true;
    update();
    String emailCont=authTextController.emailController.text;
    final NetworkResponse response=await NetworkCall.getRequest(
        url: PathDirectoryUrls.recoverVerifyEmailUrl(emailCont));

    if(response.isSuccess){
      PasswordRecoverEmailModel passwordRecoverEmailModel=PasswordRecoverEmailModel.fromJson(
          response.responseData);
      UserModel? userModel=AuthController.userModel;

      if(userModel !=null && passwordRecoverEmailModel.status=="success"){
        userModel.email=emailCont;
        await AuthController.setUserAccountData(AuthController.accessKey??'', userModel);
      }
      successToast('Email pin send your mail successfully. Pleas check your mail');
    }
    else{
      successToast('Email pin send Failed');
    }
    _isButtonVisible==false;
    update();
  }
}