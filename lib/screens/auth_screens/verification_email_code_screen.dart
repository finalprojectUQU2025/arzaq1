import 'dart:async';

import 'package:arzaq_app/api_controller/auth_api_controller.dart';
import 'package:arzaq_app/screens/auth_screens/forget_password_screens/reset_password_screen.dart';
import 'package:arzaq_app/screens/auth_screens/login_screen.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:arzaq_app/widgets/custom_app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/custome_app_text.dart';
import '../../../widgets/timer_widget.dart';

class VerificationEmailCodeScreen extends StatefulWidget {
  const VerificationEmailCodeScreen({Key? key,required this.code,required this.email}) : super(key: key);
 final String code;
 final String email;
  @override
  State<VerificationEmailCodeScreen> createState() => _VerificationEmailCodeScreenState();
}

class _VerificationEmailCodeScreenState extends State<VerificationEmailCodeScreen> {
  late FocusNode _firstNode;
  late FocusNode _secondNode;
  late FocusNode _thirdNode;
  late FocusNode _fourthNode;
  late FocusNode _fifthNode;
  late TextEditingController _firstEditingController;
  late TextEditingController _secondEditingController;
  late TextEditingController _thirdEditingController;
  late TextEditingController _fourthEditingController;
  late TextEditingController _fifthEditingController;
  bool resendCode = false;
  bool tapped = false;
  // bool allFieldFull=false;
  List<int> allFieldFull= <int>[];
  late var timer;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _firstNode = FocusNode();
    _secondNode = FocusNode();
    _thirdNode = FocusNode();
    _fourthNode = FocusNode();
    _fifthNode = FocusNode();
    _firstEditingController = TextEditingController();
    _secondEditingController = TextEditingController();
    _thirdEditingController = TextEditingController();
    _fourthEditingController = TextEditingController();
    _fifthEditingController = TextEditingController();
    if (mounted) {
      timer =  Timer.periodic(const Duration(seconds: 120), (Timer t) => setState(() {
        resendCode = true;
      }));
    }
  }

  @override
  void dispose() {
    _firstNode.dispose();
    _secondNode.dispose();
    _thirdNode.dispose();
    _fourthNode.dispose();
    _fifthNode.dispose();
    _firstEditingController.dispose();
    _secondEditingController.dispose();
    _thirdEditingController.dispose();
    _fourthEditingController.dispose();
    _fifthEditingController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back))
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const AppText(
                    text: 'كود التحقق',
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  const AppText(
                    text: 'الرجاء التحقق من بريدك الالكتروني, أدخل كود التحقق هنا ',
                    color: Colors.black,
                    fontSize: 13,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Row(
                      children: [
                        Expanded(
                            child: AppTextField(
                              height: 66.h,
                              width: 66.w,
                              controller: _firstEditingController,
                              focusNode: _firstNode,
                              maxLength: 1,
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: false, signed: false),
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  height: 1.h,
                                  fontSize: 22),
                              onChanged: (String value) {
                                if (value.isNotEmpty){
                                  _secondNode.requestFocus();
                                  setState(() {
                                    allFieldFull.add(1);
                                  });
                                } else{
                                  setState(() {
                                    allFieldFull.remove(1);
                                  });
                                }
                              },
                            )),
                        SizedBox(
                          width: 11.7.w,
                        ),
                        Expanded(
                            child: AppTextField(
                              height: 66.h,
                              width: 66.w,
                              controller: _secondEditingController,
                              focusNode: _secondNode,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: false, signed: false),
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  height: 1.h,
                                  fontSize: 22),
                              onChanged: (String value) {
                                if(value.isNotEmpty){
                                  _thirdNode.requestFocus();
                                  setState(() {
                                    allFieldFull.add(2);
                                  });
                                }else{
                                  _firstNode.requestFocus();
                                  setState(() {
                                    allFieldFull.remove(2);
                                  });
                                }
                              },
                            )),
                        SizedBox(
                          width: 11.7.w,
                        ),
                        Expanded(
                            child: AppTextField(
                              height: 66.h,
                              width: 66.w,
                              controller: _thirdEditingController,
                              focusNode: _thirdNode,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: false, signed: false),
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  height: 1.h,
                                  fontSize: 22),
                              onChanged: (String value) {
                                if(value.isNotEmpty){
                                  _fourthNode.requestFocus();
                                  setState(() {
                                    allFieldFull.add(3);
                                  });
                                }else{
                                  _secondNode.requestFocus();
                                  setState(() {
                                    allFieldFull.remove(3);
                                  });
                                }
                              },
                            )),
                        SizedBox(
                          width: 11.7.w,
                        ),
                        Expanded(
                            child: AppTextField(
                              height: 66.h,
                              width: 66.w,
                              controller: _fourthEditingController,
                              focusNode: _fourthNode,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: false, signed: false),
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  height: 1.h,
                                  fontSize: 22),
                              onChanged: (String value) {
                                if(value.isNotEmpty){
                                  _fifthNode.requestFocus();
                                  setState(() {
                                    allFieldFull.add(4);
                                  });
                                }else{
                                  _thirdNode.requestFocus();
                                  setState(() {
                                    allFieldFull.remove(4);
                                  });
                                }
                              },
                            )),
                        SizedBox(
                          width: 11.7.w,
                        ),
                        Expanded(
                            child: AppTextField(
                              height: 66.h,
                              width: 66.w,
                              controller: _fifthEditingController,
                              focusNode: _fifthNode,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: false, signed: false),
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  height: 1.h,
                                  fontSize: 22),
                              onChanged: (String value) {
                                if(value.isEmpty){
                                  _fourthNode.requestFocus();
                                  setState(() {
                                    allFieldFull.remove(5);
                                  });
                                }else{
                                  setState(() {
                                    allFieldFull.add(5);
                                  });

                                }

                              },
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  resendCode
                      ? const AppText(
                    text: '00:0',
                    color: Color(0XFFF75555),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  )
                      : TimerWidget(),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        text: 'لم تستلم كود التحقق؟',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFFA7A9B7),
                      ),
                      Visibility(
                        visible: resendCode,
                        replacement: const AppText(
                          text: 'أرسل الكود مرة أخرى',
                          fontSize: 14,
                          color: Color(0XFFA7A9B7),
                        ),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await _reSendPhone();
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const AppText(
                            text: ' أرسل الكود مرة أخرى',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 94.w),
                    child: AppElevatedButton(
                      text: 'التالي',
                      height: 50,
                      backgroundColor:  allFieldFull.length==5?AppColors.primaryColor:const Color(0XFFD8D8D8),
                      onPressed: () async{
                        if(allFieldFull.length==5){
                          setState(() {
                            isLoading = true;
                          });
                          await _sendCode();
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                  )
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
      ),
    );
  }





  Future<void> _sendCode() async {
    ApiResponse apiResponse = await AuthApiController().checkCodeVerification(
        email: widget.email,
      code: _firstEditingController.text+_secondEditingController.text+_thirdEditingController.text+_fourthEditingController.text+_fifthEditingController.text
    );
    if (apiResponse.success) {
      context.showSnackBar(message: apiResponse.message,error: !apiResponse.success);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);
    } else {
      context.showSnackBar(
          message: apiResponse.message, error: !apiResponse.success);
    }
  }
  Future<void> _reSendPhone() async {
    ApiResponse apiResponse = await AuthApiController().reSendMobileNumber(email: widget.email);
    if (apiResponse.success) {
/*      _firstEditingController.text = apiResponse.object.split('')[0];
      _secondEditingController.text = apiResponse.object.split('')[1];
      _thirdEditingController.text = apiResponse.object.split('')[2];
      _fourthEditingController.text = apiResponse.object.split('')[3];
      _fifthEditingController.text = apiResponse.object.split('')[4];*/
      setState(() {
        resendCode = false;
      });
      Future.delayed(const Duration(seconds: 120),(){
        setState(() {
          resendCode = true;
        });
      });
      context.showSnackBar(message: apiResponse.message);
    } else {
      context.showSnackBar(
          message: apiResponse.message, error: !apiResponse.success);
    }
  }
}
