
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rest_api02/core/local%20data/auth_controller.dart';
import '../../../../Custom_Widgets/background_color_list_screen.dart';
import '../../../../Style/button_style.dart';
import '../../../../Style/circular_progress_indicator_widget.dart';
import '../../../../Style/color_style.dart';
import '../../../../Style/decoration_style.dart';
import '../../../../Style/text_message_style.dart';
import '../../../UI/Widgets/custom_container_widget.dart';
import '../../otp/screen/otp_screen.dart';
import '../../text controller/auth_text_controller.dart';
import '../controller/forget_password_api_controller.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static const String name = '/forget_password/email/pin_verification';


  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  @override
  void initState() {
    // TODO: implement initState
    authTextController.emailController.text =AuthController.userModel?.email??'';
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthTextController authTextController=Get.put(AuthTextController());
  final ForgetPasswordApiController forgetPasswordApiController=Get.put(ForgetPasswordApiController());

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
                  child:  Text("Your Email Address", style: head1Text(colorWhite)),
                ),
                const SizedBox(height: 30,),
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('A 6 digit verification pin will send to your email address',style: head6Text(colorGrey),),
            ),
                const SizedBox(height: 90),

                // Form section
                CustomContainerWidget(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _singInForm(),
                )),
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
          const SizedBox(height: 15,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: authTextController.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: inputDecoration('Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          _elevatedButton(),
          const SizedBox(height: 50),
          _goToLoginAlign(),
        ],
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
                  Navigator.pop(context);
                },
                child: Text('Sign In', style: buttonTextStyle(colorBlue)),
              ),
            ],
          ),
        );
  }

  Widget _elevatedButton() {
    return Visibility(
      visible: forgetPasswordApiController.isButtonVisible==false,
      replacement: circularProgressIndicatorWidget(),
      child: ElevatedButton(
            onPressed: () async{
              if (_formKey.currentState!.validate()) {
                await forgetPasswordApiController.forgetPasswordAPI();
                Navigator.pushNamed(context, OtpScreen.name);
              } else {
                 errorToast('Please input valid email address');
              }
            },
            child: customIconButton(),
            style: elevatedButton(),
          ),
    );
  }



  @override
  void dispose() {
    // TODO: implement dispose
    authTextController.emailController.dispose();
    super.dispose();
  }
}
