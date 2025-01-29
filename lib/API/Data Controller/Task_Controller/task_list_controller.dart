import 'package:get/get.dart';
import '../../../API_Model/get_task_list_model.dart';
import '../../../Style/text_message_style.dart';
import '../../Path_Directory/path_directory_page.dart';
import '../../Network_Call/network_request_response_data_controller.dart';



class TaskListController extends GetxController{

  bool _getInProgress=false;
  bool get inProgress=>_getInProgress;
  GetTaskListModel?  _getTaskListModel;
  List<GetTaskListDataModel> get getTaskListData=>_getTaskListModel?.getTaskListData??[];

  String? _getErrorMsg;
  String? get errorMsg=>_getErrorMsg;


  //New
  Future<bool> newGetTaskList() async {
    bool isSuccess=false;
    _getInProgress=true;
    update();

    final response = await NetworkCall.getRequest(
      url: PathDirectoryUrls.listTaskByStatusUrl("New"),
    );

    if (response.isSuccess) {
      _getTaskListModel = GetTaskListModel.fromJson(response.responseData!);
      isSuccess=true;
      successToast(response.statusCode.toString());
      _getErrorMsg=null;
      update();
    } else {
      _getErrorMsg=response.errorMessage;
      errorToast("$_getErrorMsg");
    }
    _getInProgress=false;
    update();
    return isSuccess;
  }

  //complete

  Future<bool> completeGetTaskList() async {
    bool isSuccess=false;
    _getInProgress=true;
    update();
    final response = await NetworkCall.getRequest(
      url: PathDirectoryUrls.listTaskByStatusUrl("Completed"),
    );

    if (response.isSuccess) {
      isSuccess=true;
      _getTaskListModel = GetTaskListModel.fromJson(response.responseData!);
      successToast(response.statusCode.toString());
      _getErrorMsg=null;
      update();
    } else {
      errorToast("${response.statusCode}");
    }
    _getInProgress=false;
    update();
    return isSuccess;
  }



  //Cancel
  Future<bool> cancelGetTaskList() async {
    bool isSuccess=false;
    _getInProgress=true;
    update();
    final response = await NetworkCall.getRequest(
      url: PathDirectoryUrls.listTaskByStatusUrl("Cancel"),
    );

    if (response.isSuccess) {
      isSuccess=true;
      _getTaskListModel = GetTaskListModel.fromJson(response.responseData!);
      successToast(response.statusCode.toString());
      _getErrorMsg=null;
      update();
    } else {
      errorToast("${response.statusCode}");
    }
    _getInProgress=false;
    update();
    return isSuccess;
  }


  //progress
  Future<bool> progressGetTaskList() async {
    bool isSuccess=false;
    _getInProgress=true;
    update();
    final response = await NetworkCall.getRequest(
      url: PathDirectoryUrls.listTaskByStatusUrl("Progress"),
    );

    print("--------------response.isSuccess:${response.isSuccess}");
    if (response.isSuccess) {
      isSuccess=true;
      _getTaskListModel = GetTaskListModel.fromJson(response.responseData!);
      print(_getTaskListModel);
      successToast(response.statusCode.toString());
      _getErrorMsg=null;
      update();
    } else {
      errorToast("${response.statusCode}");
    }
    _getInProgress=false;
    update();
    return isSuccess;
  }


}