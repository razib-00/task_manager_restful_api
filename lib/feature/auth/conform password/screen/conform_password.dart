import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../Custom_Widgets/background_color_list_screen.dart';
import '../../../../Style/button_style.dart';
import '../../../../Style/circular_progress_indicator_widget.dart';
import '../../../../Style/color_style.dart';
import '../../../../Style/decoration_style.dart';
import '../../../../Style/text_message_style.dart';
import '../../../UI/Widgets/custom_container_widget.dart';
import '../../login/screen/login_screen.dart';
import '../../text controller/auth_text_controller.dart';
import '../controller/conform_password_api_controller.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});
  static const String name = '/confirm_password';

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
final AuthTextController authTextController =Get.put(AuthTextController());
final ConFormPasswordApiController conFormPasswordApiController =Get.put(ConFormPasswordApiController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BackgroundColorListScreen(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text('Set Password', style: head1Text(colorWhite)),
                  ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Minimum length password 8 characters with letter, number, and symbol combination',
                    style: head6Text(colorGrey),
                  ),
                ),
                const SizedBox(height: 90,),
                CustomContainerWidget(child:  _passwordForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _passwordForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: authTextController.passwordController,
              obscureText: !conFormPasswordApiController.isVisibilityPassword,
              decoration: inputDecorationIcon(
                'Password',
                Icon(conFormPasswordApiController.isVisibilityPassword ? Icons.visibility : Icons.visibility_off),
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    conFormPasswordApiController.isVisibilityPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    conFormPasswordApiController.togglePasswordVisibility();
                  },

                ),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter the password';
                } else if (!RegExp(
                    r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                    .hasMatch(value)) {
                  return 'Password must be at least 8 characters with uppercase, lowercase, number, and special character';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: authTextController.confirmPasswordController,
              obscureText: !conFormPasswordApiController.isVisibilityConfirmPassword,
              decoration: inputDecorationIcon(
                'Confirm Password',
                Icon(conFormPasswordApiController.isVisibilityConfirmPassword ? Icons.visibility : Icons.visibility_off),
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    conFormPasswordApiController.isVisibilityConfirmPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    conFormPasswordApiController.toggleConfirmPasswordVisibility();
                  },

                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Re-enter the password';
                } else if (value !=authTextController.passwordController.text.trim()) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _elevatedButton(),
            const SizedBox(height: 20),
            _goToLoginAlign(),
          ],
        ),
      ),
    );
  }

  Align _goToLoginAlign() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Have an account?", style: head6Text(colorNaveBlue)),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.name,(value)=>false);
            },
            child: Text('Sign In', style: buttonTextStyle(colorBlue)),
          ),
        ],
      ),
    );
  }

  Widget _elevatedButton() {
    return Visibility(
      visible: conFormPasswordApiController.isButtonVisibility==false,
      replacement: circularProgressIndicatorWidget(),
      child: ElevatedButton(
        onPressed: () async{
          if (_formKey.currentState!.validate()) {
            await conFormPasswordApiController.confirmPasswordApiCallMethod();
          } else {
            errorToast('Password Enter the valid password');
          }
        },
        child: const Text('Submit'),
        style: elevatedButton(),
      ),
    );
  }


  @override
  void dispose() {
    authTextController.passwordController.dispose();
    authTextController.confirmPasswordController.dispose();
    super.dispose();
  }
}
