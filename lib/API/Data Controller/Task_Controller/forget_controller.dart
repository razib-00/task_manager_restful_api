import 'package:get/get.dart';
import 'package:rest_api02/Style/text_message_style.dart';

import '../../../API_Model/PasswordRecoverEmailModel.dart';
import '../../../API_Model/user_model.dart';
import '../../Path_Directory/path_directory_page.dart';
import '../Auth_Controller/auth_controller.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class ForgetController extends GetxController{

  bool _getInProgress=false;
  bool get inProgress=>_getInProgress;
  Future<bool> forgetPasswordAPI(String email)async{
    bool isSuccess=false;
    _getInProgress=true;
    update();
    String emailCont=email;
    final NetworkResponse response=await NetworkCall.getRequest(
        url: PathDirectoryUrls.recoverVerifyEmailUrl(emailCont));

    if(response.isSuccess){
      isSuccess=true;
      PasswordRecoverEmailModel passwordRecoverEmailModel=PasswordRecoverEmailModel.fromJson(
          response.responseData);
      UserModel? userModel=AuthController.userModel;
      update();
      if(userModel !=null && passwordRecoverEmailModel.status=="success"){
        userModel.email=emailCont;
        await AuthController.setUserAccountData(AuthController.accessKey??'', userModel);
      }
    }
    else{
      errorToast('${response.statusCode}');
    }
    _getInProgress=false;
    update();
    return isSuccess;
  }
}