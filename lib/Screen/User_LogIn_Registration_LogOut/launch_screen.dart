import 'package:flutter/material.dart';
import '../../API/Data Controller/auth_controller.dart';
import '../../Custom_Widgets/launching_image.dart';
import '../../Style/color_style.dart';
import '../../Style/text_message_style.dart';
import '../UI/Bottom & Drawer/bottom_navigation_bar.dart';
import 'login_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  static const String name = '/';

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    _navigateAfterDelay();
    super.initState();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isUserLogin = await AuthController.isUserLogin();
    if (isUserLogin) {
      Navigator.pushReplacementNamed(context, BottomNavigationBarScreen.name);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LaunchingBackgroundImageScreen(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
          'Welcome Back ',
          style: head1Text(colorWhite),
        )),
        const SizedBox(
          height: 250,
        ),
        const CircularProgressIndicator(
          color: Colors.white,
        )
      ],
    )));
  }
}
