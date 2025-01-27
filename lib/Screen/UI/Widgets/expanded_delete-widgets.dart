import 'package:flutter/material.dart';
import 'package:rest_api02/API/Data%20Controller/network_request_response_data_controller.dart';
import 'package:rest_api02/API/Path_Directory/path_directory_page.dart';
import 'package:rest_api02/Style/text_message_style.dart';
import '../../../API_Model/get_task_list_model.dart';
import '../../../Style/button_style.dart';
import '../../../Style/color_style.dart';
import '../../Pages/update_task.dart';
class ExpandedEditDeleteWidgets extends StatefulWidget {
  const ExpandedEditDeleteWidgets({
    super.key,
    required this.getTaskListDataModel,
  });
  static const String name='/delete';
  final GetTaskListDataModel? getTaskListDataModel;

  @override
  State<ExpandedEditDeleteWidgets> createState() => _ExpandedEditDeleteWidgetsState();
}

class _ExpandedEditDeleteWidgetsState extends State<ExpandedEditDeleteWidgets> {
  GetTaskListModel? getTaskListModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, UpdateTask.name,arguments: widget.getTaskListDataModel);
              },
              icon: const Icon(Icons.edit),
              color: colorGreen,
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: () {
                deleteDialog();

              },
              icon: const Icon(Icons.delete),
              color: colorRed,
            ),
          ],
        ),
      ),
    );
  }
  // wait

  Future<void> deleteDialog() {
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
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await deleteApiCall(); // Call the delete API
              },
              child: Text("Yes"),
              style: elevatedButtonEditDelete(colorWhite),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Just close the dialog
              },
              child: Text("No"),
              style: elevatedButtonEditDelete(colorRed),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.all(20),
        );
      },
    );
  }

  Future<void> deleteApiCall() async {
    try {
      final NetworkResponse response = await NetworkCall.getRequest(
        url: PathDirectoryUrls.deleteTaskUrl("${widget.getTaskListDataModel?.id}"),
      );
      if (response.isSuccess) {
        setState(() {
          getTaskListModel = GetTaskListModel.fromJson(response.responseData!);
        });
        successToast("Item deleted successfully!"); // Provide feedback
      } else {
        errorToast("Error: ${response.statusCode}");
      }
    } catch (e) {
      errorToast("An error occurred: $e");
    }
  }

}