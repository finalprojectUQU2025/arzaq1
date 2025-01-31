import 'package:arzaq_app/api_controller/auth_api_controller.dart';
import 'package:arzaq_app/prefs/shared_pref_controller.dart';
import 'package:arzaq_app/screens/auth_screens/login_screen.dart';
import 'package:arzaq_app/utils/app_colors.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/custome_app_text.dart';
import 'ContactUs-MarChant.dart';


class ProfileScreen_Marchant extends StatefulWidget {
  @override
  _ProfileScreen_MarchantState createState() => _ProfileScreen_MarchantState();
}

class _ProfileScreen_MarchantState extends State<ProfileScreen_Marchant> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFACC),
      body: ListView(

        children: [
          SizedBox(height: 30.h,),

          Center(
            child: Image.asset(
              'assets/images/appLogo.png',
              width: 72.w,
              height: 72.h,
            ),
          ),
          SizedBox(height: 24.h,),

          Container(
            width: 390.w,
            height: 724.h,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(48.r),
                  topRight: Radius.circular(48.r),
                ),
              ),
              shadows: [
                const BoxShadow(
                  color: Color(0x3FD1D1D1),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                  spreadRadius: 0,
                )
              ],
            ),

            child: Column(
              children: [
                SizedBox(height: 37.h,),

                Container(
                  width: 72.w,
                  height: 72.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(64.r),
                    ),
                  ),
                    child: SharedPrefController().getValueFor(key: PrefKeys.image.name)!= null?FadeInImage.assetNetwork(
                      placeholder:
                      'assets/images/businessman.png',
                      image: SharedPrefController().getValueFor(key: PrefKeys.image.name),
                      fit: BoxFit.fill,
                    ):SizedBox()
                ),
                SizedBox(height: 8.h,),
                AppText(
                  text: SharedPrefController().getValueFor(key: PrefKeys.name.name)??'',
                  color: Colors.black,
                  fontSize: 16,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,),
                SizedBox(height: 8.h,),
                AppText(
                  text: SharedPrefController().getValueFor(key: PrefKeys.email.name)??'',
                  color: Colors.black,
                  fontSize: 14,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,),
                SizedBox(height: 4.h,),
                AppText(
                  text: SharedPrefController().getValueFor(key: PrefKeys.phone.name)??'',
                  color: Colors.black,
                  fontSize: 14,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,


                ),
                SizedBox(height: 16.h,),
                Container(
                  width: 380.w,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.6,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFCCCCCC),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const Contactus_MarchantScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SvgPicture.asset(
                            'assets/images/contact.svg',),
                          SizedBox(width: 10.w,),
                          const AppText(
                            text: 'تواصل معنا',
                            color: Color(0xFF222222),
                            fontSize: 14,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w500,


                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_outlined,size: 13,color: Colors.black,),




                        ],
                      ),
                  ),
                ),
                Container(
                  width: 380.w,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.6,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFCCCCCC),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: () async{
                    await _showLogOutDialog(context);
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 28.0.w,vertical: 28.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/log-out.svg',),
                        SizedBox(width: 10.w,),
                        const AppText(
                          text: 'تسجيل خروج',
                          color: Color(0xFF222222),
                          fontSize: 14,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          )





        ],
      ),


    );
  }
  Future<void> _showLogOutDialog(BuildContext context) async {
    showDialog(
        context: context,
        barrierColor: Colors.white60,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 6,
            insetPadding: EdgeInsets.zero,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
                side:  const BorderSide(color: AppColors.primaryColor)
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(text: 'هل انت متأكد من تسجيل الخروج ؟'),
                SizedBox(height: 24.h,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: BorderSide(width: 1.w,color:  AppColors.primaryColor),
                              elevation: 0
                          ),
                          onPressed: () async{
                            setState((){
                              isLoading =true;
                            });
                            bool apiResponse =  await AuthApiController().logout();
                            if(apiResponse == true){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);
                            }else{
                              context.showSnackBar(message: 'عذرا حصل خطأ ما!',error: true);
                            }
                            setState((){
                              isLoading =false;
                            });
                          }, child: const Center(child: AppText(text: 'نعم',fontWeight: FontWeight.w600,color:  Color(0XFF00ADEF),))),
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide(width: 1.w,color: AppColors.primaryColor),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }, child: const Center(child: AppText(text: 'لا',fontWeight: FontWeight.w600,color:  Colors.red,))),
                    ),

                  ],
                )
              ],
            ),
          );
        });
  }
}