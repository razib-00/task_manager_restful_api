import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../API/Data Controller/Auth_Controller/auth_controller.dart';
import '../../../Style/color_style.dart';
import '../../../Style/text_message_style.dart';
import '../../Profile/profile_screen.dart';

class TaskManagerAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const TaskManagerAppBarWidget({super.key, this.fromUpdateProfile = false});

  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (!fromUpdateProfile) {
                Navigator.pushNamed(context, ProfileScreen.name);
              }
            },
            child: CircleAvatar(
                radius: 24,
                backgroundImage: MemoryImage(base64Decode(AuthController.userModel?.photo??''))),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthController.userModel?.fullName ?? '',
                style: head6Text(colorWhite),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(AuthController.userModel?.email ?? '',
                  style: head6Text(colorWhite)),
            ],
          ),


        ]
      )
      ,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
