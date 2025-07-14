import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rest_api02/core/local%20data/auth_controller.dart';
import '../../../Custom_Widgets/background_image.dart';
import '../../../Style/button_style.dart';
import '../../../Style/circular_progress_indicator_widget.dart';
import '../../../Style/color_style.dart';
import '../../../Style/decoration_style.dart';
import '../../../Style/text_message_style.dart';
import '../../UI/Widgets/task_manager_app_bar_widget.dart';
import '../../auth/text controller/auth_text_controller.dart';
import '../controller/profile_api_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String name = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    authTextController.emailController.text=AuthController.userModel?.email??'';
    authTextController.firstNameController.text=AuthController.userModel?.fullName??'';
    authTextController.lastNameController.text=AuthController.userModel?.lastName??'';
    authTextController.phoneController.text=AuthController.userModel?.mobile??'';
    super.initState();
  }
  final AuthTextController authTextController=Get.put(AuthTextController());

 final ProfileApiController profileApiController=Get.put(ProfileApiController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
          child: ListView(
            children: [Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
            children: [
              Text(
                'Update Profile',
                style: head1Text(colorGreen),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      _buildPhotoContainer(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: authTextController.emailController,
                        enabled: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration('Email'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return errorToast('Please enter your email');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: authTextController.firstNameController,
                        decoration: inputDecoration('First Name'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return errorToast('Please enter your first name');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: authTextController.lastNameController,
                        decoration: inputDecoration('Last Name'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return errorToast('Please enter your last name');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: authTextController.phoneController,
                        keyboardType: TextInputType.number,
                        decoration: inputDecoration('Mobil Number'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return errorToast('Please enter your mobile number');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        //enabled: false,
                        obscureText: true,
                        controller: authTextController.passwordController,
                        decoration: inputDecoration('Password'),

                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: profileApiController.updateProfileInProgress==false,
                        replacement: circularProgressIndicatorWidget(),
                        child: ElevatedButton(
                          onPressed: () {
                            _updateProfileButtonMethod();
                          },
                          child: const Text('Update'),
                          style: elevatedButton(),
                        ),
                      )
                    ],
                  ))
            ],
                    ),
                  )],
          )),
    );
  }

  Widget _buildPhotoContainer() {
    return GestureDetector(
      onTap: () {
        profileApiController.pickImage();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 100,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: const BoxDecoration(
                color: colorLightBlack,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text(
                'Photo',
                style: head6Text(colorWhite),
              ),
            ),
            const SizedBox(width: 12,),
            Text(
              profileApiController.pickedImage==null?'Image no found':profileApiController.pickedImage!.name,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    authTextController.emailController.dispose();
    authTextController.firstNameController.dispose();
    authTextController.lastNameController.dispose();
    authTextController.phoneController.dispose();
    authTextController.passwordController.dispose();
    super.dispose();
  }



  void _updateProfileButtonMethod() {
    if(_formKey.currentState!.validate()){
      profileApiController.profileUpdateApiCall();
    }
  }


}
