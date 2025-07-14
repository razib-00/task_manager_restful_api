import 'package:get/get.dart';
import 'package:rest_api02/feature/text%20editing%20controller/page_text_editing_controller.dart';
import '../../../Style/text_message_style.dart';
import '../../../core/network path/path_directory_page.dart';
import '../../../core/network/network_request_response_data_controller.dart';
import '../../Enum Screen/enum_screen.dart';

class AddNewApiController extends GetxController{
  bool _isButtonVisible = false;
  bool get isButtonVisible=>_isButtonVisible;
  final Rxn<ItemStateEnum> itemStateEnumOption = Rxn<ItemStateEnum>();



  final PageTextEditingController pageTextEditingController=Get.put(PageTextEditingController());
  Future<void> addItemApiCallMethod() async {

      _isButtonVisible = true;
      update();

    Map<String, dynamic> addItemMapPostBody = {
      "title": pageTextEditingController.taskTitleController.text.trim(),
      "description": pageTextEditingController.taskDescriptionController.text.trim(),
      "status": itemStateEnumOption.toString().split('.').last,
    };

    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.createTaskUrl,
        body: addItemMapPostBody);


      _isButtonVisible = false;
      update();

    if (response.isSuccess) {
      _clearNewTaskAdd();
      successToast("New task is added successfully!");
    } else {
      errorToast("New items added fail");
    }
  }

  void _clearNewTaskAdd() {
    pageTextEditingController.taskDescriptionController.clear();
    pageTextEditingController.taskTitleController.clear();
  }
}