import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../API/Data Controller/auth_controller.dart';
import '../../../Style/color_style.dart';
import '../../../Style/text_message_style.dart';

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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (AuthController.userModel != null)
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AuthController.userModel?.photo != null && AuthController.userModel!.photo!.isNotEmpty
                    ? MemoryImage(base64Decode(AuthController.userModel!.photo!))
                    : AssetImage('assets/default_avatar.png') as ImageProvider,
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
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.cached)),
            title: Text('Progress', style: head6Text(colorNaveBlue)),
            onTap: () {
              Navigator.pushNamed(context, '/progress');
            },
          ),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.cancel_outlined)),
            title: Text('Cancel', style: head6Text(colorNaveBlue)),
            onTap: () {
              Navigator.pushNamed(context, '/cancel');
            },
          ),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.recent_actors_outlined)),
            title: Text('Complete', style: head6Text(colorNaveBlue)),
            onTap: () {
              Navigator.pushNamed(context, '/complete');
            },
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                AuthController.dataClear();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              backgroundColor: colorGreen,
              label: Text(
                'Log Out',
                style: head6Text(colorWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
