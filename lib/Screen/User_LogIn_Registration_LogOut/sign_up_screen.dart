import 'package:flutter/material.dart';
import 'package:rest_api02/Screen/UI/Widgets/custom_container_widget.dart';

import '../../API/Data Controller/network_request_response_data_controller.dart';
import '../../API/Path_Directory/path_directory_page.dart';
import '../../API/error_screen/error_page.dart';
import '../../Custom_Widgets/background_color_list_screen.dart';
import '../../Style/button_style.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/decoration_style.dart';
import '../../Style/text_message_style.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign_up_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isVisibility = false;
  bool _isButtonVisibility = false;

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
                  child: Text("Create Your\n Account!",
                      style: head1Text(colorWhite)),
                ),
                const SizedBox(height: 90),

                // Form section
                CustomContainerWidget(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _signInForm(),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _signInForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: inputDecoration('Email'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your  email';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _firstNameController,
            decoration: inputDecoration('First Name'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter a valid first name';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _lastNameController,
            decoration: inputDecoration('Last Name'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter a valid last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            controller: _phoneController,
            decoration: inputDecoration('Phone'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter a valid phone';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordController,
            obscureText: !_isVisibility,
            decoration: inputDecoration('Password').copyWith(
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
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter a valid password';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          _elevatedButton(),
          const SizedBox(height: 20),
          _goToLoginAlign(),
        ],
      ),
    );
  }

  Widget _elevatedButton() {
    return Visibility(
      visible: _isButtonVisibility == false,
      replacement: circularProgressIndicatorWidget(),
      child: ElevatedButton(
        onPressed: () {
          _registrationButton();
        },
        child: const Text('Sign Up'),
        style: elevatedButton(),
      ),
    );
  }

  Widget _goToLoginAlign() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Have an account?", style: head6Text(colorGreen)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Sign In', style: buttonTextStyle(colorBlue)),
          ),
        ],
      ),
    );
  }

  void _clearText() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _passwordController.clear();
  }

  Future<void> _postRegistration() async {
    _isButtonVisibility = true;
    setState(() {});

    Map<String, dynamic> registrationRequestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _phoneController.text.trim(),
      "password": _passwordController.text,
      "photo": "",
    };

    final NetworkResponse response = await NetworkCall.postRequest(
        url: PathDirectoryUrls.registrationUrl, body: registrationRequestBody);
    _isButtonVisibility = false;
    setState(() {});

    if (response.isSuccess) {
      _clearText();
      Navigator.pushReplacementNamed(context, LoginScreen.name);
      successToast('SignUP Successful');
    } else {
      ErrorPage.throwError;
    }
  }

  void _registrationButton() {
    if (_formKey.currentState!.validate()) {
      _postRegistration();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    // Cancel any other long-running tasks here.
    super.dispose();
  }
}
