// add_new_item.dart


import 'package:flutter/material.dart';

import '../../API/Data Controller/network_request_response_data_controller.dart';
import '../../API/Path_Directory/path_directory_page.dart';
import '../../Custom_Widgets/background_image.dart';
import '../../Screen/Enum Screen/enum_screen.dart';
import '../../Style/button_style.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/decoration_style.dart';
import '../../Style/text_message_style.dart';
import '../UI/Bottom & Drawer/drawer_ui.dart';
import '../UI/Widgets/task_manager_app_bar_widget.dart'; // Ensure this import is correct

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  static const String name = '/add_new_items';

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonVisible = false;

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
      drawer: const DrawerUi(),
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
            const SizedBox(
              height: 40,
            ),
            Center(
                child: Column(
                  children: [
                    Text(
                      'Add Your Items',
                      style: head1Text(colorGreen),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownButton<ItemStateEnum>(
                      value: itemStateEnumOption,
                      autofocus: true,
                      elevation: 5,

                      hint: Text('Select Status',style: head5Text(colorLightGreen),),
                      dropdownColor: colorGrey,
                      style: head5Text(colorViolet),
                      enableFeedback: true,
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
                              child: Text(itemEnumOption.displayName),
                            );
                          }).toList(),
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _taskTitleController,
              decoration: inputDecoration('Subject'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return errorToast('Please enter your subject');
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _taskDescriptionController,
              minLines: 3,
              maxLines: 6,
              maxLength: 1000,
              decoration: inputDecoration('Description'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return errorToast('Please enter your description');
                }
                return null;
              },
            ),
            FloatingActionButton.extended(
              onPressed: () {
                _submitButtonMethod();
              },
              backgroundColor: colorGreen,
              hoverColor: colorAmber,
              label: Visibility(
                visible: !_isButtonVisible,
                replacement: circularProgressIndicatorWidget(),
                child: Text('Submit', style: buttonTextStyle(colorWhite)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitButtonMethod() {
    if (_formKey.currentState!.validate()) {
      _addItemApiCallMethod();
    }
  }

  Future<void> _addItemApiCallMethod() async {
    setState(() {
      _isButtonVisible = true;
    });

    Map<String, dynamic> addItemMapPostBody = {
      "title": _taskTitleController.text.trim(),
      "description": _taskDescriptionController.text.trim(),
      "status": itemStateEnumOption?.toString().split('.').last,
    };

    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.createTaskUrl,
        body: addItemMapPostBody);

    setState(() {
      _isButtonVisible = false;
    });

    if (response.isSuccess) {
      _clearNewTaskAdd();
      successToast("New task is added successfully!");
    } else {
      errorToast("New items added fail");
    }
  }

  void _clearNewTaskAdd() {
    _taskDescriptionController.clear();
    _taskTitleController.clear();
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }
}
