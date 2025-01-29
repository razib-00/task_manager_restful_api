import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api02/API/Data%20Controller/Auth_Controller/auth_controller.dart';
import 'package:rest_api02/Screen/UI/Widgets/custom_container_widget.dart';
import '../../API/Data Controller/Task_Controller/confirm_password_controller.dart';
import '../../Custom_Widgets/background_color_list_screen.dart';
import '../../Style/button_style.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/decoration_style.dart';
import '../../Style/text_message_style.dart';
import 'login_screen.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});
  static const String name = '/confirm_password';

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isVisibilityPassword = false;
  bool _isVisibilityConfirmPassword = false;
  final ConfirmPasswordController _confirmPasswordControllerA=Get.find<ConfirmPasswordController>();


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
              controller: _passwordController,
              obscureText: !_isVisibilityPassword,
              decoration: inputDecorationIcon(
                'Password',
                Icon(_isVisibilityPassword ? Icons.visibility : Icons.visibility_off),
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _isVisibilityPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isVisibilityPassword = !_isVisibilityPassword;
                    });
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
              controller: _confirmPasswordController,
              obscureText: !_isVisibilityConfirmPassword,
              decoration: inputDecorationIcon(
                'Confirm Password',
                Icon(_isVisibilityConfirmPassword ? Icons.visibility : Icons.visibility_off),
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _isVisibilityConfirmPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isVisibilityConfirmPassword = !_isVisibilityConfirmPassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Re-enter the password';
                } else if (value != _passwordController.text.trim()) {
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
    return GetBuilder<ConfirmPasswordController>(builder: (controller){
      return Visibility(
        visible:_confirmPasswordControllerA.inProgress==false,
        replacement: circularProgressIndicatorWidget(),
        child: ElevatedButton(
          onPressed: () async{
            if (_formKey.currentState!.validate()) {
              await _confirmPasswordApiCallMethod();
            } else {
              errorToast('Password Enter the valid password');
            }
          },
          style: elevatedButton(),
          child: const Text('Submit'),
        ),
      );
    });
  }

  Future<void> _confirmPasswordApiCallMethod() async{
    bool isSuccess=await _confirmPasswordControllerA.confirmPasswordApiCallMethod(
        AuthController.userModel?.email??'',
        AuthController.userModel?.otp??'',
        _confirmPasswordController.text
    );

    if(isSuccess==true){
      try{
        _clearData();
        successToast('Password is updated!');
      }catch(e){
        errorToast(e.toString());
      }
    }
  }
void _clearData(){
    _passwordController.clear();
    _confirmPasswordController.clear();
}
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
