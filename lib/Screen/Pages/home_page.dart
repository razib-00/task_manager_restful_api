import 'package:flutter/material.dart';
import 'package:rest_api02/API_Model/task_status_count_model.dart';
import 'package:rest_api02/Screen/User_LogIn_Registration_LogOut/login_screen.dart';

import '../../API/Data Controller/network_request_response_data_controller.dart';
import '../../API/Path_Directory/path_directory_page.dart';
import '../../API_Model/get_task_list_model.dart';
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
  bool _stateChange = false;
  GetTaskListModel? _getTaskListModel;
  TaskStatusCountModel? _taskStatusCountModel;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
        child: Center(
          child: Visibility(
            visible: !_stateChange,
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _getTaskListModel?.getTaskListData?.length ?? 0,
      itemBuilder: (context, index) {
        final task = _getTaskListModel?.getTaskListData?[index];
        if (task == null) return const SizedBox();
        return  StatusEditDeleteItemsWidget(getTaskListDataModel: task);
      },
    );
  }

  Future<void> _getNewTaskList() async {
    _setLoadingState(true);
    final response = await NetworkCall.getRequest(
      url: PathDirectoryUrls.listTaskByStatusUrl("New"),
    );

    if (response.isSuccess) {
      setState(() {
        _getTaskListModel = GetTaskListModel.fromJson(response.responseData!);
      });
      successToast(response.statusCode.toString());
    } else {
      errorToast("${response.statusCode}");
    }
    _setLoadingState(false);
  }

  Future<void> _getStatusCountApi() async {
    _setLoadingState(true);

    final response = await NetworkCall.getRequest(
      url: PathDirectoryUrls.taskStatusCountUrl,
    );

    if (response.isSuccess) {
      setState(() {
        _taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.name, (value)=>false);
      errorToast("${response.statusCode}");

    }
    _setLoadingState(false);
  }

  void _setLoadingState(bool state) {
    if(!mounted) return;
    setState(() {
      _stateChange = state;
    });
  }

  Widget _dataCountWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _taskStatusCountModel?.data?.length ?? 0,
          itemBuilder: (context, index) {
            final taskStatus = _taskStatusCountModel?.data?[index];
            if (taskStatus == null) return const SizedBox();
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


