import 'package:get/get.dart';

import '../../../API_Model/get_task_list_model.dart';
import '../../../Style/text_message_style.dart';
import '../../Path_Directory/path_directory_page.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class TaskListUpDateController extends GetxController{

   bool _getInProgress=false;
   bool get inProgress=>_getInProgress;
   String? _getErrorMsg;
   String? get errorMsg=>_getErrorMsg;
   GetTaskListModel? _getTaskListModel;
   List<GetTaskListDataModel> get taskListDataModel=>_getTaskListModel?.getTaskListData??[];

   Future<bool> updateItemsApiCall(
      String taskId, String status) async {
    bool isSuccess = false;
    _getInProgress = true;
    update();

    final url = PathDirectoryUrls.updateTaskStatusUrl(taskId, status);

    final NetworkResponse response = await NetworkCall.getRequest(url: url);
    if (response.isSuccess) {
      isSuccess = true;
      GetTaskListModel.fromJson(response.responseData!);
      update();
    } else {
      errorToast("Failed to update task. Status code: ${response.statusCode}");
    }
    return isSuccess;
  }
}