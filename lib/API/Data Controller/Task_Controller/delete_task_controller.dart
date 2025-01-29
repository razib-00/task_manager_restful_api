import 'package:get/get.dart';

import '../../../API_Model/get_task_list_model.dart';
import '../../../Style/text_message_style.dart';
import '../../Path_Directory/path_directory_page.dart';
import '../../Network_Call/network_request_response_data_controller.dart';

class DeleteTaskController extends GetxController {
   DeleteTaskController({required this.getTaskListDataModel});

  GetTaskListModel? getTaskListModel;
  final GetTaskListDataModel? getTaskListDataModel;

  bool _getInProgress = false;

  bool get inProgress => _getInProgress;
  String? _getErrorMsg;

  String? get errorMsg => _getErrorMsg;

  Future<bool> deleteApiCall(String idS) async {
    bool isSuccess = false;
    _getInProgress = true;
    update();


    try {
      final NetworkResponse response = await NetworkCall.getRequest(
        url: PathDirectoryUrls.deleteTaskUrl(idS),
      );
      if (response.isSuccess) {
        getTaskListModel = GetTaskListModel.fromJson(response.responseData!);
        isSuccess=true;
        update();
        successToast("Item deleted successfully!"); // Provide feedback
      } else {
        errorToast("Error: ${response.statusCode}");
      }
    } catch (e) {
      errorToast("An error occurred: $e");
    }
    return isSuccess;
  }
}