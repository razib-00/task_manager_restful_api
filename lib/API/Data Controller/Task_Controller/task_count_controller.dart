import 'package:get/get.dart';

import '../../../API_Model/task_status_count_model.dart';
import '../../../Style/text_message_style.dart';
import '../../Path_Directory/path_directory_page.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class TaskCountController extends GetxController {
  bool _getInProgress = false;
  bool get inProgress => _getInProgress;

  String? _getErrorMsg;
  String? get errorMsg=>_getErrorMsg;

  TaskStatusCountModel? _taskStatusCountModel;
  List<TaskStatusDataCount> get countStatusData => _taskStatusCountModel?.data??[];

  Future<bool> getStatusCountApi() async {
    bool isSuccess = false;
    _getInProgress = true;
    update();

    try {
      final response = await NetworkCall.getRequest(
        url: PathDirectoryUrls.taskStatusCountUrl,
      );

      if (response.isSuccess) {
        _taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
        isSuccess = true;
        _getErrorMsg=null;
        update();
      } else {
        errorToast("${response.statusCode}");
      }
    } catch (e) {
      errorToast("Exception: $e");
    } finally {
      _getInProgress = false;
      update();
    }

    return isSuccess;
  }
}
