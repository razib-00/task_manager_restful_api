import 'package:flutter/material.dart';
import '../../../API/Data Controller/network_request_response_data_controller.dart';
import '../../../API/Path_Directory/path_directory_page.dart';
import '../../../API_Model/get_task_list_model.dart';
import '../../../Style/color_style.dart';
import '../../../Style/text_message_style.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({super.key, required this.getTaskListDataModel});
  final GetTaskListDataModel getTaskListDataModel;
  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  GetTaskListModel? getTaskListModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete'),
      titleTextStyle: head1Text(colorRed),
      content: const Text('Are you sure delete this item!'),
      contentTextStyle: head6Text(colorNaveBlue),
      contentPadding: const EdgeInsets.all(8.0),
      actions: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _deleteAPiMethod();
            });
            Navigator.pop(context, true);
          },
          child: Text(
            'Yes',
            style: head6Text(colorGreen),
          ),
        ),
        const SizedBox(width: 70),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(
            'No',
            style: head6Text(colorRed),
          ),
        ),
      ],
    );
  }
  Future<void> _deleteAPiMethod() async{

    final NetworkResponse response=await NetworkCall.getRequest(
        url: PathDirectoryUrls.deleteTaskUrl("${widget.getTaskListDataModel.id}"));
    if(response.isSuccess){
      setState(() {
        getTaskListModel=GetTaskListModel.fromJson(response.responseData!);
      });
    }else{
      errorToast("${response.statusCode}");
    }
  }
}
