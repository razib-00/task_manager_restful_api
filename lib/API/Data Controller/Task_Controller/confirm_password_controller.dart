import 'package:get/get.dart';

import '../../../API_Model/recover_reset_pass.dart';
import '../../../Style/text_message_style.dart';
import '../../Path_Directory/path_directory_page.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class ConfirmPasswordController extends GetxController{

  final bool _getInProgress=false;
  bool get inProgress=>_getInProgress;
  String? _errorMsg;
  String? get errorMsg=>_errorMsg;

  Future<bool> confirmPasswordApiCallMethod(String email,String otp,String password) async{
    bool isSuccess=false;
    _getInProgress==true;
    update();
    Map<String,dynamic> responseBody={
      "email":email,
      "OTP":otp,
      "password":password
    };
    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.recoverResetPasswordUrl, body: responseBody);
    if(response.isSuccess){
      try{
        RecoverResetPass.fromJson(response.responseData!["data"]);
        update();
      }catch(e){
        errorToast(e.toString());
      }
    }else{
      errorToast("${response.statusCode}");
    }
    _getInProgress==false;
    update();
    return isSuccess;
  }

}