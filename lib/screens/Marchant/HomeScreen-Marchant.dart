import 'dart:ui';

import 'package:arzaq_app/api_controller/fb_controller.dart';
import 'package:arzaq_app/api_controller/notifications_api_controller.dart';
import 'package:arzaq_app/get_controller/merchant_get_controller/merchant_home_get_controller.dart';
import 'package:arzaq_app/model/auction_timer.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:arzaq_app/widgets/app_elevated_button.dart';
import 'package:arzaq_app/widgets/custom_app_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custome_app_text.dart';
import 'DetailsAcction-MarChant.dart';

class HomeScreen_Marchant extends StatefulWidget {
  @override
  _HomeScreen_MarchantState createState() => _HomeScreen_MarchantState();
}

class _HomeScreen_MarchantState extends State<HomeScreen_Marchant>  with SingleTickerProviderStateMixin {
  MerchantHomeGetxController controller = Get.put<MerchantHomeGetxController>(MerchantHomeGetxController());
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    if(controller.isFirst == false){
      controller.showAuctionType(1);
    }
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    Get.delete<MerchantHomeGetxController>(force: true);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white10,
      body: GetBuilder<MerchantHomeGetxController>(
        builder: (MerchantHomeGetxController controller) {
        if(controller.loading==true){
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(color: Color(0xFFFFFBD9)),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 24.0.w,vertical: 24.0.h),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          Center(
                            child: Image.asset(
                              'assets/images/appLogo.png',
                              width: 72.w,
                              height: 72.h,
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/RectangleM2.svg',
                                  ),
                                  const Column(
                                    children: [
                                      AppText(
                                        text: 'الرصيد',
                                        color: Color(0XFF616161),
                                        fontSize: 13,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              // SizedBox(width: 16.w,),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/RectangleM1.svg',
                                  ),
                                  const Column(
                                    children: [
                                      AppText(
                                        text: 'عدد المعاملات',
                                        color: Color(0XFF616161),
                                        fontSize: 13,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppText(
                                        text: '(الشهر الحالي)',
                                        color: Color(0XFF616161),
                                        fontSize: 10,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.h,
                          ),


                        ],
                      ),
                    ),
                  ),





                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 365.h,horizontal: 167.5.w),
                color: Colors.black.withOpacity(0.3),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 25.h),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x339B9B9B),
                          blurRadius: 75,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Center(child: CircularProgressIndicator(backgroundColor: Colors.grey.withOpacity(0.4),color: AppColors.primaryColor,strokeCap: StrokeCap.round,)),
                  ),
                ),
              ),

            ],
          );
        }else if(controller.homeData != null){
          print('00000');
          return Column(
            children: [
              Container(
                // width: 390.w,
                // height: 844.h,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Color(0xFFFFFBD9)),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.0.w,vertical: 24.0.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/appLogo.png',
                          width: 72.w,
                          height: 72.h,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/RectangleM2.svg',
                              ),
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
                                    text: controller.homeData!.balance??'',
                                    color: const Color(0XFF616161),
                                    fontSize: 17,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )
                            ],
                          ),

                          // SizedBox(width: 16.w,),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/RectangleM1.svg',
                              ),
                               Column(
                                children: [
                                  const AppText(
                                    text: 'عدد المعاملات',
                                    color: Color(0XFF616161),
                                    fontSize: 13,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const AppText(
                                    text: '(الشهر الحالي)',
                                    color: Color(0XFF616161),
                                    fontSize: 10,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    text: '${controller.homeData!.transactions??''}',
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
                      SizedBox(
                        height: 0.h,
                      ),


                    ],
                  ),
                ),
              ),






              /*Padding(
            padding:  EdgeInsets.only(left: 49.0.w,right: 49.w,top: 20.h),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'مزادات الخضار',
                  color: Color(0xFF064356),
                  fontSize: 15,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  text: 'مزادات الفواكه',
                  color: Color(0xFF8D8D8D),
                  fontSize: 15,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),*/
              TabBar(
                controller: _tabController,
                labelStyle: GoogleFonts.tajawal(fontSize: 15.sp,fontWeight: FontWeight.w700,color: AppColors.primaryColor),
                unselectedLabelStyle: GoogleFonts.tajawal(fontSize: 15.sp,fontWeight: FontWeight.w500,color: const Color(0XFF8E8E8E)),
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorColor:  AppColors.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: const Color(0XFFD4D4D4),
                onTap: (int tabIndex) {

                  setState(() {
                    _tabController.index = tabIndex;
                    controller.showAuctionType(tabIndex+1);
                  });
                },
                tabs: const [
                  Tab(
                    text: 'مزادات الخضار',
                  ),
                  Tab(
                    text: 'مزادات الفواكه',
                  ),
                ],
              ),
              SizedBox(height: 16.h,),
              Expanded(
                child: IndexedStack(
                  index: _tabController.index,
                  children: [
                    Visibility(
                      visible: _tabController.index == 0,
                      child:   ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppText(
                                  text: 'متاحة من الساعة 9 ل 10 صباحا',
                                  color: Colors.black,
                                  fontSize: 10,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 0.h,),
                          controller.moreLoading?
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 21.0.h),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Container(
                                      width: 350.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        gradient: LinearGradient(colors: [
                                          Colors.grey.shade200,
                                          Colors.white
                                        ]),
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
                                    ),
                                  );
                                }),
                          ):Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 21.0.h),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.homeData!.openAuction!.length,
                                itemBuilder: (context, index) {
                                  return StreamBuilder<DocumentSnapshot<AuctionTimer>>(
                                    stream:
                                    FbFirestoreController().readAuctionTime(controller.homeData!.openAuction![index].id.toString()),
                                    builder: (context, snapshotSop) {
                                      if(snapshotSop.connectionState ==ConnectionState.waiting){
                                        return SizedBox();
                                      }else if(snapshotSop.hasData){
                                        return Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: InkWell(
                                            onTap: () async{
                                              print('00000');
                                              final now = DateTime.now();
                                              if(snapshotSop.hasData){
                                                DateTime endTimer = await DateTime.parse(snapshotSop.data!.data()!.endTime!);
                                                DateTime startTimer = await DateTime.parse(snapshotSop.data!.data()!.startTime!);
                                                if (now.isAfter(startTimer) && now.isBefore(endTimer)) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailsAuction_MarchantScreen(id: controller.homeData!.openAuction![index].id!,type: 2,),
                                                      ));
                                                }else if(now.isBefore(startTimer)){
                                                  _showStartingDialog(context, message: 'هذا المزاد غير متاح بعد!');
                                                }else {
                                                  _showStartingDialog(context, message: 'هذا المزاد لم يعد متاح');
                                                  NotificationsApiController().closeAuction(id: controller.homeData!.openAuction![index].id!);
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 350.w,
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 13.0.w, vertical: 13.h),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 40.w,
                                                      height: 40.13.h,
                                                      decoration:  BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            controller.homeData!.openAuction![index].image!,
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        AppText(
                                                          text: controller.homeData!.openAuction![index].name??'',
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          textAlign: TextAlign.start,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        AppText(
                                                          text: controller.homeData!.openAuction![index].quantity??'',
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          textAlign: TextAlign.start,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    const AppText(
                                                      text: 'المزيد',
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      textAlign: TextAlign.start,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    const Icon(
                                                      Icons.arrow_forward_ios_outlined,
                                                      size: 13,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }else{
                                        return SizedBox();
                                      }

                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _tabController.index == 1,
                      child:   Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppText(
                                  text: 'متاحة من الساعة 10 ل 11 صباحا',
                                  color: Colors.black,
                                  fontSize: 10,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 0.h,),

                          controller.moreLoading?
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 21.0.h),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Container(
                                      width: 350.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        gradient: LinearGradient(colors: [
                                          Colors.grey.shade200,
                                          Colors.white
                                        ]),
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
                                    ),
                                  );
                                }),
                          ):Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 21.0.h),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.homeData!.openAuction!.length,
                                itemBuilder: (context, index) {
                                  return StreamBuilder<DocumentSnapshot<AuctionTimer>>(
                                    stream:
                                    FbFirestoreController().readAuctionTime(controller.homeData!.openAuction![index].id.toString()),
                                    builder: (context, snapshotSop) {
                                      if(snapshotSop.connectionState ==ConnectionState.waiting){
                                        return SizedBox();
                                      }else if(snapshotSop.hasData){
                                        return Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: InkWell(
                                            onTap: () async{
                                              print('00000');
                                              final now = DateTime.now();
                                              if(snapshotSop.hasData){
                                                DateTime endTimer = await DateTime.parse(snapshotSop.data!.data()!.endTime!);
                                                DateTime startTimer = await DateTime.parse(snapshotSop.data!.data()!.startTime!);
                                                if (now.isAfter(startTimer) && now.isBefore(endTimer)) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailsAuction_MarchantScreen(id: controller.homeData!.openAuction![index].id!,type: 2,),
                                                      ));
                                                }else if(now.isBefore(startTimer)){
                                                  _showStartingDialog(context, message: 'هذا المزاد غير متاح بعد!');
                                                }else {
                                                  _showStartingDialog(context, message: 'هذا المزاد لم يعد متاح');
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 350.w,
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 13.0.w, vertical: 13.h),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 40.w,
                                                      height: 40.13.h,
                                                      decoration:  BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            controller.homeData!.openAuction![index].image!,
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        AppText(
                                                          text: controller.homeData!.openAuction![index].name??'',
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          textAlign: TextAlign.start,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        AppText(
                                                          text: controller.homeData!.openAuction![index].quantity??'',
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          textAlign: TextAlign.start,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    const AppText(
                                                      text: 'المزيد',
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      textAlign: TextAlign.start,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    const Icon(
                                                      Icons.arrow_forward_ios_outlined,
                                                      size: 13,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }else{
                                        return SizedBox();
                                      }

                                    },
                                  );

                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50.h,)
            ],
          );
        }else{
          return const SizedBox();
        }

      },),

    );
  }
  Future<void> _showStartingDialog(BuildContext context,{required String message}) async {
    showDialog(
      context: context,
      barrierColor: Colors.white60,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 6,
          insetPadding: EdgeInsets.zero,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: const BorderSide(color: AppColors.primaryColor),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: message,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 24.h),
              AppElevatedButton(text: 'حسنا', onPressed: () {
                Navigator.pop(context);
              },)

            ],
          ),
        );
      },
    );
  }


}
