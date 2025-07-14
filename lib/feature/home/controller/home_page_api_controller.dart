import 'package:get/get.dart';
import '../../../API_Model/get_task_list_model.dart';
import '../../../API_Model/task_status_count_model.dart';
import '../../../Style/text_message_style.dart';
import '../../../core/network path/path_directory_page.dart';
import '../../../core/network/network_request_response_data_controller.dart';
import '../../auth/login/screen/login_screen.dart';

class HomePageApiController extends GetxController{
  bool _setLoadingState=false;
  bool get setLoadingState=>_setLoadingState;
  bool _stateChange = false;
  bool get stateChange=>_stateChange;
  GetTaskListModel? _getTaskListModel;
  GetTaskListModel? get getTaskListModel=>_getTaskListModel;

  TaskStatusCountModel? _taskStatusCountModel;
  TaskStatusCountModel? get taskStatusCountModel=>_taskStatusCountModel;

  Future<void> getNewTaskList() async {
    _setLoadingState=true;
    final response = await NetworkCall.getRequest(
      url: PathDirectoryUrls.listTaskByStatusUrl("New"),
    );

    if (response.isSuccess) {

        _getTaskListModel = GetTaskListModel.fromJson(response.responseData!);
     update();
      successToast(response.statusCode.toString());
    } else {
      errorToast("${response.statusCode}");
    }
    _setLoadingState=false;
  }

  Future<void> getStatusCountApi() async {
    _setLoadingState=true;

    final response = await NetworkCall.getRequest(
      url: PathDirectoryUrls.taskStatusCountUrl,
    );

    if (response.isSuccess) {

        _taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
     update();
    } else {
      Get.offAllNamed(LoginScreen.name);
      errorToast("${response.statusCode}");

    }
    _setLoadingState=false;
  }
}
