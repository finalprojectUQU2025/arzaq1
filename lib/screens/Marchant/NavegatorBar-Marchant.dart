import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'HomeScreen-Marchant.dart';
import 'My-Purchases-Marchant.dart';
import 'My-wallet-Marchant.dart';
import 'Notifcation-Marchant.dart';
import 'Profile-Marchant.dart';


class BottomNavBarMarchant extends StatefulWidget {
  @override
  _BottomNavBarMarchantState createState() => _BottomNavBarMarchantState();
}

class _BottomNavBarMarchantState extends State<BottomNavBarMarchant> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white10,
        bottomNavigationBar:  Padding(
            padding:  EdgeInsets.only(left: 16.w,right: 16.w,bottom: 24.h),
            child: Container(
              // height: 100.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.08),offset: Offset(0, 8),blurRadius: 8)
                ]
              ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(8.0),topStart: Radius.circular(8.0)),

                      child: CurvedNavigationBar(
                        height: 55.h,
                        key: _bottomNavigationKey,
                        index: 0,
                        items: <Widget>[
                          _page == 0? SvgPicture.asset('assets/images/selectedHome.svg',height: 24.h,width: 24.w,): SvgPicture.asset('assets/images/unSelectedHome.svg',height: 24.h,width: 24.w,),
                          _page == 1? SvgPicture.asset('assets/images/selectedNotification.svg',height: 24.h,width: 24.w,):  SvgPicture.asset('assets/images/unSelectedNotification.svg',height: 24.h,width: 24.w,),
                          _page == 2? SvgPicture.asset('assets/images/selectedReceipt.svg',height: 24.h,width: 24.w,):SvgPicture.asset('assets/images/unSelectedReceipt.svg',height: 24.h,width: 24.w,),
                          _page == 3? SvgPicture.asset('assets/images/selectedWallet.svg',height: 24.h,width: 24.w,):SvgPicture.asset('assets/images/unSelectedWallet.svg',height: 24.h,width: 24.w,),
                          _page == 4? SvgPicture.asset('assets/images/selectedMyProfile.svg',height: 24.h,width: 24.w,):SvgPicture.asset('assets/images/unSelectedMyProfile.svg',height: 24.h,width: 24.w,),
                        ],
                        color: Colors.white,
                        buttonBackgroundColor: Colors.white,
                        backgroundColor: Colors.white38,
                        animationCurve: Curves.easeInOut,
                        animationDuration: Duration(milliseconds: 600),
                        onTap: (index) {
                          setState(() {
                            _page = index;
                            print('page $_page');
                          });
                        },
                        letIndexChange: (index) => true,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(8.0),bottomStart: Radius.circular(8.0)),
                        border: Border.all(color: Colors.white,width: 0.w)

                      ),
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: _page==0,
                                  child: AppText(text: 'الرئيسية',fontSize: 12,fontWeight: FontWeight.w500,height: 0.h,)),
                              Visibility(
                                visible: _page==1,
                                  child: AppText(text: 'الاشعارات',fontSize: 12,fontWeight: FontWeight.w500,height: 0.h,)),
                              Visibility(
                                visible: _page==2,
                                  child: AppText(text: 'مشترياتي',fontSize: 12,fontWeight: FontWeight.w500,height: 0.h,)),
                              Visibility(
                                visible: _page==3,
                                  child: AppText(text: 'محفظتي',fontSize: 12,fontWeight: FontWeight.w500,height: 0.h,)),
                              Visibility(
                                visible: _page==4,
                                  child: AppText(text: 'حسابي',fontSize: 12,fontWeight: FontWeight.w500,height: 0.h,)),
                            ],
                          ),
                          SizedBox(height: 5.h,)
                        ],
                      ),
                    ),
                  ],
                ),

            ),
          ),
      body:
      _page == 0?
      Container(
        child: HomeScreen_Marchant(),
      ) :
      _page == 1?
      Container(
        child: NotifcationScreen_Marchant(),
      ) :
      _page == 2?
      Container(
        child: My_PurchasesScreen_Marchant(),
      ) :
      _page == 3?
      Container(
        child: MyWalletScreen_Marchant(),
      ) :
      Container(
        child: ProfileScreen_Marchant(),
      ) ,

    );
  }
}