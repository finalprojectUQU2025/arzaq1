import 'package:arzaq_app/get_controller/merchant_get_controller/merchant_my_purchases_get_controller.dart';
import 'package:arzaq_app/screens/Marchant/DetailsInvoices-Marchant.dart';
import 'package:arzaq_app/utils/app_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custome_app_text.dart';


class My_PurchasesScreen_Marchant extends StatefulWidget {
  @override
  _My_PurchasesScreen_MarchantState createState() => _My_PurchasesScreen_MarchantState();
}

class _My_PurchasesScreen_MarchantState extends State<My_PurchasesScreen_Marchant> {
  MerchantMyPurchasesGetxController controller = Get.put<MerchantMyPurchasesGetxController>(MerchantMyPurchasesGetxController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white10,
      body: ListView(
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
          GetBuilder<MerchantMyPurchasesGetxController>(
            builder: (MerchantMyPurchasesGetxController controller) {
              if(controller.loading==true){
                return Center(child: Column(
                  children: [
                    SizedBox(height: 150.h,),
                    CircularProgressIndicator(backgroundColor: Colors.grey.withOpacity(0.4),color: AppColors.primaryColor,strokeCap: StrokeCap.round,),
                  ],
                ));
              }else if(controller.myPurchases != null){
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/Rectangle2.svg',),
                            Column(
                              children: [
                                const AppText(
                                  text: 'الرصيد',
                                  color: Color(0XFF616161),
                                  fontSize: 13,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,


                                ),
                                AppText(
                                  text: controller.myPurchases!.balance??'',
                                  color: const Color(0XFF616161),
                                  fontSize: 17,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            )

                          ],
                        ),

                        /*SizedBox(width: 16.w,),*/
                        Stack(
                          alignment: Alignment.center,

                          children: [
                            SvgPicture.asset(
                              'assets/images/Rectangle1.svg',),
                            Column(
                              children: [
                                const AppText(
                                  text: 'المشتريات',
                                  color: Color(0XFF616161),
                                  fontSize: 13,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,


                                ),
                                AppText(
                                  text: controller.myPurchases!.purchases.toString(),
                                  color: const Color(0XFF616161),
                                  fontSize: 17,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            )

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 21.h,),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.myPurchases!.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:  EdgeInsets.only(top: 10.h),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsMerchantInvocesScreen(id: controller.myPurchases!.data![index].id!),
                                    ));
                              },
                              child: Container(
                                width: 350.w,
                                // height: 90.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x26B1B1B1),
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.all(13.0.w),
                                  child: Row(
                                    children: [

                                      Container(
                                        width: 40.w,
                                        height: 40.13.h,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              controller.myPurchases!.data![index].image!,

                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w,),

                                      Column(
                                        crossAxisAlignment:   CrossAxisAlignment.start,

                                        children: [
                                          AppText(
                                            text: controller.myPurchases!.data![index].name??'',
                                            color: Colors.black,
                                            fontSize: 14,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w500,


                                          ),
                                          AppText(
                                            text: controller.myPurchases!.data![index].quantity??'',
                                            color: Colors.black,
                                            fontSize: 14,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w500,


                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'البائع: ',
                                                  style: GoogleFonts.tajawal(
                                                    color: const Color(0xFF7D7D7D),
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: controller.myPurchases!.data![index].account!.name??'',
                                                  style: GoogleFonts.tajawal(
                                                    color: Colors.black,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )


                                        ],
                                      ),
                                      const Spacer(),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          AppText(
                                            text: controller.myPurchases!.data![index].createdAt??'',
                                            color: const Color(0xFF909090),
                                            fontSize: 10,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w400,


                                          ),
                                          SizedBox(height: 11.h,),
                                          AppText(
                                            text: controller.myPurchases!.data![index].price??'',
                                            color: Colors.black,
                                            fontSize: 13,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w700,


                                          ),
                                          SizedBox(height: 3.h,),

                                          Row(
                                            children: [
                                              const AppText(
                                                text: 'الفاتورة',
                                                color: Color(0xFF767676),
                                                fontSize: 10,
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.w400,


                                              ),
                                              SizedBox(width: 4.w,),
                                              const Icon(Icons.arrow_forward_ios_outlined,size: 13,
                                                color: Color(0xFF767676),

                                              ),

                                            ],
                                          ),
                                        ],
                                      )







                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );

                        }),
                  ],
                );
              }else{
                return const SizedBox();
              }
            },),
        ],
      ),


    );
  }
}