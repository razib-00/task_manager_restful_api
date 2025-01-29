import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_api02/API/Data%20Controller/Auth_Controller/auth_controller.dart';
import '../../API/Data Controller/Task_Controller/profile_controller.dart';
import '../../Custom_Widgets/background_image.dart';
import '../../Style/button_style.dart';
import '../../Style/circular_progress_indicator_widget.dart';
import '../../Style/color_style.dart';
import '../../Style/decoration_style.dart';
import '../../Style/text_message_style.dart';
import '../UI/Widgets/task_manager_app_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String name = '/profile';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  XFile? _pickedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ProfileController _profileController = Get.find<ProfileController>();


  @override
  void initState() {
    super.initState();
    _emailController.text = AuthController.userModel?.email ?? '';
    _firstNameController.text = AuthController.userModel?.fullName ?? '';
    _lastNameController.text = AuthController.userModel?.lastName ?? '';
    _phoneNumberController.text = AuthController.userModel?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Column(
              children: [
                Text('Update Profile', style: head1Text(colorGreen)),
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 20,
                    children: [
                      const SizedBox(height: 20),
                      _buildPhotoContainer(),
                      _buildTextField(_emailController, 'Email', false, true),
                      _buildTextField(_firstNameController, 'First Name', true, false),
                      _buildTextField(_lastNameController, 'Last Name', true, false),
                      _buildTextField(_phoneNumberController, 'Mobile Number', true, false, keyboardType: TextInputType.number),
                      _buildTextField(_passwordController, 'Password', false, false, obscureText: true),
                      const SizedBox(height: 20),
                      GetBuilder<ProfileController>(builder: (controller){
                        return Visibility(
                          visible: controller.inProgress==false,
                          replacement: circularProgressIndicatorWidget(),
                          child: ElevatedButton(
                            onPressed: _updateProfileButtonMethod,
                            style: elevatedButton(),
                            child: const Text('Update'),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoContainer() {
    return GestureDetector(
      onTap: _pickImage,
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
                  bottomLeft: Radius.circular(5),
                ),
              ),
              alignment: Alignment.center,
              child: Text('Photo', style: head6Text(colorWhite)),
            ),
            const SizedBox(width: 12),
            Text(
              _pickedImage == null ? 'Image not found' : _pickedImage!.name,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool isRequired, bool isDisabled, {TextInputType keyboardType = TextInputType.text, bool obscureText = false})
  {
    return TextFormField(
      controller: controller,
      enabled: !isDisabled,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: inputDecoration(label),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _pickedImage = image);
    }
  }

  void _updateProfileButtonMethod() {
    if (_formKey.currentState!.validate()) {
      _profileUpdateApiCall();
    }
  }

  Future<void> _profileUpdateApiCall() async {
    bool isSuccess=await _profileController.profileUpdateApiCall(
         _emailController.text.trim(),
     _firstNameController.text.trim(),
     _lastNameController.text.trim(),
     _phoneNumberController.text.trim(),
     _passwordController.text.isNotEmpty?_passwordController.text:null,
     _pickedImage != null? base64Encode(await _pickedImage!.readAsBytes()) : null
    );

    if (isSuccess) {
      _passwordController.clear();
      successToast("Profile Update Successful!");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
