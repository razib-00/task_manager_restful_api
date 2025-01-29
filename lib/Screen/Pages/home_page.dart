import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../API/Data Controller/Task_Controller/task_count_controller.dart';
import '../../API/Data Controller/Task_Controller/task_list_controller.dart';
import '../../Custom_Widgets/background_image.dart';
import '../../Style/button_style.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/text_message_style.dart';
import '../UI/Bottom & Drawer/drawer_ui.dart';
import '../UI/Widgets/status_edit_delete_items_widget.dart';
import '../UI/Widgets/task_manager_app_bar_widget.dart';
import '../UI/Widgets/status_count_widget.dart';
import 'add_new_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Future.wait([
      _getStatusCountApi(),
      _getNewTaskList(),
    ]);
  }

  final TaskListController _getTaskList=Get.find<TaskListController>();
  final TaskCountController _getTaskCount=Get.find<TaskCountController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
        child: Center(
          child: GetBuilder<TaskListController>(builder: (controller){
            return Visibility(
              visible: controller.inProgress==false,
              replacement: circularProgressIndicatorWidget(),
              child: Column(
                children: [
                  _dataCountWidget(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _taskListView(),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      endDrawer: const DrawerUi(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AddNewItem.name),
        backgroundColor: colorGreen,
        hoverColor: colorAmber,
        shape: const CircleBorder(),
        label: Text('Add', style: buttonTextStyle(colorWhite)),
      ),
    );
  }

  Widget _taskListView() {
    return GetBuilder<TaskListController>(builder: (controller){
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.getTaskListData.length,
        itemBuilder: (context, index) {
          final task = controller.getTaskListData[index];
          return  StatusEditDeleteItemsWidget(getTaskListDataModel: task);
        },
      );
    });
  }

  Future<void> _getNewTaskList() async {
    final bool isSuccess=await _getTaskList.newGetTaskList();
    if (!isSuccess) {
      errorToast("${_getTaskList.errorMsg}");
    }
  }

  Future<void> _getStatusCountApi() async {
    final bool isSuccess=await _getTaskCount.getStatusCountApi();
    if (!isSuccess) {
      errorToast("${ _getTaskCount.errorMsg}");
    }

  }


  Widget _dataCountWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: GetBuilder<TaskCountController>(builder: (controller){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.countStatusData.length ,
            itemBuilder: (context, index) {
              final taskStatus = controller.countStatusData[index];
              return StatusCountWidget(
                count: taskStatus.sum.toString(),
                title: taskStatus.id ?? '',
              );
            },
          );
        })
      ),
    );
  }
}


