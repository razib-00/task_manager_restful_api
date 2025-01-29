import 'package:get/get.dart';

import 'API/Data Controller/Task_Controller/add_task_list_controller.dart';
import 'API/Data Controller/Task_Controller/confirm_password_controller.dart';
import 'API/Data Controller/Task_Controller/profile_controller.dart';
import 'API/Data Controller/Task_Controller/task_count_controller.dart';
import 'API/Data Controller/Task_Controller/task_list_controller.dart';
import 'API/Data Controller/Task_Controller/delete_task_controller.dart';
import 'API/Data Controller/Task_Controller/forget_controller.dart';
import 'API/Data Controller/Task_Controller/login_controller.dart';
import 'API/Data Controller/Task_Controller/otp_controller.dart';
import 'API/Data Controller/Task_Controller/sing_up_controller.dart';
import 'API/Data Controller/Task_Controller/task_list_up_date_controller.dart';
import 'API_Model/get_task_list_model.dart';

class ControllerBinder extends Bindings{
   GetTaskListDataModel? getTaskListDataModel;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>LoginController());
    Get.lazyPut(()=>SingUPController());
    Get.lazyPut(()=>OTPController());
    Get.lazyPut(()=>ForgetController());
    Get.lazyPut(()=>ConfirmPasswordController());
    Get.lazyPut(()=>AddTaskListController());
    Get.lazyPut(()=>TaskListUpDateController());
    Get.lazyPut(()=>ProfileController());
    Get.lazyPut(()=>DeleteTaskController(getTaskListDataModel: getTaskListDataModel));
    Get.put(TaskListController());
    Get.put(TaskCountController());

  }

}