import 'package:arzaq_app/api_controller/auth_api_controller.dart';
import 'package:arzaq_app/screens/auth_screens/login_screen.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/custome_app_text.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({required this.email,super.key});
final String email;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _confPasswordTextEditingController;
  final FocusNode _passNode = FocusNode();
  final FocusNode _confPassNode = FocusNode();
  bool _passwordFocused = false;
  bool _confPasswordFocused = false;
  bool obscure = true;
  bool obscure1 = true;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passNode.addListener(() {
      setState(() {
        _passwordFocused = _passNode.hasFocus;
      });
    });
    _confPassNode.addListener(() {
      setState(() {
        _confPasswordFocused = _confPassNode.hasFocus;
      });
    });
    _passwordTextEditingController = TextEditingController();
    _confPasswordTextEditingController = TextEditingController();
  }
  @override
  void dispose() {
    _passwordTextEditingController.dispose();
    _confPasswordTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/appLogo.png',
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                const AppText(
                  text: 'اعادة تعيين كلمة المرور',
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 48.h,
                ),
                const AppText(
                  text: 'كلمة المرور الجديدة',
                  color: Color(0XFF616161),
                  fontSize: 14,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppTextField(
                  controller: _passwordTextEditingController,
                  hintText: 'اكتب كلمة المرور هنا',
                  focusNode: _passNode,
                  onChanged: (p0) {
                    /*  _passNode.addListener(() {
                      setState(() {
                        _passwordFocused = _passNode.hasFocus;
                      });
                    });*/
                  },
                  height: 56,
                  maxLines: 1,
                  obscure: obscure,
                  prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 14.h),
                    child: SvgPicture.asset(
                      'assets/images/lock.svg',

                      colorFilter:
                      ColorFilter.mode(_passwordFocused ?AppColors.primaryColor:const Color(0XFFA7A9B7), BlendMode.srcIn),
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric( vertical: 16.h),
                      child: SvgPicture.asset(
                        obscure?'assets/images/eyeClosed.svg':'assets/images/eyeOutline.svg',
                        height: 24.h,
                        //eyeClosed
                        width: 24.w,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 18.h,),
                const AppText(
                  text: 'تأكيد كلمة المرور ',
                  color: Color(0XFF616161),
                  fontSize: 14,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppTextField(
                  controller: _confPasswordTextEditingController,
                  hintText: 'اكتب كلمة المرور الجديدة مرة أخرى هنا',
                  focusNode: _confPassNode,
                  onChanged: (p0) {
                    /*  _passNode.addListener(() {
                      setState(() {
                        _passwordFocused = _passNode.hasFocus;
                      });
                    });*/
                  },
                  height: 56,
                  maxLines: 1,
                  obscure: obscure1,
                  prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 14.h),
                    child: SvgPicture.asset(
                      'assets/images/lock.svg',

                      colorFilter:
                      ColorFilter.mode(_confPasswordFocused ?AppColors.primaryColor:const Color(0XFFA7A9B7), BlendMode.srcIn),
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscure1 = !obscure1;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric( vertical: 16.h),
                      child: SvgPicture.asset(
                        obscure1?'assets/images/eyeClosed.svg':'assets/images/eyeOutline.svg',
                        height: 24.h,
                        //eyeClosed
                        width: 24.w,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(
                  height: 33.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 96.w),
                  child: AppElevatedButton(
                    text: 'تأكيد',
                    height: 46,
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                     await _performResetPassword();
                      setState(() {
                        isLoading = false;
                      });
                    },),
                ),
              ],
            ),
            Visibility(
                visible: isLoading == true,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:
                  BoxDecoration(color: Colors.white.withOpacity(0.6)),
                  child: SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: const Center(child: SizedBox())),
                ))
          ],
        ),
      ),
    );
  }
  Future<void> _performResetPassword() async{
    if(checkData()){
      await _resetPassword();
    }
  }
  bool checkData(){
    if(_passwordTextEditingController.text.isNotEmpty&&_confPasswordTextEditingController.text.isNotEmpty){
      if(_passwordTextEditingController.text==_confPasswordTextEditingController.text){
        return true;
      }else{
        context.showSnackBar(message: 'كلمة المرور غير متطابقة',error: true);
        return false;
      }

    }else{
      context.showSnackBar(message: 'الرجاء ادخال كلمة المرور!',error: true);
      return false;
    }
  }
  Future<void> _resetPassword() async{
    ApiResponse apiResponse = await AuthApiController().resetPassword(email: widget.email, password: _passwordTextEditingController.text, passwordConfirmation: _confPasswordTextEditingController.text);
    if(apiResponse.success){
      context.showSnackBar(message: apiResponse.message);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);
    }else{
      context.showSnackBar(message: apiResponse.message,error: true);
    }
  }
}
