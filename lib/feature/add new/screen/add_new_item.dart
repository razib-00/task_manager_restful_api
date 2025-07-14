// add_new_item.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../Custom_Widgets/background_image.dart';
import '../../../Style/button_style.dart';
import '../../../Style/circular_progress_indicator_widget.dart';
import '../../../Style/color_style.dart';
import '../../../Style/decoration_style.dart';
import '../../../Style/text_message_style.dart';
import '../../Enum Screen/enum_screen.dart';
import '../../UI/Bottom & Drawer/drawer_ui.dart';
import '../../UI/Widgets/task_manager_app_bar_widget.dart';
import '../../text editing controller/page_text_editing_controller.dart';
import '../controller/add_new_api_controller.dart'; // Ensure this import is correct

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  static const String name = '/add_new_items';

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final PageTextEditingController pageTextEditingController=Get.put(PageTextEditingController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddNewApiController addNewApiController =Get.put(AddNewApiController());


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
                    Obx(() => DropdownButton<ItemStateEnum>(
                      value: addNewApiController.itemStateEnumOption.value,
                      hint: Text('Select Status', style: head5Text(colorLightGreen)),
                      dropdownColor: colorGrey,
                      style: head5Text(colorViolet),
                      enableFeedback: true,
                      onChanged: (ItemStateEnum? newOption) {
                        addNewApiController.itemStateEnumOption.value = newOption;
                      },
                      items: ItemStateEnum.values
                          .map((ItemStateEnum itemEnumOption) {
                        return DropdownMenuItem<ItemStateEnum>(
                          value: itemEnumOption,
                          child: Text(itemEnumOption.displayName),
                        );
                      }).toList(),
                    ))

                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: pageTextEditingController.taskTitleController,
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
              controller: pageTextEditingController.taskDescriptionController,
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
                visible: addNewApiController.isButtonVisible,
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
      addNewApiController.addItemApiCallMethod();
    }
  }



  @override
  void dispose() {
    pageTextEditingController.taskTitleController.dispose();
    pageTextEditingController.taskDescriptionController.dispose();
    super.dispose();
  }
}
