import 'package:flutter/material.dart';
import '../../../API/Data Controller/auth_controller.dart';
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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

          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              if (!fromUpdateProfile) {
                Navigator.pushNamed(context, ProfileScreen.name);
              }
            },
            child: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/image/5.jpg'),
            ),
          )
        ],
      )
      ,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
