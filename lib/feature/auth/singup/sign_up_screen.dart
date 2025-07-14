import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Custom_Widgets/background_color_list_screen.dart';
import '../../../Style/button_style.dart';
import '../../../Style/circular_progress_indicator_widget.dart';
import '../../../Style/color_style.dart';
import '../../../Style/decoration_style.dart';
import '../../../Style/text_message_style.dart';
import '../../UI/Widgets/custom_container_widget.dart';
import '../text controller/auth_text_controller.dart';
import 'controller/sing_up_api_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign_up_screen';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final AuthTextController authTextController = Get.put(AuthTextController());
    final SignUpApiController signUpApiController = Get.put(SignUpApiController());

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
                CustomContainerWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _textField(authTextController.emailController, 'Email',
                              TextInputType.emailAddress, 'Enter Your email'),
                          const SizedBox(height: 15),
                          _textField(authTextController.firstNameController,
                              'First Name', TextInputType.text, 'Enter first name'),
                          const SizedBox(height: 15),
                          _textField(authTextController.lastNameController,
                              'Last Name', TextInputType.text, 'Enter last name'),
                          const SizedBox(height: 15),
                          _textField(authTextController.phoneController, 'Phone',
                              TextInputType.number, 'Enter phone number'),
                          const SizedBox(height: 15),
                          GetBuilder<SignUpApiController>(
                            builder: (_) => TextFormField(
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              controller:
                              authTextController.passwordController,
                              obscureText: !signUpApiController.isVisibility,
                              decoration: inputDecoration('Password').copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    signUpApiController.isVisibility
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    signUpApiController.toggleVisibility();
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
                          ),
                          const SizedBox(height: 30),
                          GetBuilder<SignUpApiController>(
                            builder: (_) => Visibility(
                              visible: !signUpApiController.isButtonVisibility,
                              replacement: circularProgressIndicatorWidget(),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signUpApiController.postRegistration();
                                  }
                                },
                                child: const Text('Sign Up'),
                                style: elevatedButton(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Have an account?",
                                    style: head6Text(colorGreen)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Sign In',
                                      style: buttonTextStyle(colorBlue)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(TextEditingController controller, String hint,
      TextInputType type, String validationMessage) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: type,
      decoration: inputDecoration(hint),
      validator: (String? value) {
        if (value?.trim().isEmpty ?? true) {
          return validationMessage;
        }
        return null;
      },
    );
  }
}
