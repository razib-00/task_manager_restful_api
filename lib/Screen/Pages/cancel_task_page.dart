import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../API/Data Controller/Task_Controller/task_list_controller.dart';
import '../../API_Model/get_task_list_model.dart';
import '../../Custom_Widgets/background_image.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/text_message_style.dart';
import '../UI/Bottom & Drawer/drawer_ui.dart';
import '../UI/Widgets/expanded_delete-widgets.dart';
import '../UI/Widgets/task_list_view_widgets.dart';
import '../UI/Widgets/task_manager_app_bar_widget.dart';

class CancelTaskPage extends StatefulWidget {
  const CancelTaskPage({super.key});
  @override
  State<CancelTaskPage> createState() => _CancelTaskPageState();
}

class _CancelTaskPageState extends State<CancelTaskPage> {

  final TaskListController _taskListController=Get.find<TaskListController>();

  @override
  void initState() {
    // TODO: implement initState
    _cancelAPICall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: GetBuilder<TaskListController>(builder: (controller){
                    return Visibility(
                        visible: _taskListController.inProgress==false,
                        replacement: circularProgressIndicatorWidget(),
                        child: _listViewBuilder());
                  })
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: const DrawerUi(),
    );
  }

  Widget _listViewBuilder() {
    return GetBuilder<TaskListController>(builder: (controller){
      return ListView.builder(
        itemCount: _taskListController.getTaskListData.length,
        itemBuilder: (context, index) {
          final task = _taskListController.getTaskListData[index];
          return paddingWidget(getTaskListDataModel: task);
        },
      );
    });
  }

  Future<void> _cancelAPICall()async{
    final bool isSuccess=await _taskListController.cancelGetTaskList();
    if(!isSuccess){
      _taskListController.errorMsg;
    }
  }


}

class paddingWidget extends StatelessWidget {
  const paddingWidget({
    super.key,
    required this.getTaskListDataModel,
  });

  final GetTaskListDataModel? getTaskListDataModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskListViewWidgets(getTaskListDataModel: getTaskListDataModel,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: colorRed,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          'Cancel',
                          style: head5Text(colorWhite),
                        ),
                      ),
                      /* Chip(
                      label: Text(
                        'Progress',
                        selectionColor: colorViolet,
                        style: head1Text(colorViolet),
                      ),
                    )*/

                    ],
                  ),
                ),
                ExpandedEditDeleteWidgets(getTaskListDataModel: getTaskListDataModel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
