import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_api02/API/Data%20Controller/auth_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_api02/API/Data%20Controller/network_request_response_data_controller.dart';
import 'package:rest_api02/API/Path_Directory/path_directory_page.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    _emailController.text=AuthController.userModel?.email??'';
    _firstNameController.text=AuthController.userModel?.fullName??'';
    _lastNameController.text=AuthController.userModel?.lastName??'';
    _phoneNumberController.text=AuthController.userModel?.mobile??'';
    super.initState();
  }
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  XFile? _pickedImage;
  bool _updateProfileInProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBarWidget(),
      body: BackgroundImageScreen(
          child: ListView(
            children: [Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
            children: [
              Text(
                'Update Profile',
                style: head1Text(colorGreen),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      _buildPhotoContainer(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _emailController,
                        enabled: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration('Email'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return errorToast('Please enter your email');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: inputDecoration('First Name'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return errorToast('Please enter your first name');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: inputDecoration('Last Name'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return errorToast('Please enter your last name');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.number,
                        decoration: inputDecoration('Mobil Number'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return errorToast('Please enter your mobile number');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        //enabled: false,
                        obscureText: true,
                        controller: _passwordController,
                        decoration: inputDecoration('Password'),

                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: _updateProfileInProgress==false,
                        replacement: circularProgressIndicatorWidget(),
                        child: ElevatedButton(
                          onPressed: () {
                            _updateProfileButtonMethod();
                          },
                          child: const Text('Update'),
                          style: elevatedButton(),
                        ),
                      )
                    ],
                  ))
            ],
                    ),
                  )],
          )),
    );
  }

  Widget _buildPhotoContainer() {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
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
                    bottomLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text(
                'Photo',
                style: head6Text(colorWhite),
              ),
            ),
            const SizedBox(width: 12,),
            Text(
              _pickedImage==null?'Image no found':_pickedImage!.name,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage()async {
    ImagePicker picker=ImagePicker();
    XFile? image=await picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        _pickedImage=image;
      });
    }
  }

  void _updateProfileButtonMethod() {
    if(_formKey.currentState!.validate()){
      _profileUpdateApiCall();
    }
  }

  Future<void> _profileUpdateApiCall()async {
    setState(() {
      _updateProfileInProgress=true;
    });
    Map<String,dynamic> profileMap={
      'email': _emailController.text.trim(),
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      "mobile":_phoneNumberController.text.trim(),
    };

    if(_pickedImage!=null){
      List<int> imageByte=await _pickedImage!.readAsBytes();
      profileMap['photo']=base64Encode(imageByte);
    }

    if(_passwordController.text.isNotEmpty){
      profileMap['password']=_passwordController.text;
    }
    debugPrint("$profileMap");

    final NetworkResponse response =await NetworkCall.postRequest(
        url: PathDirectoryUrls.profileUpdateUrl,
      body: profileMap
    );
    setState(() {
      _updateProfileInProgress=false;
    });
    if(response.isSuccess){
      _passwordController.clear();
      successToast("Profile Update Successful!");
    }else{
      errorToast("${response.statusCode}");
    }
  }
}
