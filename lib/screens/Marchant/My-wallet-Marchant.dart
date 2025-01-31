import 'package:arzaq_app/utils/extention.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_controller/merchant_api_controller.dart';
import '../../get_controller/merchant_get_controller/marchant_my_wallet_get_controller.dart';
import '../../prefs/shared_pref_controller.dart';
import '../../utils/api_response.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/custom_app_loading.dart';
import '../../widgets/custome_app_text.dart';

class MyWalletScreen_Marchant extends StatefulWidget {
  @override
  _MyWalletScreen_MarchantState createState() =>
      _MyWalletScreen_MarchantState();
}

class _MyWalletScreen_MarchantState extends State<MyWalletScreen_Marchant> {
  MarchantMyWalletGetxController controller =
      Get.put<MarchantMyWalletGetxController>(MarchantMyWalletGetxController());

  late TextEditingController _CostTextEditingController;
  late TextEditingController _NumTextEditingController;
  late TextEditingController _NameTextEditingController;
  late TextEditingController _CVVTextEditingController;
  late TextEditingController _DateTextEditingController;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _CostTextEditingController = TextEditingController();
    _NumTextEditingController = TextEditingController();
    _NameTextEditingController = TextEditingController();
    _CVVTextEditingController = TextEditingController();
    _DateTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _CostTextEditingController.dispose();
    _NumTextEditingController.dispose();
    _NameTextEditingController.dispose();
    _CVVTextEditingController.dispose();
    _DateTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white10,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<MarchantMyWalletGetxController>(
          builder: (MarchantMyWalletGetxController controller) {
            if (controller.loading == true) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.4),
                color: AppColors.primaryColor,
                strokeCap: StrokeCap.round,
              ));
            } else if (controller.myWallet != null) {
              return Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.0.w, vertical: 24.h),
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/appLogo.png',
                              width: 72.w,
                              height: 72.h,
                            ),
                          ),
                          SizedBox(
                            width: 55.w,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                        child: Container(
                                      height: 600.h,
                                      decoration: const ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40),
                                            ),
                                          )),
                                      child: Padding(
                                        padding: EdgeInsets.all(24.0.w),
                                        child: Column(
                                          children: [
                                            const AppText(
                                              text: 'شحن الرصيد',
                                              color: Colors.black,
                                              fontSize: 16,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const AppText(
                                                  text: 'المبلغ',
                                                  color: Color(0xFF606060),
                                                  fontSize: 13,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                AppTextField(
                                                  controller:
                                                      _CostTextEditingController,
                                                  hintText: 'مثال: 100 ر.س',
                                                  // focusNode: _firstNode,
                                                  onChanged: (p0) {
                                                    /* _firstNode.addListener(() {
            setState(() {
              _emailFocused = _firstNode.hasFocus;
            });
                          });*/
                                                  },
                                                  height: 56,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 16.h,
                                                ),
                                                const AppText(
                                                  text: 'معلومات البطاقة',
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                const AppText(
                                                  text: 'رقم البطاقة',
                                                  color: Color(0xFF606060),
                                                  fontSize: 13,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                AppTextField(
                                                  controller:
                                                      _NumTextEditingController,
                                                  hintText:
                                                      '**** ****** ******* *****',
                                                  // focusNode: _firstNode,
                                                  onChanged: (p0) {
                                                    /* _firstNode.addListener(() {
            setState(() {
              _emailFocused = _firstNode.hasFocus;
            });
                          });*/
                                                  },
                                                  height: 56,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 16.h,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                const AppText(
                                                  text: 'اسم صاحب البطاقة',
                                                  color: Color(0xFF606060),
                                                  fontSize: 13,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                AppTextField(
                                                  controller:
                                                      _NameTextEditingController,
                                                  hintText: 'أدخل اسمك',
                                                  // focusNode: _firstNode,
                                                  onChanged: (p0) {
                                                    /* _firstNode.addListener(() {
            setState(() {
              _emailFocused = _firstNode.hasFocus;
            });
                          });*/
                                                  },
                                                  height: 56,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 16.h,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 60.w,
                                                ),
                                                const AppText(
                                                  text: 'CVV',
                                                  color: Color(0xFF606060),
                                                  fontSize: 13,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  width: 28.w,
                                                ),
                                                const AppText(
                                                  text: 'تاريخ الانتهاء',
                                                  color: Color(0xFF606060),
                                                  fontSize: 13,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: AppTextField(
                                                        controller:
                                                            _CVVTextEditingController,
                                                        hintText: '1234',
                                                        onChanged: (p0) {},
                                                        height: 56,
                                                        width: 164.w,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.h,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: AppTextField(
                                                        controller:
                                                            _DateTextEditingController,
                                                        hintText: 'MM/YY',
                                                        onChanged: (p0) {},
                                                        height: 56,
                                                        width: 164.w,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 80.w),
                                              child: AppElevatedButton(
                                                text: 'إضافة',
                                                height: 46,
                                                onPressed: () async {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  Navigator.of(context).pop();

                                                  await _performLogin();
                                                  MarchantMyWalletGetxController
                                                      .to
                                                      .read();

                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                                  });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 100.w,
                              height: 32.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFFACC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x26939393),
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: const AppText(
                                text: 'شحن رصيد',
                                color: Color(0xFF064356),
                                fontSize: 13,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 54.w, left: 54.w),
                        child: Container(
                          alignment: Alignment.centerRight,
                          // width: 200.w,
                          // height: 125.h,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064356),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x26E4E4E4),
                                blurRadius: 12,
                                offset: Offset(0, 8),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 16.0.w,
                                end: 16.h,
                                top: 16.h,
                                bottom: 17.3.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppText(
                                  text: 'الرصيد',
                                  color: Colors.white,
                                  fontSize: 12,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                AppText(
                                  text:
                                      controller.myWallet!.balance ?? "",
                                  color: const Color(0xFFFFFACC),
                                  fontSize: 16,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text:
                                          '${controller.myWallet!.cardExpiry ?? ""}',
                                      color: Colors.white,
                                      fontSize: 12,
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    AppText(
                                      text:
                                          '${controller.myWallet!.cardNumber ?? ""}',
                                      color: Colors.white,
                                      fontSize: 14,
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                      const AppText(
                        text: 'الحركات',
                        color: Colors.black,
                        fontSize: 14,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                      ),
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.myWallet!.myTransaction!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 13.h),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(300.0.r),
                                        child: Container(
                                          width: 40.w,
                                          height: 40.13.h,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                controller
                                                    .myWallet!
                                                    .myTransaction![index]
                                                    .image!,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            text: controller.myWallet!
                                                .myTransaction![index].name!,
                                            color: Colors.black,
                                            fontSize: 11,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          AppText(
                                            text: controller
                                                .myWallet!
                                                .myTransaction![index]
                                                .created_at!,
                                            color: const Color(0xFF808080),
                                            fontSize: 10,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      AppText(
                                        text: controller.myWallet!
                                            .myTransaction![index].amount!,
                                        color: Colors.black,
                                        fontSize: 12,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 17.h,
                                ),
                                Container(
                                  width: 380.w,
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: .7,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Color(0xFFE6E6E6),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                  Visibility(
                      visible: isLoading == true,
                      child: const CustomAppLoading()),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Future _performLogin() async {
    if (checkData()) {
      await _AddWallet();
    }
  }

  //   _CostTextEditingController
  //     _NumTextEditingController
  //     _NameTextEditingController
  //     _CVVTextEditingController
  //     _DateTextEditingController
  bool checkData() {
    if (_CostTextEditingController.text.isNotEmpty &&
        _NumTextEditingController.text.isNotEmpty &&
        _NameTextEditingController.text.isNotEmpty &&
        _CVVTextEditingController.text.isNotEmpty &&
        _DateTextEditingController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(
        message: 'الرجاء ادخل البيانات المطلوبة!', error: true);
    return false;
  }

  Future<void> _AddWallet() async {
    ApiResponse apiResponse = await MerchantApiController().addWalletMarchant(
      card_holder_name: _NameTextEditingController.text,
      card_number: _NumTextEditingController.text,
      card_expiry: _DateTextEditingController.text,
      card_cvv: _CVVTextEditingController.text,
      balance: _CostTextEditingController.text,
    );
    if (apiResponse.success) {
      print('sucsses123');
      // SharedPrefController().getValueFor(key: PrefKeys.type.name)=='mazarie'?
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBar(),), (route) => false):
      //
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBarMarchant(),), (route) => false);
    }
    context.showSnackBar(
      message: apiResponse.message,
      error: !apiResponse.success,
    );
  }
}
