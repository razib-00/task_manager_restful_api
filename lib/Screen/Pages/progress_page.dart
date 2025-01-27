import 'package:flutter/material.dart';
import 'package:rest_api02/API/Data%20Controller/network_request_response_data_controller.dart';
import '../../API/Path_Directory/path_directory_page.dart';
import '../../API_Model/get_task_list_model.dart';
import '../../Custom_Widgets/background_image.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/text_message_style.dart';
import '../UI/Bottom & Drawer/drawer_ui.dart';
import '../UI/Widgets/expanded_delete-widgets.dart';
import '../UI/Widgets/task_list_view_widgets.dart';
import '../UI/Widgets/task_manager_app_bar_widget.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});
  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {


  @override
  void initState() {
    // TODO: implement initState
    _progressAPICall();
    super.initState();
  }


  GetTaskListDataModel? getTaskListDataModel;
  GetTaskListModel? _getTaskListModel;
  bool _isVisible=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: Visibility(
                    visible: _isVisible==false,
                      replacement: circularProgressIndicatorWidget(),
                      child: _listViewBuilder()),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const DrawerUi(),
    );
  }

  Widget _listViewBuilder() {
    return ListView.builder(
      itemCount: _getTaskListModel?.getTaskListData?.length??0,
      itemBuilder: (context, index) {
        final task = _getTaskListModel?.getTaskListData?[index];
        if (task == null) return const SizedBox();
        return paddingWidget(getTaskListDataModel: task);
      },
    );
  }

  Future<void> _progressAPICall()async{
    setState(() {
      _isVisible=true;
    });
    final NetworkResponse response =await NetworkCall.getRequest(
        url: PathDirectoryUrls.listTaskByStatusUrl("Progress"));
    if(response.isSuccess){
      setState(() {
        _getTaskListModel=GetTaskListModel.fromJson(response.responseData!);
      });
    }else{
      errorToast("${response.statusCode}");
    }
    setState(() {
      _isVisible=false;
    });
  }


}

class paddingWidget extends StatelessWidget {
  const paddingWidget({
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
                          'Progress',
                          style: head5Text(colorWhite),
                        ),
                        alignment: Alignment.center,
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: colorViolet,
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
