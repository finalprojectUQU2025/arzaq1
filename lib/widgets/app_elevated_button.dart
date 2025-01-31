import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../utils/app_colors.dart';


class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.side,
    this.width=double.infinity,
    this.fontSize=16,
    this.height=40,
    super.key,
  });
 final String text;
 final double? width;
 final Color backgroundColor;
 final Color textColor;
 final double fontSize;
 final void Function() onPressed;
 final BorderSide? side;
 final double height;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width!, height.h),
        maximumSize: Size(width!, height.h),
        side: side,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(8.r),

        ),
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: onPressed,
      child:  AppText(
        fontSize: fontSize,
        text: text,
        color: textColor,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
        height: 2.h,
      ),
    );
  }
}