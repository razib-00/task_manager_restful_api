import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api02/Style/text_message_style.dart';
import '../../../API/Data Controller/Task_Controller/delete_task_controller.dart';
import '../../../API/Data Controller/Task_Controller/task_list_up_date_controller.dart';
import '../../../API_Model/get_task_list_model.dart';
import '../../../Style/button_style.dart';
import '../../../Style/circular_progress_indicator_widget.dart';
import '../../../Style/color_style.dart';
import '../../Enum Screen/enum_screen.dart';

class ExpandedEditDeleteWidgets extends StatefulWidget {
  const ExpandedEditDeleteWidgets({
    super.key,
    required this.getTaskListDataModel,
  });

  static const String name = '/delete';
  final GetTaskListDataModel? getTaskListDataModel;

  @override
  State<ExpandedEditDeleteWidgets> createState() => _ExpandedEditDeleteWidgetsState();
}

class _ExpandedEditDeleteWidgetsState extends State<ExpandedEditDeleteWidgets> {
  final DeleteTaskController _deleteTaskController = Get.find<DeleteTaskController>();
  final TaskListUpDateController _taskListUpDate = Get.find<TaskListUpDateController>();

  ItemStateEnum? itemStateEnumOption;

  @override
  void initState() {
    super.initState();
    final status = widget.getTaskListDataModel?.status;
    if (status != null) {
      itemStateEnumOption = ItemStateEnum.values.firstWhereOrNull(
            (e) => e.toString().split('.').last == status,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: _editDialog,
              icon: const Icon(Icons.update),
              color: colorGreen,
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: deleteDialog,
              icon: const Icon(Icons.delete),
              color: colorRed,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Delete')),
          titleTextStyle: head1Text(colorRed),
          elevation: 3,
          content: Text(
            'Are you sure you want to delete this item?',
            style: head5Text(colorNaveBlue),
          ),
          actions: [
            GetBuilder<DeleteTaskController>(
              builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: circularProgressIndicatorWidget(),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await deleteApiCall();
                    },
                    style: elevatedButtonEditDelete(colorWhite),
                    child: Text("Yes"),
                  ),
                );
              },
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: elevatedButtonEditDelete(colorRed),
              child: Text("No"),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.all(20),
        );
      },
    );
  }

  Future<void> deleteApiCall() async {
    final bool isSuccess = await _deleteTaskController.deleteApiCall("${widget.getTaskListDataModel?.id}");
    if (isSuccess) {
      successToast("Item deleted successfully!");
    }
  }

  Future<void> _editDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Items"),
          titleTextStyle: head1Text(colorGreen),
          content: DropdownButtonFormField<ItemStateEnum>(
            value: itemStateEnumOption,
            autofocus: true,
            elevation: 5,
            hint: Text('Select Status', style: head5Text(colorLightGreen)),
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
                    child: Text(itemEnumOption.toString()),
                  );
                }).toList(),
            validator: (ItemStateEnum? value) {
              if (value == null) {
                return 'Please select a status';
              }
              return null;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _updateItemsApiCall();
              },
              style: elevatedButton(),
              child: Text("Yes", style: buttonTextStyle(colorWhite)),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: elevatedButton(),
              child: Text("No", style: buttonTextStyle(colorWhite)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateItemsApiCall() async {
    try {
      final bool isSuccess = await _taskListUpDate.updateItemsApiCall(
        widget.getTaskListDataModel?.id ?? '',
        itemStateEnumOption?.toString().split('.').last ?? '',
      );

      if (isSuccess) {
        successToast("Task updated successfully!");
      } else {
        errorToast("Failed to update task.");
      }
    } catch (e) {
      errorToast("An error occurred: $e");
    }
  }
}