

import 'package:get/get.dart';
import '../../../Style/text_message_style.dart';
import '../../Path_Directory/path_directory_page.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class ProfileController extends GetxController{

  bool _getInProgress=false;
  bool get inProgress=>_getInProgress;


  Future<bool> profileUpdateApiCall(String email, String firstName,String lastName,String mobile,String? password, String? image )async {
    bool isSuccess=false;

    _getInProgress=true;
    update();

    Map<String,dynamic> profileMap={
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      "mobile":mobile,
      "password":password,
      "photo": image,
    };

    final NetworkResponse response =await NetworkCall.postRequest(
        url: PathDirectoryUrls.profileUpdateUrl,
        body: profileMap
    );
    _getInProgress=false;
    update();
    if(response.isSuccess){
      isSuccess=true;
      update();
      successToast("Profile Update Successful!");
    }else{
      errorToast("${response.statusCode}");
    }
    return isSuccess;
  }

}