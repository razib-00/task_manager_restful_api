import 'package:flutter/material.dart';
import 'package:rest_api02/API_Model/user_model.dart';
import 'package:rest_api02/Screen/User_LogIn_Registration_LogOut/sign_up_screen.dart';
import '../../API/Data Controller/auth_controller.dart';
import '../../API/Data Controller/network_request_response_data_controller.dart';
import '../../API/Path_Directory/path_directory_page.dart';
import '../../API/error_screen/error_page.dart';
import '../../Custom_Widgets/background_color_list_screen.dart';
import '../../Style/button_style.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/decoration_style.dart';
import '../../Style/text_message_style.dart';
import '../UI/Bottom & Drawer/bottom_navigation_bar.dart';
import '../UI/Widgets/custom_container_widget.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isVisibility = false;
  final bool _isButtonVisibility = false;

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
            controller: _emailController,
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
            controller: _passwordController,
            obscureText: !_isVisibility,
            decoration: inputDecorationIcon(
              'Password',
              Icon(
                _isVisibility ? Icons.visibility : Icons.visibility_off,
              ),
            ).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _isVisibility ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isVisibility = !_isVisibility;
                  });
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
      visible: _isButtonVisibility == false,
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

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginPostRequester() async {
    _isButtonVisibility == true;
    setState(() {});

    Map<String, dynamic> loginResponseBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text
    };
    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.loginUrl, body: loginResponseBody);

    if (response.isSuccess) {

      String token=response.responseData!["token"];
      UserModel userModel=UserModel.fromJson(response.responseData!["data"]);
      await AuthController.setUserData(token,userModel);

      Navigator.pushReplacementNamed(context, BottomNavigationBarScreen.name);
      successToast('Login successful');
    } else {
      _isButtonVisibility == false;
      setState(() {});
      ErrorPage.throwError;
    }
  }

  void _loginElevatedButton() {
    if (_formKey.currentState!.validate()) {
      _loginPostRequester();
    }
  }
}
