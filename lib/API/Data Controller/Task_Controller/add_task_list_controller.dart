import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Path_Directory/path_directory_page.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class AddTaskListController extends GetxController{

  bool _getInProgress=false;
  bool get inProgress=>_getInProgress;

  Future<bool> getAddItemApiCallMethod(String title, String description,String status) async {
    bool isSuccess=false;
    _getInProgress=true;
    update();

    Map<String, dynamic> addItemMapPostBody = {
      "title": title,
      "description": description,
      "status": status,
    };

    debugPrint(jsonEncode(addItemMapPostBody));
    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.createTaskUrl,
        body: addItemMapPostBody);

    _getInProgress=false;
    update();

    if (response.isSuccess) {
      isSuccess=true;
      update();
    }
    return isSuccess;
  }
}