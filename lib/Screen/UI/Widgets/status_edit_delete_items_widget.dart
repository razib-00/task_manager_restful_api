import 'package:flutter/material.dart';
import 'package:rest_api02/Screen/UI/Widgets/task_list_view_widgets.dart';

import '../../../API_Model/get_task_list_model.dart';
import '../../../Style/color_style.dart';
import '../../../Style/text_message_style.dart';
import 'expanded_delete-widgets.dart';

class StatusEditDeleteItemsWidget extends StatelessWidget {
  const StatusEditDeleteItemsWidget({
    super.key,
    required this.getTaskListDataModel,
  });

  final GetTaskListDataModel? getTaskListDataModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskListViewWidgets(getTaskListDataModel: getTaskListDataModel,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'New',
                          style: head5Text(colorWhite),
                        ),
                        alignment: Alignment.center,
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: colorPast,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      /* Chip(
                      label: Text(
                        'Progress',
                        selectionColor: colorViolet,
                        style: head1Text(colorViolet),
                      ),
                    )*/

                    ],
                  ),
                ),
                ExpandedEditDeleteWidgets(getTaskListDataModel: getTaskListDataModel)
              ],
            )
          ],
        ),
      ),
    );
  }
}

