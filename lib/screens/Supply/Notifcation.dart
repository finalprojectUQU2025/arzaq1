import 'package:arzaq_app/api_controller/notifications_api_controller.dart';
import 'package:arzaq_app/model/all_notifications.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/custome_app_text.dart';

class NotifcationScreen extends StatefulWidget {
  @override
  _NotifcationScreenState createState() => _NotifcationScreenState();
}

class _NotifcationScreenState extends State<NotifcationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white10,
      body: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),

          Center(
            child: Image.asset(
              'assets/images/appLogo.png',
              width: 72.w,
              height: 72.h,
            ),
          ),

          SizedBox(
            height: 20.h,
          ),

          //List

          FutureBuilder<List<AllNotifications>>(
            future: NotificationsApiController().getNotifications(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 95.h,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Colors.grey.shade200,
                            Colors.white
                          ])),
                        ),
                        SizedBox(
                          height: 5.h,
                        )
                      ],
                    );
                  },
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: snapshot.data![index].isRead == 0
                              ? Color(0xFFFFFDED)
                              : null),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.0.w, vertical: 12.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    snapshot.data![index].isRead == 0
                                        ? 'assets/images/notification-bold.png'
                                        : 'assets/images/notification.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: snapshot.data![index].title ?? '',
                                    color: Colors.black,
                                    fontSize: 14,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  AppText(
                                    text: snapshot.data![index].details ?? '',
                                    color: Colors.black,
                                    fontSize: 13,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppText(
                                  text: snapshot.data![index].createdAt ?? '',
                                  color: Color(0xFFA7A7A7),
                                  fontSize: 11,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
