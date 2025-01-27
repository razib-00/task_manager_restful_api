import 'package:flutter/material.dart';
import '../../../API/Data Controller/auth_controller.dart';
import '../../../Style/color_style.dart';
import '../../../Style/text_message_style.dart';
import '../../User_LogIn_Registration_LogOut/login_screen.dart';

class DrawerUi extends StatefulWidget {
  const DrawerUi({Key? key}) : super(key: key);

  @override
  State<DrawerUi> createState() => _DrawerUiState();
}

class _DrawerUiState extends State<DrawerUi> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: colorGrey,
      elevation: 5,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/image/4.jpg'),
            ),
            accountName: Text(
              AuthController.userModel?.fullName ?? '',
              style: head6Text(colorWhite),
            ),
            accountEmail: Text(
              AuthController.userModel?.email ?? '',
              style: head6Text(colorWhite),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.dashboard)),
            title: Text('Dashboard', style: head6Text(colorNaveBlue)),
            focusColor: colorGreen,
            hoverColor: colorAmber,
            onTap: () {
              Navigator.pushNamed(context, '/dashboard'); // Update the route
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.cached)),
            title: Text('Progress', style: head6Text(colorNaveBlue)),
            focusColor: colorGreen,
            hoverColor: colorAmber,
            onTap: () {
              // Update the route
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.cancel_outlined)),
            title: Text('Cancel', style: head6Text(colorNaveBlue)),
            // Unique title
            focusColor: colorGreen,
            hoverColor: colorAmber,
            onTap: () {
              // Update the route
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading:
                const CircleAvatar(child: Icon(Icons.recent_actors_outlined)),
            title: Text('Complete', style: head6Text(colorNaveBlue)),
            focusColor: colorGreen,
            hoverColor: colorAmber,
            onTap: () {
              // Update the route
            },
          ),
          const SizedBox(height: 50),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      AuthController.dataClear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.name, (value) => false);
                    },
                    backgroundColor: colorGreen,
                    hoverColor: colorAmber,
                    label: Text(
                      'Log Out',
                      style: head6Text(colorWhite),
                    ),
                  )))
        ],
      ),
    );
  }
}
