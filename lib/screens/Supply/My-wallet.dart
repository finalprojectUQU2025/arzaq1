import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../get_controller/supplier_get_controller/supply_my_wallet_get_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custome_app_text.dart';


class MyWalletScreen extends StatefulWidget {
  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  SupplyMyWalletGetxController controller =Get.put<SupplyMyWalletGetxController>(SupplyMyWalletGetxController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white10,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:GetBuilder<SupplyMyWalletGetxController>(

          builder: (SupplyMyWalletGetxController controller) {
            if(controller.loading==true){
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.grey.withOpacity(0.4),color: AppColors.primaryColor,strokeCap: StrokeCap.round,));
            }else if(controller.myWallet != null){
              return ListView(

                padding:  EdgeInsets.symmetric(horizontal: 24.0.w,vertical: 24.h),
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
                  Padding(
                    padding:  EdgeInsets.only(right:54.w,left: 54.w),
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
                        padding:  EdgeInsetsDirectional.only(start: 16.0.w,end: 16.h,top: 16.h,bottom: 17.3.h),
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
                            SizedBox(height: 5.h,),
                             AppText(
                            text: '${controller.myWallet!.balance??""} ر.س ',
                              color: Color(0xFFFFFACC),
                              fontSize: 16,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w700,


                            ),
                            SizedBox(height: 18.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: '${controller.myWallet!.cardExpiry??""}',
                                  color: Colors.white,
                                  fontSize: 12,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w400,


                                ),
                                AppText(
                                  text: '${controller.myWallet!.cardNumber??""}',
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
                  SizedBox(height: 21.h,),


                  AppText(
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

                        return  Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 13.h),
                              child: Row(
                                children: [

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(300.0.r),


                                    child: Container(
                                      width: 40.w,
                                      height: 40.13.h,
                                      decoration:  BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            controller.myWallet!.myTransaction![index].image!,

                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w,),

                                   Column(
                                    crossAxisAlignment:   CrossAxisAlignment.start,

                                    children: [
                                      AppText(
                                        text:  controller.myWallet!.myTransaction![index].name!,
                                        color: Colors.black,
                                        fontSize: 11,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w500,


                                      ),
                                      AppText(
                                        text:  controller.myWallet!.myTransaction![index].created_at!,
                                        color: Color(0xFF808080),
                                        fontSize: 10,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w500,


                                      ),

                                    ],
                                  ),
                                  const Spacer(),
                                   AppText(
                                     text:  controller.myWallet!.myTransaction![index].amount!,
                                    color: Colors.black,
                                    fontSize: 12,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,


                                  ),






                                ],
                              ),
                            ),
                            SizedBox(height: 17.h,),
                            Container(
                              width: 380.w,
                              decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: .7,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );

                      }),




                ],
              );
            }else{
              return const SizedBox();
            }
          },),



      ),
   

    );
  }
}