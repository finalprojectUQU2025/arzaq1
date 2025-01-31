import 'package:arzaq_app/api_controller/auth_api_controller.dart';
import 'package:arzaq_app/main.dart';
import 'package:arzaq_app/prefs/shared_pref_controller.dart';
import 'package:arzaq_app/screens/auth_screens/forget_password_screens/forget_password_screen.dart';
import 'package:arzaq_app/screens/auth_screens/register_screen.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:arzaq_app/utils/app_colors.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:arzaq_app/widgets/app_elevated_button.dart';
import 'package:arzaq_app/widgets/app_text_field.dart';
import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_app_loading.dart';
import '../Marchant/NavegatorBar-Marchant.dart';
import '../Supply/NavegatorBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  final FocusNode _firstNode = FocusNode();
  final FocusNode _passNode = FocusNode();
 /* late FocusNode _firstNode;
  late FocusNode _passNode;*/
  bool _emailFocused = false;
  bool _passwordFocused = false;
  bool obscure = true;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*_firstNode = FocusNode();
    _passNode = FocusNode();*/
    _firstNode.addListener(() {
      setState(() {
        _emailFocused = _firstNode.hasFocus;
      });
    });
    _passNode.addListener(() {
      setState(() {
        _passwordFocused = _passNode.hasFocus;
      });
    });
    _tabController = TabController(length: 2, vsync: this);
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();

  }

  @override
  void dispose() {
    _tabController.dispose();
    /*_firstNode.dispose();
    _passNode.dispose();*/
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
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
                Center(
                  child: Image.asset(
                    'assets/images/appLogo.png',
                    width: 90.w,
                    height: 90.h,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                const AppText(
                  text: 'تسجيل الدخول',
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 36.h,
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
                  hintText: 'اكتب البريد الالكتروني هنا',
                  focusNode: _firstNode,
                  onChanged: (p0) {
                   /* _firstNode.addListener(() {
                      setState(() {
                        _emailFocused = _firstNode.hasFocus;
                      });
                    });*/
                  },
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
                  height: 24.h,
                ),
                const AppText(
                  text: 'كلمة المرور',
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
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordScreen(),));
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerEnd,
                      child: AppText(text: 'نسيت كلمة المرور',fontSize: 12,color: Color(0XFF767676),)),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 80.w),
                  child: AppElevatedButton(
                    text: 'تسجيل الدخول',
                    height: 46,
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      await _performLogin();
                      setState(() {
                        isLoading = false;
                      });
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   BottomNavBar(),));
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   BottomNavBarMarchant(),));
                  },),
                ),
                SizedBox(
                  height: 39.h,
                ),
                Row(
                  children: [
                    Expanded(child: Divider(height: 0.h,thickness: 1,color: const Color(0XFFEAEAEA),)),
                    SizedBox(width: 27.w,),
                    const AppText(text: 'أو',fontSize: 14,color: Color(0XFF9A9A9A),),
                    SizedBox(width: 27.w,),
                    Expanded(child: Divider(height: 0.h,thickness: 1,color: const Color(0XFFEAEAEA),)),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'ليس لديك حساب؟',
                            style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: " أنشئ حسابك الآن",
                            style: GoogleFonts.tajawal(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
  Future _performLogin() async {
    if (checkData()) {
      await _login();
    }
  }

  bool checkData() {
    if (_emailTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(
        message: 'الرجاء ادخل البيانات المطلوبة!', error: true);
    return false;
  }

  Future<void> _login() async {
   ApiResponse apiResponse = await AuthApiController().login(
     email: _emailTextEditingController.text,
     password: _passwordTextEditingController.text,
   );
   if (apiResponse.success) {
     SharedPrefController().getValueFor(key: PrefKeys.type.name)=='mazarie'?
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBar(),), (route) => false):

     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBarMarchant(),), (route) => false);
   }
   context.showSnackBar(
     message: apiResponse.message,
     error: !apiResponse.success,
   );

  }
}
