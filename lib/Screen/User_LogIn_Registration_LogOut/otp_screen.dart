import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rest_api02/API/Data%20Controller/auth_controller.dart';
import 'package:rest_api02/API/Data%20Controller/network_request_response_data_controller.dart';
import 'package:rest_api02/API/Path_Directory/path_directory_page.dart';
import 'package:rest_api02/Screen/UI/Widgets/custom_container_widget.dart';
import '../../API_Model/password_recover_email_o_t_p_model.dart';
import '../../API_Model/user_model.dart';
import '../../Custom_Widgets/background_color_list_screen.dart';
import '../../Style/button_style.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/text_message_style.dart';
import 'conform_password.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  static const String name='/email_otp';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final TextEditingController _otpController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final bool _isButtonVisible=false;
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
                  const SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text('PIN Verification',style: head1Text(colorWhite)),
                   ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('A 6 digit verification pin will send to your email address',style: head6Text(colorGrey)),
                  ),
                  const SizedBox(height: 90,),
                  CustomContainerWidget(child: _pinInputForm(context)),
                ],
              )
          ),
        ),
      ),
    );
  }

  Form _pinInputForm(BuildContext context) {
    return Form(
      key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: PinCodeTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _otpController,
                  keyboardType:TextInputType.number,
                  appContext: context,
                  length: 6,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 40,
                      borderWidth:5 ,
                      fieldWidth:50,
                      activeFillColor: colorWhite,
                      inactiveFillColor: colorWhite,
                      selectedFillColor: colorWhite
                  ),
                  onChanged: (value){

                  },
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  obscureText: false,
                  cursorColor: colorWhite,
                ),
              ),
              const SizedBox(height: 20),
              _elevatedButton(context),
              const SizedBox(height: 50),
              _goToLoginAlign(context),
            ],
          ),
        )
    );
  }

  Widget _elevatedButton(BuildContext context) {
    return Visibility(
      visible: _isButtonVisible==false,
      replacement: circularProgressIndicatorWidget(),
      child: ElevatedButton(
        onPressed: () async{
          if (_formKey.currentState!.validate()) {
                await _otpApiCallMethod();
                Navigator.pushNamed(context, ConfirmPassword.name);
              } else {
                 errorToast('Please enter valid pin');
              }
          },
        child:  customIconButton(),
        style: elevatedButton(),
      ),
    );
  }

  Align _goToLoginAlign(BuildContext context) {
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

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _otpApiCallMethod() async {
    _isButtonVisible==true;
    setState(() {});
    String tempOTP = _otpController.text;
    //AuthController.userModel?.otp
    final NetworkResponse response = await NetworkCall.getRequest(
        url: PathDirectoryUrls.recoverEmailOTPUrl(
            "${AuthController.userModel?.email}", tempOTP));
    if (response.isSuccess) {
      PasswordRecoverEmailOTPModel passwordRecoverEmailOTPModel = PasswordRecoverEmailOTPModel.fromJson(response.responseData);
      UserModel? userModel = AuthController.userModel;
      if(userModel != null && passwordRecoverEmailOTPModel.status == "success"){
        userModel.otp = tempOTP;
        await AuthController.setUserData(AuthController.accessKey ?? "", userModel);
      }
      successToast("OTP update successfully");
    } else {
      errorToast("OTP update failed");
    }
    _isButtonVisible==false;
    setState(() {});
  }
}
