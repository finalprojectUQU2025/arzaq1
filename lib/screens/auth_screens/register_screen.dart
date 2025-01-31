import 'dart:io';

import 'package:arzaq_app/get_controller/city_get_controller.dart';
import 'package:arzaq_app/screens/auth_screens/login_screen.dart';
import 'package:arzaq_app/screens/auth_screens/register_terms_and_conditions_screen.dart';
import 'package:arzaq_app/screens/auth_screens/verification_email_code_screen.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:arzaq_app/widgets/custom_app_loading.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../api_controller/auth_api_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/custome_app_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  CitiesGetxController controller = Get.put<CitiesGetxController>(CitiesGetxController());
  Country country = CountryParser.parseCountryCode('SA');
  late TabController _tabController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _confPasswordTextEditingController;
  late TextEditingController _nameTextEditingController;
  late TextEditingController _phoneTextEditingController;
  final FocusNode _emailNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _passNode = FocusNode();
  final FocusNode _confPassNode = FocusNode();
  bool _emailFocused = false;
  bool _passwordFocused = false;
  bool _confPasswordFocused = false;
  bool _nameFocused = false;
  bool _phoneFocused = false;
  String countryCode = '+966';
  String? countryFlag;
  bool obscure = true;
  bool obscure2 = true;
  bool approved = false;
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  bool isLoading = false;
  int? selectedItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailNode.addListener(() {
      setState(() {
        _emailFocused = _emailNode.hasFocus;
      });
    });
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
    _nameNode.addListener(() {
      setState(() {
        _nameFocused = _nameNode.hasFocus;
      });
    });
    _phoneNode.addListener(() {
      setState(() {
        _phoneFocused = _phoneNode.hasFocus;
      });
    });
    _tabController = TabController(length: 2, vsync: this);
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confPasswordTextEditingController = TextEditingController();
    _nameTextEditingController = TextEditingController();
    _phoneTextEditingController = TextEditingController();
    _imagePicker = ImagePicker();

  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confPasswordTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _phoneTextEditingController.dispose();
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
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  text: 'إنشاء حساب',
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 36.h,
                ),
                Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: const Color(0XFFF7F7F7)
                  ),
                  child: TabBar(
                    controller: _tabController,
                    // labelColor: Colors.blue,
                    labelStyle: GoogleFonts.tajawal(fontSize: 14.sp,fontWeight: FontWeight.w600,color: Colors.white),
                    unselectedLabelStyle: GoogleFonts.tajawal(fontSize: 14.sp,fontWeight: FontWeight.w600,color: const Color(0XFFCFCFCF)),
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorColor:  AppColors.primaryColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.r)
                    ),
                    onTap: (int tabIndex) {
                      setState(() => _tabController.index = tabIndex);
                    },
                    tabs: const [
                      Tab(
                        text: 'مزارع',
                      ),
                      Tab(
                        text: 'تاجر',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h,),
                Container(
                  padding: EdgeInsetsDirectional.only(top: _pickedImage == null?26.h:0),
                  height: 80.h,
                  width: 80.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      color: Color(0XFFE9E9E9),
                      shape: BoxShape.circle
                  ),
                  child: _pickedImage == null?SvgPicture.asset('assets/images/uploadImage.svg'):Image.file(
                    File(_pickedImage!.path),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 4.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 106.w),
                  child: InkWell(
                    onTap: () => _pickImage(),
                    child: DottedBorder(
                        color: const Color(0XFF074456),
                        borderType: BorderType.RRect,
                        strokeWidth: 1,
                        dashPattern: const [4],
                        padding: EdgeInsets.zero,
                        borderPadding: EdgeInsets.zero,
                        radius: Radius.circular(8.r),
                        child: Padding(
                          padding:  EdgeInsetsDirectional.only(top: 10.w,end: 8.w,start: 10.w,bottom: 8.h),
                          child:  const Center(child: AppText(text: 'ارفع الصورة الشخصية',fontSize: 12,color: Color(0XFF074456),)),
                        )),
                  ),
                ),
                SizedBox(height: 10.h,),
                const AppText(
                  text: 'مسموح بJPG او GIF او PNG. الحد الأقصى للحجم 2ميجا بايت',
                  color: Color(0XFFBABABA),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const AppText(
                        text: 'الاسم',
                        color: Color(0XFF616161),
                        fontSize: 14,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                      ),

                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextField(
                        controller: _nameTextEditingController,
                        hintText: 'مثال: أحمد فيصل العمري',
                        focusNode: _nameNode,

                        height: 56,
                        maxLines: 1,
                        prefixIcon: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 14.h),
                          child: SvgPicture.asset(
                            'assets/images/userIcon.svg',

                            colorFilter:
                            ColorFilter.mode(_nameFocused ?AppColors.primaryColor:const Color(0XFFA7A9B7), BlendMode.srcIn),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h,),

                      const AppText(
                        text: 'رقم الجوال',
                        color: Color(0XFF616161),
                        fontSize: 14,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                      ),

                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextField(
                        controller: _phoneTextEditingController,
                        hintText: '53 123 4567',
                        focusNode: _phoneNode,
                        height: 56,
                        maxLines: 1,
                        maxLength: 9,
                        keyboardType: TextInputType.phone,
                        prefixIcon: InkWell(
                          onTap:(){
                            showPicker();
                          },
                          child: Container(
                            width: 73.w,
                              child: Center(child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(text: countryFlag??country.flagEmoji,fontWeight: FontWeight.bold,fontSize: 24.sp,),
                                  Icon(Icons.arrow_drop_down,size: 26.sp,color: const Color(0XFF949494),),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(vertical: 6.h),
                                    child: VerticalDivider(
                                      color: const Color(0XFFDDDDDD),
                                      width: 0.w,
                                      thickness: 1.2,
                                    ),
                                  )
                                ],
                              ))),
                        ),
                      ),
                      SizedBox(height: 16.h,),
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
                        focusNode: _emailNode,
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
                      SizedBox(height: 16.h,),
                      const AppText(
                        text: 'المدينة',
                        color: Color(0XFF616161),
                        fontSize: 14,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      GetBuilder<CitiesGetxController>(
                        builder: (CitiesGetxController controller) {
                          if(controller.loading == true){
                            return Container(
                                height: 56.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0XFFE0E0E0)),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                ),
                                child: Padding(

                                  padding:EdgeInsets.symmetric(horizontal: 16.w),
                                  child:  const Row(
                                    children: [
                                      AppText(
                                        text: 'المدينة',
                                        color: Color(0xFF5C5C5C),
                                        fontSize: 12,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Spacer(),
                                      Icon(Icons.keyboard_arrow_down_sharp)
                                    ],
                                  ),


                                )

                            );
                          }else if(controller.cities.isNotEmpty){
                            var cities = controller.cities;
                            print(cities.length);
                            return Container(
                              height: 56.h,
                              padding:EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 1, color: Color(0XFFE0E0E0)),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                              ),
                              child: DropdownButton<int>(
                                isExpanded: true,
                                hint: Text(
                                  'المدينة',
                                  style: GoogleFonts.tajawal(color: const Color(0xFF5C5C5C),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,),
                                ),
                                underline: const SizedBox(),
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                items: cities.map((city) {
                                  return DropdownMenuItem<int>(
                                    value: city.id,
                                    child: AppText(
                                      text: city.name??'',
                                      color: const Color(0xFF5C5C5C),
                                      fontSize: 16,
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value;
                                  });
                                },
                                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                                value: selectedItem,
                              ),
                            );
                          }else{
                            return Container(
                                height: 56.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0XFFE0E0E0)),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                ),
                                child: Padding(

                                  padding:EdgeInsets.symmetric(horizontal: 16.w),
                                  child:  const Row(
                                    children: [
                                      AppText(
                                        text: 'المدينة',
                                        color: Color(0xFF5C5C5C),
                                        fontSize: 12,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Spacer(),
                                      Icon(Icons.keyboard_arrow_down_sharp)
                                    ],
                                  ),


                                )

                            );
                          }
                        },),
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
                        height: 16.h,
                      ),
                      const AppText(
                        text: 'تأكيد كلمة المرور',
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
                        hintText: 'اعد كتابة كلمة المرور هنا',
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
                        obscure: obscure2,
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
                              obscure2 = !obscure2;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric( vertical: 16.h),
                            child: SvgPicture.asset(
                              obscure2?'assets/images/eyeClosed.svg':'assets/images/eyeOutline.svg',
                              height: 24.h,
                              //eyeClosed
                              width: 24.w,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: SizedBox(
                              height: 24.h,
                              width: 24.w,
                              child: Checkbox(
                                side: BorderSide(
                                  color: const Color(0XFFADADAD),
                                  width: 1.5.w,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r)),
                                splashRadius: 8.r,
                                activeColor: AppColors.primaryColor,
                                value: approved,
                                onChanged: (value) {
                                  setState(() {
                                    approved = !approved;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          InkWell(
                              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const RegisteredTermsAndConditionsScreen(),
                                    ));
                              },
                              child: const AppText(
                                text:
                                'أوافق على شروط الخصوصية والاحكام والشروط للتطبيق',
                                fontSize: 13,
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                              )),

                        ],
                      ),
                      SizedBox(
                        height: 24.w,
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 80.w),
                        child: AppElevatedButton(
                          text: 'إنشاء حساب',
                          height: 46,
                          onPressed: () async{
                            setState(() {
                               isLoading = true;
                            });
                            await _performSignUp();
                            setState(() {
                              isLoading = false;
                            });
                          },),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'هل لديك حساب بالفعل؟',
                                  style: GoogleFonts.tajawal(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                TextSpan(
                                  text: " تسجيل الدخول",
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
                      SizedBox(
                        height: 24.w,
                      ),
                    ],
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
  void showPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
          bottomSheetHeight: 600.h,
          inputDecoration: InputDecoration(
              constraints: BoxConstraints(maxHeight: 60.h),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(width: 2.w, color:  AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(width: 0.50.w, color:  AppColors.primaryColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(width: 0.50.w, color:  AppColors.primaryColor),
              ),
              prefixIcon: const Icon(Icons.search)
          )
      ),
      onSelect: (Country country) {
        setState(() {
          countryCode = '+${country.phoneCode}';
          countryFlag = country.flagEmoji;
        });
      },
    );
  }
  void _pickImage() async {
    XFile? imageFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() => _pickedImage = imageFile);
    }
  }

  Future<void> _performSignUp() async {
    print(countryCode+_phoneTextEditingController.text);
    if (_checkData()) {
      await _signUp();
    }
  }

  bool _checkData() {
    if (_nameTextEditingController.text.isNotEmpty &&
        _phoneTextEditingController.text.isNotEmpty &&
        _emailTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty&&_pickedImage != null&&selectedItem != null ) {
      if(approved){
        if(_passwordTextEditingController.text == _confPasswordTextEditingController.text){
          return true;
        }else{
          context.showSnackBar(message: 'كلمة المرور غير متطابقة!', error: true);
          return false;
        }
      }else{
        context.showSnackBar(message: 'الرجاء الموافقة على الشروط والاحكام', error: true);
        return false;
      }
    }
    context.showSnackBar(message: 'الرجاء اكمال البيانات المطلوبة', error: true);
    return false;
  }

  Future<void> _signUp() async {
    ApiResponse apiResponse = await AuthApiController().register(
      type: _tabController.index==0?'mazarie':'tajir',
      name: _nameTextEditingController.text,
      phone: countryCode+_phoneTextEditingController.text,
      email: _emailTextEditingController.text,
      password: _passwordTextEditingController.text,
      checkConditions: approved?'1':'0',
      cityId: selectedItem.toString(),
      image:_pickedImage != null? File(_pickedImage!.path):null,);
    if (apiResponse.success) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationEmailCodeScreen(code: apiResponse.object,email: _emailTextEditingController.text,),));
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogInScreen(),), (route) => false);
      context.showSnackBar(
          message: apiResponse.message, error: !apiResponse.success);
    } else {
      context.showSnackBar(
          message: apiResponse.message, error: !apiResponse.success);
    }
  }
}
