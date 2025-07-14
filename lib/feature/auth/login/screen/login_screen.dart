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
import '../../fontget password/screen/forget_password.dart';
import '../../singup/sign_up_screen.dart';
import '../../text controller/auth_text_controller.dart';
import '../controller/login_api_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginApiController loginApiController=Get.put(LoginApiController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 final AuthTextController authTextController=Get.put(AuthTextController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BackgroundColorListScreen(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Hello\n Sign in!", style: head1Text(colorWhite)),
                ),
                const SizedBox(height: 90),

                // Form section
                CustomContainerWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _singInForm(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _singInForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: authTextController.emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: inputDecoration('Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: authTextController.passwordController,
            obscureText: !loginApiController.isVisibility,
            decoration: inputDecorationIcon(
              'Password',
              Icon(
                loginApiController.isVisibility ? Icons.visibility : Icons.visibility_off,
              ),
            ).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  loginApiController.isVisibility ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  loginApiController.toggleVisibility();
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid password';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          _goToForgetPasswordAlign(),
          const SizedBox(height: 20),
          _elevatedButton(),
          const SizedBox(height: 40),
          _goToSignUpAlign(),
        ],
      ),
    );
  }

  Align _goToForgetPasswordAlign() {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, ForgetPassword.name);
        },
        child: Text('Forgot Password?', style: buttonTextStyle(colorBlue)),
      ),
    );
  }

  Widget _elevatedButton() {
    return Visibility(
      visible: loginApiController.isButtonVisibility == false,
      replacement: circularProgressIndicatorWidget(),
      child: ElevatedButton(
        onPressed: () {
          _loginElevatedButton();
        },
        child: const Text('Sign In'),
        style: elevatedButton(),
      ),
    );
  }

  Align _goToSignUpAlign() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Don't have an account?", style: head6Text(colorNaveBlue)),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, SignUpScreen.name);
            },
            child: Text('Sign Up', style: buttonTextStyle(colorBlue)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    authTextController.emailController.dispose();
    authTextController.passwordController.dispose();
    super.dispose();
  }



  void _loginElevatedButton() {
    if (_formKey.currentState!.validate()) {
      loginApiController.loginPostRequester();
    }
  }
}
