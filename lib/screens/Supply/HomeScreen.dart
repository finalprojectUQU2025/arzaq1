import 'package:arzaq_app/api_controller/fb_controller.dart';
import 'package:arzaq_app/api_controller/notifications_api_controller.dart';
import 'package:arzaq_app/api_controller/supply_api_controller.dart';
import 'package:arzaq_app/get_controller/supplier_get_controller/supply_home_get_controller.dart';
import 'package:arzaq_app/model/auction_timer.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:arzaq_app/widgets/app_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custome_app_text.dart';
import 'Add-Auction.dart';
import 'DetailsAuctionScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SupplyHomeGetxController controller =Get.put<SupplyHomeGetxController>(SupplyHomeGetxController());
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white10,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: GetBuilder<SupplyHomeGetxController>(

          builder: (SupplyHomeGetxController controller) {
            if(controller.loading==true){
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.grey.withOpacity(0.4),color: AppColors.primaryColor,strokeCap: StrokeCap.round,));
            }
            else if(controller.homeData != null){
              return ListView(
                children: [
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
                            'assets/images/Rectangle2.svg',
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
                            'assets/images/Rectangle1.svg',
                          ),
                           Column(
                            children: [
                              const AppText(
                                text: 'المنتجات',
                                color: Color(0XFF616161),
                                fontSize: 13,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w500,
                              ),
                              AppText(
                                text: '${controller.homeData!.product ?? ''}',
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
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/Rectangle4.svg',
                          ),
                           Column(
                            children: [
                              const AppText(
                                text: 'الطلبات',
                                color: Color(0XFF616161),
                                fontSize: 13,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w500,
                              ),
                              AppText(
                                text: '${controller.homeData!.orders??''}',
                                color: const Color(0XFF616161),
                                fontSize: 17,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          )
                        ],
                      ),

                      /*  SizedBox(width: 16.w,),*/
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/Rectangle3.svg',
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
                    height: 24.h,
                  ),
                  const AppText(
                    text: 'مزاداتي',
                    color: Colors.black,
                    fontSize: 16,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  controller.homeData!.auctions!.isNotEmpty?
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.homeData!.auctions!.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<DocumentSnapshot<AuctionTimer>>(
                          stream:
                          FbFirestoreController().readAuctionTime(controller.homeData!.auctions![index].id.toString()),
                          builder: (context, snapshotSop) {
                            if(snapshotSop.connectionState ==ConnectionState.waiting){
                              return SizedBox();
                            }else if(snapshotSop.hasData){
                              return Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: InkWell(
                                  onTap: () async{
                                    final now = DateTime.now();
                                    if(snapshotSop.hasData){
                                      DateTime endTimer = await DateTime.parse(snapshotSop.data!.data()!.endTime!);
                                      DateTime startTimer = await DateTime.parse(snapshotSop.data!.data()!.startTime!);
                                      if (now.isAfter(startTimer) && now.isBefore(endTimer)) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsAuctionScreen(id: controller.homeData!.auctions![index].id!,type: controller.homeData!.auctions![index].productId!,),
                                            ));
                                      }else if(now.isBefore(startTimer)){
                                        _showStartingDialog(context, message: 'هذا المزاد غير متاح بعد!');
                                      }else {
                                        _showStartingDialog(context, message: 'هذا المزاد لم يعد متاح');
                                        NotificationsApiController().closeAuction(id: controller.homeData!.auctions![index].id!);
                                      }
                                    }

                                  },
                                  onLongPress: () async{
                                    await _showLogOutDialog(context,index);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    // height: 67.h,
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
                                                  controller.homeData!.auctions![index].image??'',
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
                                                text: controller.homeData!.auctions![index].name??'',
                                                color: Colors.black,
                                                fontSize: 14,
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              AppText(
                                                text: controller.homeData!.auctions![index].quantity??'',
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
                      }):const SizedBox(),
                ],
              );
            }else{
              return const SizedBox();
            }
          },),

      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddAuctionScreen(),
              ));
        },
        child: Container(
          width: 50.w,
          height: 50.h,
          decoration: const ShapeDecoration(
            color: Color(0xFF064356),
            shape: OvalBorder(),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Future<void> _showLogOutDialog(BuildContext context, int index) async {
    showDialog(
      context: context,
      barrierColor: Colors.white60,
      builder: (_) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                  const AppText(text: 'هل انت متأكد من حذف المزاد ؟'),
                  SizedBox(height: 24.h),
                  isLoading?CircularProgressIndicator(backgroundColor: Colors.grey.withOpacity(0.4),color: AppColors.primaryColor,strokeCap: StrokeCap.round,)
                      :Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide(width: 1.w, color: AppColors.primaryColor),
                            elevation: 0,
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            ApiResponse apiResponse = await SupplyHomeApiController().deleteAuction(id: controller.homeData!.auctions![index].id!);
                            if (apiResponse.success) {
                              SupplyHomeGetxController.to.deleteAuction(index);
                              context.showSnackBar(message: apiResponse.message);
                            } else {
                              context.showSnackBar(message: 'عذرا حصل خطأ ما!', error: true);
                            }
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          },
                          child: const Center(
                            child: AppText(
                              text: 'نعم',
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF00ADEF),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide(width: 1.w, color: AppColors.primaryColor),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Center(
                            child: AppText(
                              text: 'لا',
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
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
