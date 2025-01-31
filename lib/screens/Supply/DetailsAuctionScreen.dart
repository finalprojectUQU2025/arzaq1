import 'dart:async';

import 'package:arzaq_app/api_controller/fb_controller.dart';
import 'package:arzaq_app/get_controller/supplier_get_controller/supply_auction_details_get_controller.dart';
import 'package:arzaq_app/model/auction_timer.dart';
import 'package:arzaq_app/model/supplier_models/supply_auction_details.dart';
import 'package:arzaq_app/screens/Supply/NavegatorBar.dart';
import 'package:arzaq_app/utils/app_colors.dart';
import 'package:arzaq_app/widgets/app_elevated_button.dart';
import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:arzaq_app/widgets/timer2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../api_controller/notifications_api_controller.dart';

class DetailsAuctionScreen extends StatefulWidget {
  const DetailsAuctionScreen({required this.id,required this.type,super.key});
  final int id;
  final int type;

  @override
  State<DetailsAuctionScreen> createState() => _DetailsAuctionScreenState();
}

class _DetailsAuctionScreenState extends State<DetailsAuctionScreen> {


  bool obscure = true;
  bool isLoading = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkTime();
    });
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkTime();
    });
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SupplyActionDetailsGetxController>(
        init: SupplyActionDetailsGetxController(widget.id),
        builder: (controller) {
        if(controller.loading==true){
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.grey.withOpacity(0.4),color: AppColors.primaryColor,strokeCap: StrokeCap.round,));
        }else if(controller.auctionDetails!=null){
          return Column(
            children: [
              Stack(
                children: [

                  Container(
                    // width: 390.w,
                    height: 243.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(controller.auctionDetails!.image??''),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 50.h,right: 20.w),
                    child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back)),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 110.h,),

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
                            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                            child: Column(
                              children: [
                                const AppText(
                                  text: 'تفاصيل المزاد',
                                  color: Colors.black,
                                  fontSize: 18,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,),
                                SizedBox(height: 16.h,),
                                AppText(
                                  text: controller.auctionDetails!.name??'',
                                  color: Colors.black,
                                  fontSize: 16,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,),
                                SizedBox(height: 4.h,),
                                AppText(
                                  text: controller.auctionDetails!.quantity??'',
                                  color: Colors.black,
                                  fontSize: 16,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,),
                                SizedBox(height: 8.h,),
                                AppText(
                                  text: controller.auctionDetails!.startingPrice??'',
                                  color: const Color(0xFF064356),
                                  fontSize: 17,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(height: 15.h,),
                                Container(
                                  width: 316.w,
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Color(0xFFD8D8D8),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h,),


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
                                                          return CountdownTimer(
                                                            endTime: DateTime.parse(snapshotSop.data!.data()!.endTime!),
                                                            startTime: DateTime.parse(snapshotSop.data!.data()!.startTime!),
                                                            onLast30Seconds: () {
                                                            },
                                                            on0Seconds: () {
                                                              NotificationsApiController().closeAuction(id: widget.id);
                                                              _showLogOutDialog(context);
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
                                                      return CountdownTimer(
                                                        endTime: DateTime.parse(snapshotSop.data!.data()!.endTime!),
                                                        startTime: DateTime.parse(snapshotSop.data!.data()!.startTime!),
                                                        onLast30Seconds: () {

                                                        },
                                                        on0Seconds: () {
                                                          NotificationsApiController().closeAuction(id: widget.id);
                                                          _showLogOutDialog(context);
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
        }else{
          return const SizedBox();
        }
      },),
    );
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
              AppElevatedButton(text: 'حسنا', onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBar(),), (route) => false,);
              },)

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

  }

}
