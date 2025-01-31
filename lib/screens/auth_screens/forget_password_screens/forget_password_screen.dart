import 'package:arzaq_app/api_controller/auth_api_controller.dart';
import 'package:arzaq_app/main.dart';
import 'package:arzaq_app/screens/auth_screens/forget_password_screens/verification_forget_code_screen.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:arzaq_app/widgets/custom_app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/custome_app_text.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _emailTextEditingController;
  final FocusNode _firstNode = FocusNode();
  bool _emailFocused = false;
  bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextEditingController = TextEditingController();
    _firstNode.addListener(() {
      setState(() {
        _emailFocused = _firstNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/appLogo.png',
                        width: 100.w,
                        height: 100.h,
                      ),
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back))
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                const AppText(
                  text: 'نسيت كلمة المرور؟',
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40.h,
                ),
                const AppText(
                  text: 'سيتم ارسال كود التحقق لك عن طريق البريد الالكتروني الخاص بك',
                  color: Colors.black,
                  fontSize: 13,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24.h,
                ),
                const AppText(
                  text: 'البريد الالكتروني',
                  color: Color(0XFF616161),
                  fontSize: 14,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppTextField(
                  controller: _emailTextEditingController,
                  hintText: 'moh@gmail.com',
                  focusNode: _firstNode,
                  height: 56,
                  maxLines: 1,
                  prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 14.h),
                    child: SvgPicture.asset(
                      'assets/images/emailIcon.svg',

                      colorFilter:
                      ColorFilter.mode(_emailFocused ?AppColors.primaryColor:const Color(0XFFA7A9B7), BlendMode.srcIn),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 80.w),
                  child: AppElevatedButton(
                    text: 'التالي',
                    height: 46,
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      _performSendCode();
                      setState(() {
                        isLoading = false;
                      });
                    },),
                ),
              ],
            ),
            Visibility(
                visible: isLoading == true,
                child: const CustomAppLoading()),
          ],
        ),
      ),
    );
  }
  Future<void> _performSendCode() async{
    if(checkData()){
      await _sendCode();
    }
  }

  bool checkData(){
    if(_emailTextEditingController.text.isNotEmpty){
      return true;
    }else{
      context.showSnackBar(message: 'الرجاء ادخال البريد الالكتروني!',error: true);
      return false;
    }
  }
  Future<void> _sendCode() async{
    ApiResponse apiResponse = await AuthApiController().sendForgetPasswordCode(email: _emailTextEditingController.text);
    if(apiResponse.success){
      context.showSnackBar(message: apiResponse.message);
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationForgetCodeScreen(email: _emailTextEditingController.text, code: apiResponse.object),));
    }else{
      context.showSnackBar(message: apiResponse.message,error: true);
    }
  }
}
