
import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WonAcction_MarchantScreen extends StatefulWidget {
  const WonAcction_MarchantScreen({required this.image,required this.name,required this.city,super.key});
 final String image;
 final String name;
 final String city;
  @override
  State<WonAcction_MarchantScreen> createState() => _WonAcction_MarchantScreenState();
}

class _WonAcction_MarchantScreenState extends State<WonAcction_MarchantScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          children: [
            SizedBox(
              height: 70.h,
            ),


            Row(
              children: [
                InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back)),
                SizedBox(width: 110.w,),

                // AppText(
                //   text: 'تفاصيل الفاتورة',
                //   color: Colors.black,
                //   fontSize: 18,
                //   fontWeight: FontWeight.w500,
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
            SizedBox(height: 71.h,),

            Padding(
              padding:  EdgeInsets.only(left: 132.w,right: 132.w),
              child: Container(
                width: 126.w,
                height: 126.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/WonImg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h,),


            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: 'لقد ربحت المزاد',
                  color: Colors.black,
                  fontSize: 18,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,


                ),
              ],
            ),
            SizedBox(height: 41.h,),

            Container(
              width: 322.w,
              // height: 193.h,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x26D1D1D1),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                    spreadRadius: 0,
                  )
                ],
              ),
              child:  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
                child: Column(
                  children: [
                    const AppText(
                      text: 'تفاصيل البائع',
                      color: Colors.black,
                      fontSize: 18,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w300,


                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      width: 40.w,
                      height: 40.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle
                      ),
                      child: widget.image!=''?FadeInImage.assetNetwork(
                        placeholder:
                        'assets/images/businessman.png',
                        image: widget.image,
                        fit: BoxFit.fill,
                      ):const SizedBox(),
                    ),
                    SizedBox(height: 4.h,),

                    AppText(
                      text: widget.name,
                      color: Colors.black,
                      fontSize: 16,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w400,),
                    SizedBox(height: 4.h,),
                    AppText(
                      text: widget.city,
                      color: Colors.black,
                      fontSize: 16,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 15.h,),

                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
