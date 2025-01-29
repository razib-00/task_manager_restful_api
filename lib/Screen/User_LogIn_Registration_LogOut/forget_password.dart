
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api02/API/Data%20Controller/Auth_Controller/auth_controller.dart';
import 'package:rest_api02/Screen/UI/Widgets/custom_container_widget.dart';
import '../../API/Data Controller/Task_Controller/forget_controller.dart';
import '../../Custom_Widgets/background_color_list_screen.dart';
import '../../Style/button_style.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/decoration_style.dart';
import '../../Style/text_message_style.dart';
import 'otp_screen.dart';


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
  _emailController.text =AuthController.userModel?.email??'';
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final ForgetController _forgetController=Get.find<ForgetController>();

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
            controller: _emailController,
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
    return GetBuilder<ForgetController>(builder: (controller){
      return Visibility(
        visible: controller.inProgress==false,
        replacement: circularProgressIndicatorWidget(),
        child: ElevatedButton(
          onPressed: () async{
            if (_formKey.currentState!.validate()) {
              await _forgetPasswordAPI();
              Navigator.pushNamed(context, OtpScreen.name);
            } else {
              errorToast('Please input valid email address');
            }
          },
          style: elevatedButton(),
          child: customIconButton(),
        ),
      );
    });
  }

  Future<void> _forgetPasswordAPI()async{
    bool isSuccess= await _forgetController.forgetPasswordAPI(_emailController.text);
    if(isSuccess==true){
      successToast('Email pin send your mail successfully. Pleas check your mail');
    }
    else{
      successToast('Email pin send Failed');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }
}
