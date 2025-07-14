import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_api02/feature/auth/text%20controller/auth_text_controller.dart';

import '../../../Style/text_message_style.dart';
import '../../../core/network path/path_directory_page.dart';
import '../../../core/network/network_request_response_data_controller.dart';
class ProfileApiController extends GetxController{
  AuthTextController authTextController=Get.put(AuthTextController());
  XFile? _pickedImage;
  XFile? get pickedImage=>_pickedImage;
  bool _updateProfileInProgress = false;
  bool get updateProfileInProgress=>_updateProfileInProgress;
  Future<void> pickImage()async {
    ImagePicker picker=ImagePicker();
    XFile? image=await picker.pickImage(source: ImageSource.gallery);
    if(image!=null){

        _pickedImage=image;
      update();
    }
  }



  Future<void> profileUpdateApiCall()async {

      _updateProfileInProgress=true;
      update();

    Map<String,dynamic> profileMap={
      'email': authTextController.emailController.text.trim(),
      'firstName': authTextController.firstNameController.text.trim(),
      'lastName': authTextController.lastNameController.text.trim(),
      "mobile":authTextController.phoneController.text.trim(),
    };

    if(_pickedImage!=null){
      List<int> imageByte=await _pickedImage!.readAsBytes();
      profileMap['photo']=base64Encode(imageByte);
    }

    if(authTextController.passwordController.text.isNotEmpty){
      profileMap['password']=authTextController.passwordController.text;
    }
    debugPrint("$profileMap");

    final NetworkResponse response =await NetworkCall.postRequest(
        url: PathDirectoryUrls.profileUpdateUrl,
        body: profileMap
    );

      _updateProfileInProgress=false;
      update();
    if(response.isSuccess){
      authTextController.passwordController.clear();
      successToast("Profile Update Successful!");
    }else{
      errorToast("${response.statusCode}");
    }
  }

}