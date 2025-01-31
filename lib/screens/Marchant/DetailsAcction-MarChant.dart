import 'dart:async';

import 'package:arzaq_app/api_controller/fb_controller.dart';
import 'package:arzaq_app/api_controller/merchant_api_controller.dart';
import 'package:arzaq_app/api_controller/notifications_api_controller.dart';
import 'package:arzaq_app/get_controller/loading_controller.dart';
import 'package:arzaq_app/get_controller/merchant_get_controller/merchant_auction_details_get_controller.dart';
import 'package:arzaq_app/model/auction_timer.dart';
import 'package:arzaq_app/model/supplier_models/supply_auction_details.dart';
import 'package:arzaq_app/screens/Marchant/NavegatorBar-Marchant.dart';
import 'package:arzaq_app/screens/auth_screens/forget_password_screens/forget_password_screen.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:arzaq_app/utils/app_colors.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:arzaq_app/widgets/app_text_field.dart';
import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:arzaq_app/widgets/timer2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsAuction_MarchantScreen extends StatefulWidget {
  const DetailsAuction_MarchantScreen({required this.id,required this.type, super.key});

  final int id;
  final int type;

  @override
  State<DetailsAuction_MarchantScreen> createState() =>
      _DetailsAuction_MarchantScreenState();
}

class _DetailsAuction_MarchantScreenState
    extends State<DetailsAuction_MarchantScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _costTextEditingController;
  bool isLoading = false;
  bool last30 = false;
  bool ended = false;
  DateTime? endTimer;
  DateTime? startTimer;

  @override
  void initState() {
    super.initState();
    _checkTime();
    Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkTime();
    });
    _costTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _costTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(last30);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<MerchantAuctionDetailsGetxController>(
        init: MerchantAuctionDetailsGetxController(widget.id),
        builder: (controller) {
          if (controller.loading == true) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.grey.withOpacity(0.4),
              color: AppColors.primaryColor,
              strokeCap: StrokeCap.round,
            ));
          } else if (controller.auctionDetails != null) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      // width: 390.w,
                      height: 243.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/detailsbackground.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h, right: 20.w),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.arrow_back)),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 110.h,
                        ),
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            width: 385.w,
                            // height: 740.h,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3FD1D1D1),
                                  blurRadius: 16,
                                  offset: Offset(0, 8),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                children: [
                                  const AppText(
                                    text: 'تفاصيل المزاد',
                                    color: Colors.black,
                                    fontSize: 18,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  AppText(
                                    text: controller.auctionDetails!.name ??
                                        '',
                                    color: Colors.black,
                                    fontSize: 16,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  AppText(
                                    text: controller
                                        .auctionDetails!.quantity ??
                                        '',
                                    color: Colors.black,
                                    fontSize: 16,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'السعر الأول: ',
                                          style: GoogleFonts.tajawal(
                                            color: const Color(0xFF064356),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: controller.auctionDetails!
                                              .startingPrice ??
                                              '',
                                          style: GoogleFonts.tajawal(
                                            color: const Color(0xFF064356),
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 24.w,
                                        height: 24.h,
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                          'assets/images/businessman.png',
                                          image: controller.auctionDetails!
                                              .mazarieAccount!.image!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      AppText(
                                        text: controller.auctionDetails!
                                            .mazarieAccount!.name!,
                                        color: Colors.black,
                                        fontSize: 15,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Container(
                                    width: 316.w,
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          strokeAlign:
                                          BorderSide.strokeAlignCenter,
                                          color: Color(0xFFD8D8D8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  StreamBuilder<QuerySnapshot<AllOffer>>(
                                    stream: FbFirestoreController()
                                        .readOffers(widget.id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child:
                                            CircularProgressIndicator(
                                              backgroundColor:
                                              Colors.grey.withOpacity(0.4),
                                              color: AppColors.primaryColor,
                                              strokeCap: StrokeCap.round,
                                            ));
                                      } else if (snapshot.hasData &&
                                          snapshot.data!.docs.isNotEmpty) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                AppText(
                                                  text:
                                                  'المزايدات(${snapshot.data!.docs.length ?? '0'})',
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  textAlign:
                                                  TextAlign.start,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                                Container(
                                                  alignment:
                                                  Alignment.center,
                                                  width: 120,
                                                  height: 24,
                                                  decoration:
                                                  ShapeDecoration(
                                                    color: const Color(
                                                        0xFFFFFACC),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      const AppText(
                                                        text:
                                                        'الوقت المتبقي',
                                                        color: Color(
                                                            0xFF9A9A9A),
                                                        fontSize: 10,
                                                        textAlign:
                                                        TextAlign
                                                            .start,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                      SizedBox(
                                                        width: 4.w,
                                                      ),
                                                      StreamBuilder<DocumentSnapshot<AuctionTimer>>(
                                                        stream:
                                                        FbFirestoreController().readAuctionTime(widget.id.toString()),
                                                        builder: (context, snapshotSop) {
                                                          print('widget.id${widget.id}');
                                                          if(snapshotSop.connectionState ==ConnectionState.waiting){
                                                            return const AppText(
                                                              text: "00:00:00",
                                                              color: Color(0xFFFF3B3F),
                                                              fontSize: 10,
                                                              textAlign: TextAlign.start,
                                                              fontWeight: FontWeight.w500,
                                                            );
                                                          }else if(snapshotSop.hasData){
                                                            startTimer = DateTime.parse(snapshotSop.data!.data()!.startTime!);
                                                            endTimer = DateTime.parse(snapshotSop.data!.data()!.endTime!);
                                                            return CountdownTimer(
                                                              endTime: DateTime.parse(snapshotSop.data!.data()!.endTime!),
                                                              startTime: DateTime.parse(snapshotSop.data!.data()!.startTime!),
                                                                onLast30Seconds: () {
                                                                  if (!last30) {
                                                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                      setState(() {
                                                                        last30 = true;
                                                                      });
                                                                    });
                                                                  }
                                                                },
                                                              on0Seconds: () {
                                                                NotificationsApiController().closeAuction(id: widget.id);
                                                                _showLogOutDialog(context);
                                                                Future.delayed(const Duration(seconds: 1),(){
                                                                  Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => BottomNavBarMarchant(),
                                                                    ),
                                                                        (route) => false,
                                                                  );
                                                                });
                                                              },
                                                            );
                                                          }else{return const SizedBox();}

                                                        },
                                                      )

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.h,
                                            ),
                                            Container(
                                                height: 500.h,
                                                child: ListView.builder(
                                                    padding:
                                                    EdgeInsets.zero,
                                                    // physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .data!.docs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                            top: 8.h),
                                                        child: InkWell(
                                                            onTap: () {
                                                              /*  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                    const DetailsInvocesScreen(),
                                                  ));*/
                                                            },
                                                            /* child: index == 0?
                                                        Container(
                                                          width: 310.w,
                                                          height: 66.h,
                                                          decoration: ShapeDecoration(
                                                            color: const Color(0xFF064356),
                                                            shape: RoundedRectangleBorder(
                                                              side: const BorderSide(width: 1, color: Color(0xFFEAEAEA)),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: 13.0.w, vertical: 13.h),
                                                            child: Row(

                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,

                                                                  children: [
                                                                    Container(
                                                                      width: 32.w,
                                                                      height: 32.h,
                                                                      decoration:  BoxDecoration(
                                                                        image: DecorationImage(
                                                                          image: NetworkImage(
                                                                            snapshot.data!.docs[index].data().image!,
                                                                          ),
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 8.w,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    AppText(
                                                                      text: snapshot.data!.docs[index].data().name!,
                                                                      color: Colors.white,
                                                                      fontSize: 11,
                                                                      textAlign: TextAlign.start,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                    AppText(
                                                                      text: snapshot.data!.docs[index].data().name!,
                                                                      color: Colors.white,
                                                                      fontSize: 11,
                                                                      textAlign: TextAlign.start,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ],
                                                                ),
                                                                const Spacer(),
                                                                const Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    AppText(
                                                                      text: 'العرض الأعلى',
                                                                      color: Color(0xFFFFF586),
                                                                      fontSize: 12,
                                                                      textAlign: TextAlign.start,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                    AppText(
                                                                      text: '13.500 ر.س',
                                                                      color: Color(0xFFFFF586),
                                                                      fontSize: 12,
                                                                      textAlign: TextAlign.start,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 4.w,
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                        ):*/
                                                            child:
                                                            Container(
                                                              width: 310.w,
                                                              // height: 62.h,
                                                              decoration:
                                                              ShapeDecoration(
                                                                color: index ==0?AppColors.primaryColor:Colors
                                                                    .white,
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  side: const BorderSide(
                                                                      width:
                                                                      1,
                                                                      color:
                                                                      Color(0xFFEAEAEA)),
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      8),
                                                                ),
                                                              ),
                                                              child:
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                    13.0
                                                                        .w,
                                                                    vertical:
                                                                    13.h),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                      children: [
                                                                        Container(
                                                                          width: 32.w,
                                                                          height: 32.h,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          decoration: const BoxDecoration(
                                                                            shape: BoxShape.circle
                                                                          ),
                                                                          child: FadeInImage.assetNetwork(
                                                                            placeholder: 'assets/images/businessman.png',
                                                                            image: snapshot.data!.docs[index].data().image!,
                                                                            fit: BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                      8.w,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        AppText(
                                                                          text: snapshot.data!.docs[index].data().name!,
                                                                          color: index ==0?Colors.white:Colors.black,
                                                                          fontSize: 11,
                                                                          textAlign: TextAlign.start,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        AppText(
                                                                          text: snapshot.data!.docs[index].data().city ?? '',
                                                                          color: index ==0?Colors.white:Colors.black,
                                                                          fontSize: 11,
                                                                          textAlign: TextAlign.start,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Spacer(),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                      children: [
                                                                        Visibility(
                                                                          visible: index==0,
                                                                          child: AppText(
                                                                            text: 'العرض الأعلى',
                                                                            color: index ==0?AppColors.yellowColor:Colors.black,
                                                                            fontSize: 12,
                                                                            textAlign: TextAlign.start,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        AppText(
                                                                          text: snapshot.data!.docs[index].data().offerAmount!,
                                                                          color: index ==0?AppColors.yellowColor:AppColors.primaryColor,
                                                                          fontSize: 12,
                                                                          textAlign: TextAlign.start,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                      4.w,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                      );
                                                    })),
                                          ],
                                        );
                                      } else {
                                        return  Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            const AppText(
                                              text:
                                              'المزايدات(${0})',
                                              color: Colors.black,
                                              fontSize: 14,
                                              textAlign:
                                              TextAlign.start,
                                              fontWeight:
                                              FontWeight.w500,
                                            ),
                                            Container(
                                              alignment:
                                              Alignment.center,
                                              width: 120,
                                              height: 24,
                                              decoration:
                                              ShapeDecoration(
                                                color: const Color(
                                                    0xFFFFFACC),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  const AppText(
                                                    text:
                                                    'الوقت المتبقي',
                                                    color: Color(
                                                        0xFF9A9A9A),
                                                    fontSize: 10,
                                                    textAlign:
                                                    TextAlign
                                                        .start,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                  ),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  StreamBuilder<DocumentSnapshot<AuctionTimer>>(
                                                    stream:
                                                    FbFirestoreController().readAuctionTime(widget.id.toString()),
                                                    builder: (context, snapshotSop) {
                                                      print('widget.id${widget.id}');
                                                      if(snapshotSop.connectionState ==ConnectionState.waiting){
                                                        return const AppText(
                                                          text: "00:00:00",
                                                          color: Color(0xFFFF3B3F),
                                                          fontSize: 10,
                                                          textAlign: TextAlign.start,
                                                          fontWeight: FontWeight.w500,
                                                        );
                                                      }else if(snapshotSop.hasData){
                                                        startTimer = DateTime.parse(snapshotSop.data!.data()!.startTime!);
                                                        endTimer = DateTime.parse(snapshotSop.data!.data()!.endTime!);
                                                        return CountdownTimer(
                                                          endTime: DateTime.parse(snapshotSop.data!.data()!.endTime!),
                                                          startTime: DateTime.parse(snapshotSop.data!.data()!.startTime!),
                                                          onLast30Seconds: () {
                                                            if (!last30) {

                                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                setState(() {
                                                                  last30 = true;
                                                                });
                                                              });
                                                            }
                                                          },
                                                          on0Seconds: () {
                                                            NotificationsApiController().closeAuction(id: widget.id);
                                                            _showLogOutDialog(context);
                                                            Future.delayed(const Duration(seconds: 1),(){
                                                              Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => BottomNavBarMarchant(),
                                                                ),
                                                                    (route) => false,
                                                              );
                                                            });
                                                          },
                                                        );
                                                      }else{return const SizedBox();}

                                                    },
                                                  )

                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),

                                  /* Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: 'المزايدات(24)',
                                        color: Colors.black,
                                        fontSize: 14,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 120,
                                        height: 24,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFFFFACC),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                        ),
                                        child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AppText(
                                              text: 'الوقت المتبقي',
                                              color: Color(0xFF9A9A9A),
                                              fontSize: 10,
                                              textAlign: TextAlign.start,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(width: 4.w,),
                                            AppText(
                                              text: '00:04:55',
                                              color: Color(0xFFFF3B3F),
                                              fontSize: 10,
                                              textAlign: TextAlign.start,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ) ,
                                      ),







                                    ],
                                  ),
                                  SizedBox(height: 0.h,),

                                  Container(
                                    height: 500.h,
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        // physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 8.h),
                                            child: InkWell(
                                                onTap: () {
                                                  */
                                  /*Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                const DetailsMerchantInvocesScreen(),
                                              ));*/
                                  /*
                                                },
                                                child: index == 0?
                                                Container(
                                                  width: 310.w,
                                                  height: 62.h,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF064356),
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(width: 1, color: Color(0xFFEAEAEA)),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 13.0.w, vertical: 13.h),
                                                    child: Row(

                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,

                                                          children: [
                                                            Container(
                                                              width: 32.w,
                                                              height: 32.h,
                                                              decoration: const BoxDecoration(
                                                                image: DecorationImage(
                                                                  image: AssetImage(
                                                                    'assets/images/Male.png',
                                                                  ),
                                                                  fit: BoxFit.fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 8.w,
                                                        ),
                                                        const Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            AppText(
                                                              text: 'راشد عبد الرحمن',
                                                              color: Colors.white,
                                                              fontSize: 11,
                                                              textAlign: TextAlign.start,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            AppText(
                                                              text: 'مكة المكرمة',
                                                              color: Colors.white,
                                                              fontSize: 11,
                                                              textAlign: TextAlign.start,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,

                                                          children: [
                                                            AppText(
                                                              text: 'العرض الأعلى',
                                                              color: Color(0xFFFFF586),
                                                              fontSize: 12,
                                                              textAlign: TextAlign.start,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            AppText(
                                                              text: '13.500 ر.س',
                                                              color: Color(0xFFFFF586),
                                                              fontSize: 12,
                                                              textAlign: TextAlign.start,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ):
                                                Container(
                                                  width: 310.w,
                                                  height: 62.h,
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(width: 1, color: Color(0xFFEAEAEA)),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 13.0.w, vertical: 13.h),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,

                                                          children: [
                                                            Container(
                                                              width: 32.w,
                                                              height: 32.h,
                                                              decoration: const BoxDecoration(
                                                                image: DecorationImage(
                                                                  image: AssetImage(
                                                                    'assets/images/Male.png',
                                                                  ),
                                                                  fit: BoxFit.fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 8.w,
                                                        ),
                                                        const Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            AppText(
                                                              text: 'راشد عبد الرحمن',
                                                              color: Colors.black,
                                                              fontSize: 11,
                                                              textAlign: TextAlign.start,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            AppText(
                                                              text: 'مكة المكرمة',
                                                              color: Colors.black,
                                                              fontSize: 11,
                                                              textAlign: TextAlign.start,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,

                                                          children: [

                                                            AppText(
                                                              text: '13.500 ر.س',
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              textAlign: TextAlign.start,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ),
                                          );
                                        }),
                                  ),*/

                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: AppTextField(
                                            controller:
                                            _costTextEditingController,
                                            hintText:
                                            'أكتب سعر العرض الخاص بك',
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: false,
                                                signed: false),
                                            onChanged: (p0) {},
                                            height: 40,
                                            width: 238.w,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.h,
                                      ),
                                      GetBuilder<LoadingGetexController>(
                                        init: LoadingGetexController(),
                                        builder: (LoadingGetexController
                                        loadingController) {
                                          return InkWell(
                                            onTap: () async {
                                              if (loadingController
                                                  .loading ==
                                                  false) {
                                                loadingController
                                                    .changeLoadingStatus();
                                                if(last30){
                                                  if(endTimer != null &&startTimer != null) {
                                                    await _performAddOffer(endTime: endTimer!.add(const Duration(seconds: 30)),startTime:startTimer!);
                                                    /*Duration difference = endTimer!.difference(startTimer!);
                                                    if(difference.inSeconds<=30){
                                                      print(difference.inSeconds);
                                                      await _performAddOffer(endTimer!.add(Duration(seconds: 30)),endTimer!);
                                                    }*/
                                                  }
                                                }else{
                                                  await _performAddOffer();
                                                }
                                                loadingController
                                                    .changeLoadingStatus();
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 68.w,
                                              height: 40.h,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFFFFACC),
                                                shape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        8)),
                                              ),
                                              child: loadingController
                                                  .loading
                                                  ? SizedBox(
                                                  height: 25.h,
                                                  width: 25.w,
                                                  child:
                                                  CircularProgressIndicator(
                                                    color: AppColors
                                                        .primaryColor,
                                                    backgroundColor:
                                                    Colors.grey
                                                        .shade300,
                                                    strokeCap:
                                                    StrokeCap.round,
                                                    strokeWidth: 3.w,
                                                  ))
                                                  : const AppText(
                                                text: 'إضافة',
                                                color:
                                                Color(0xFF064356),
                                                fontSize: 12,
                                                textAlign:
                                                TextAlign.start,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future<void> _performAddOffer(
      {DateTime? endTime, DateTime? startTime}) async {
    if (checkedData()) {
      await _addOffer(endTime,startTime);
    }
  }

  bool checkedData() {
    if (_costTextEditingController.text.isNotEmpty) {
      return true;
    } else {
      context.showSnackBar(message: 'ادخل سعر!!', error: true);
      return false;
    }
  }

  Future<void> _addOffer(DateTime? endTime,DateTime? startTime) async {
    ApiResponse<AllOffer> apiResponse = await MerchantApiController()
        .merchantAddOffer(
            id: widget.id, offerAmount: _costTextEditingController.text);
    if (apiResponse.success) {
      await FbFirestoreController().createOffer(apiResponse.object!, widget.id.toString());
      if(last30 && startTime != null && endTime != null){
        await FbFirestoreController().updateAuctionTime(widget.id.toString(),isVegetable: true,endTime: endTime,startTime: startTime);
      }
      _costTextEditingController.clear();
    } else {
      context.showSnackBar(message: apiResponse.message, error: true);
    }
  }

  Future<void> _showLogOutDialog(BuildContext context) async {
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
              const AppText(
                text: 'لقد انتهى المزاد',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 24.h),

            ],
          ),
        );
      },
    );
  }
  void _checkTime() {
    final currentTime = DateTime.now();
    if(widget.type == 1){
      if (currentTime.hour == 10 && currentTime.minute >= 0) {
        NotificationsApiController().closeAuction(id: widget.id);
        _performAction();
      }
    }else {
      if (currentTime.hour == 11 && currentTime.minute >= 0) {
        NotificationsApiController().closeAuction(id: widget.id);
        _performAction();
      }
    }

  }

  void _performAction() {
    _showLogOutDialog(context);
    Future.delayed(const Duration(seconds: 1),(){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBarMarchant(),
        ),
            (route) => false,
      );
    });
  }

}
