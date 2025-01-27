import 'package:flutter/material.dart';
import 'API_Model/get_task_list_model.dart';
import 'Screen/Pages/add_new_item.dart';
import 'Screen/Pages/update_task.dart';
import 'Screen/Profile/profile_screen.dart';
import 'Screen/UI/Bottom & Drawer/bottom_navigation_bar.dart';
import 'Screen/UI/Widgets/expanded_delete-widgets.dart';
import 'Screen/User_LogIn_Registration_LogOut/conform_password.dart';
import 'Screen/User_LogIn_Registration_LogOut/forget_password.dart';
import 'Screen/User_LogIn_Registration_LogOut/launch_screen.dart';
import 'Screen/User_LogIn_Registration_LogOut/login_screen.dart';
import 'Screen/User_LogIn_Registration_LogOut/otp_screen.dart';
import 'Screen/User_LogIn_Registration_LogOut/sign_up_screen.dart';
import 'Style/them_data_style.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      initialRoute: LaunchScreen.name,
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == LaunchScreen.name) {
          widget = const LaunchScreen();
        } else if (settings.name == LoginScreen.name) {
          widget = const LoginScreen();
        } else if (settings.name == ForgetPassword.name) {
          widget = const ForgetPassword();
        } else if (settings.name == OtpScreen.name) {
          widget = const OtpScreen();
        } else if (settings.name == ConfirmPassword.name) {
          widget = const ConfirmPassword();
        } else if (settings.name == SignUpScreen.name) {
          widget = const SignUpScreen();
        } else if (settings.name == BottomNavigationBarScreen.name) {
          widget = const BottomNavigationBarScreen();
        } else if (settings.name == AddNewItem.name) {
          widget = const AddNewItem();
        } else if (settings.name == ProfileScreen.name) {
          widget = const ProfileScreen();
        } else if (settings.name == UpdateTask.name) {
          final GetTaskListDataModel getTaskListDataModel= settings.arguments as GetTaskListDataModel;
          widget = UpdateTask(getTaskListDataModel : getTaskListDataModel);
        }else if (settings.name == ExpandedEditDeleteWidgets.name) {
          final GetTaskListDataModel getTaskListDataModel= settings.arguments as GetTaskListDataModel;
          widget = ExpandedEditDeleteWidgets(getTaskListDataModel : getTaskListDataModel);
        }

        return MaterialPageRoute(builder: (_) => widget);
      },
    );
  }
}
