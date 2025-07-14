import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Custom_Widgets/background_image.dart';
import '../../../Style/button_style.dart';
import '../../../Style/circular_progress_indicator_widget.dart';
import '../../../Style/color_style.dart';
import '../../UI/Bottom & Drawer/drawer_ui.dart';
import '../../UI/Widgets/status_edit_delete_items_widget.dart';
import '../../UI/Widgets/task_manager_app_bar_widget.dart';
import '../../UI/Widgets/status_count_widget.dart';
import '../../add new/screen/add_new_item.dart';
import '../controller/home_page_api_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageApiController homePageApiController = Get.put(HomePageApiController());

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Future.wait([
      homePageApiController.getStatusCountApi(),
      homePageApiController.getNewTaskList(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
        child: Center(
          child: GetBuilder<HomePageApiController>(
            builder: (_) {
              if (!homePageApiController.stateChange) {
                return circularProgressIndicatorWidget();
              }
              return Column(
                children: [
                  _dataCountWidget(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _taskListView(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      drawer: const DrawerUi(),
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
    final tasks = homePageApiController.getTaskListModel?.getTaskListData ?? [];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return StatusEditDeleteItemsWidget(getTaskListDataModel: task);
      },
    );
  }

  Widget _dataCountWidget() {
    final statusCounts = homePageApiController.taskStatusCountModel?.data ?? [];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: statusCounts.length,
          itemBuilder: (context, index) {
            final taskStatus = statusCounts[index];
            return StatusCountWidget(
              count: taskStatus.sum.toString(),
              title: taskStatus.id ?? '',
            );
          },
        ),
      ),
    );
  }
}
