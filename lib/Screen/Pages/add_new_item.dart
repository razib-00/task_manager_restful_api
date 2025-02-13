import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../API/Data Controller/Task_Controller/add_task_list_controller.dart';
import '../../Custom_Widgets/background_image.dart';
import '../../Screen/Enum Screen/enum_screen.dart';
import '../../Style/button_style.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/decoration_style.dart';
import '../../Style/text_message_style.dart';
import '../UI/Bottom & Drawer/drawer_ui.dart';
import '../UI/Widgets/task_manager_app_bar_widget.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  static const String name = '/add_new_items';

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final AddTaskListController _addTaskListController = Get.find<AddTaskListController>();

  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ItemStateEnum? itemStateEnumOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
        child: SingleChildScrollView(
          child: _buildForm(),
        ),
      ),
      endDrawer: const DrawerUi(),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Card(
                elevation:5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Add Your Items', style: head1Text(colorGreen)),
                )
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<ItemStateEnum>(
                  value: itemStateEnumOption,
                  autofocus: true,
                  elevation: 5,
                  hint: Text('Select Status', style: head5Text(colorLightGreen)),
                  dropdownColor: colorGrey,
                  enableFeedback: true,
                  style: head5Text(colorGreen),
                  onChanged: (ItemStateEnum? newOption) {
                    setState(() {
                      itemStateEnumOption = newOption;
                    });
                  },
                  items: ItemStateEnum.values
                      .map<DropdownMenuItem<ItemStateEnum>>(
                          (ItemStateEnum itemEnumOption) {
                        return DropdownMenuItem<ItemStateEnum>(
                          value: itemEnumOption,
                          child: Text(itemEnumOption.toString()), // Ensure `displayName` is defined
                        );
                      }).toList(),
                  validator: (ItemStateEnum? value) {
                    if (value == null) {
                      return 'Please select a status';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 5,
              child: TextFormField(
                controller: _taskTitleController,
                decoration: inputDecoration('Subject'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Please enter your subject';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 5,
              child: TextFormField(
                controller: _taskDescriptionController,
                minLines: 3,
                maxLines: 6,
                maxLength: 1000,
                decoration: inputDecoration('Description'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Please enter your description';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            GetBuilder<AddTaskListController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.inProgress==false,
                  replacement: circularProgressIndicatorWidget(),
                  child: ElevatedButton(
                    onPressed: (){
                       _submitButtonMethod();
                    },
                    style: elevatedButton(),
                    child: Text('Submit', style: buttonTextStyle(colorWhite)),
                ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitButtonMethod()async{
    if (_formKey.currentState!.validate()) {
      await _addItemApiCallMethod();
    }
  }

  Future<void> _addItemApiCallMethod() async {
    try {
      final bool isSuccess = await _addTaskListController.getAddItemApiCallMethod(
        _taskTitleController.text.trim(),
        _taskDescriptionController.text.trim(),
        itemStateEnumOption?.toString().split('.').last ?? '',
      );

      if (isSuccess) {
        _clearNewTaskAdd();
        successToast("New task is added successfully!");
      } else {
        errorToast("New items added fail");
      }
    } catch (e) {
      errorToast("An error occurred: $e");
    }
  }

  void _clearNewTaskAdd() {
    setState(() {
      _taskDescriptionController.clear();
      _taskTitleController.clear();
      itemStateEnumOption = null;
    });
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }
}
