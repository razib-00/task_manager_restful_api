import 'package:flutter/material.dart';
import '../../../API_Model/get_task_list_model.dart';
import '../../../Style/color_style.dart';
import '../../../Style/text_message_style.dart';

class TaskListViewWidgets extends StatelessWidget {
  const TaskListViewWidgets({super.key, required this.getTaskListDataModel});

  final GetTaskListDataModel? getTaskListDataModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        getTaskListDataModel?.title??'',
        style: head5Text(colorLightBlack),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTaskListDataModel?.description??'',
            style: head7Text(colorLightBlack),
          ),
          const SizedBox(height: 4),
          Text(
            getTaskListDataModel?.createdDate??'',
            style: head7Text(colorBlack),
          ),
        ],
      ),
    );
  }
}
