import 'package:flutter/material.dart';
import 'package:rest_api02/API/Data%20Controller/network_request_response_data_controller.dart';
import 'package:rest_api02/API/Path_Directory/path_directory_page.dart';
import '../../API_Model/get_task_list_model.dart';
import '../../Custom_Widgets/background_image.dart';
import '../../Style/button_style.dart';
import '../../Style/color_style.dart';
import '../../Style/decoration_style.dart';
import '../../Style/text_message_style.dart';
import '../Enum Screen/enum_screen.dart';
import '../UI/Bottom & Drawer/drawer_ui.dart';
import '../UI/Widgets/task_manager_app_bar_widget.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key, required this.getTaskListDataModel});

  static const String name = '/update_items';

  final GetTaskListDataModel getTaskListDataModel;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  GetTaskListModel? getTaskListModel;
  ItemStateEnum? itemStateEnumOption;

  final TextEditingController _taskSubjectController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _taskSubjectController.text = widget.getTaskListDataModel.title ?? '';
    _taskDescriptionController.text = widget.getTaskListDataModel.description ?? '';

    final status = widget.getTaskListDataModel.status;
    if(status!=null){
      ItemStateEnum.values.firstWhere(
              (e) => e.toString().split('.').last == status);
    }else{
          itemStateEnumOption=null;
          }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
        child: SingleChildScrollView(
          child: _buildForm(),
        ),
      ),
      drawer: const DrawerUi(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            await _updateItemsApiCall();
          }
          Navigator.pop(context, true);
        },
        backgroundColor: colorGreen,
        hoverColor: colorAmber,
        label: Text('Submit', style: buttonTextStyle(colorWhite)),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Update Items',
                style: head1Text(colorGreen),
              ),
            ),
            const SizedBox(height: 30),
            DropdownButton<ItemStateEnum>(
              value: itemStateEnumOption,
              dropdownColor: colorGrey,
              hint: Text('Select Status',style: head5Text(colorLightGreen),),
              style: head5Text(colorViolet),
              onChanged: (ItemStateEnum? newOption) {
                setState(() {
                  itemStateEnumOption = newOption;
                });
              },
              items: ItemStateEnum.values.map<DropdownMenuItem<ItemStateEnum>>((ItemStateEnum itemEnumOption) {
                return DropdownMenuItem<ItemStateEnum>(
                  value: itemEnumOption,
                  child: Text(itemEnumOption.displayName),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _taskSubjectController,
              decoration: inputDecoration('Subject'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Please enter your subject';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _taskDescriptionController,
              minLines: 3,
              maxLines: null,
              maxLength: 1000,
              decoration: inputDecoration('Description'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Please enter your description';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateItemsApiCall() async {
    final taskId = widget.getTaskListDataModel.id ?? '';
    final status = itemStateEnumOption?.toString().split('.').last ?? '';
    final url = PathDirectoryUrls.updateTaskStatusUrl(taskId, status);

    final NetworkResponse response = await NetworkCall.getRequest(url: url);
    if (response.isSuccess) {
      setState(() {
        getTaskListModel = GetTaskListModel.fromJson(response.responseData!);
        _clearData();
        successToast("Task updated successfully!");
      });
    } else {
      errorToast("Failed to update task. Status code: ${response.statusCode}");
    }
  }

  void _clearData() {
    _taskSubjectController.clear();
    _taskDescriptionController.clear();
  }

  @override
  void dispose() {
    _taskSubjectController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }
}
