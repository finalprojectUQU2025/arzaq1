import 'package:arzaq_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.obscure = false,
    this.readOnly = false,
    this.enabled = true,
    this.textStyle,
    this.focusNode,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.height = 62,
    this.width,
    this.expands =false,
    this.errorText,
    this.textAlign = TextAlign.start,
    super.key,
  });
 final String? hintText;
 final TextEditingController controller;
 final Widget? suffixIcon;
 final Widget? prefixIcon;
 final TextInputType? keyboardType;
  final bool obscure;
  final bool enabled;
  final bool readOnly;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final double height;
  final double? width;
  final TextAlign textAlign;
  final String? errorText;
  final bool expands;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      style: textStyle,
      onChanged: onChanged,
      showCursor: true,
      cursorColor: AppColors.primaryColor,
      textAlign: textAlign,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        counterText: '',
        errorText: errorText,
        errorMaxLines: 1,
        constraints: BoxConstraints(maxHeight: height.h),
        errorStyle:  TextStyle(fontSize: 0.0.sp),
        hintStyle: GoogleFonts.tajawal(fontSize: 13.sp, color:  Color(0XFFBABABA),),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(width: 2.w, color:  AppColors.primaryColor,),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(width: 0.50.w, color:  Color(0XFFE0E0E0),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(width: 0.50.w, color:  Color(0XFFE0E0E0)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(width: 1.w, color:  Colors.red),
        ),
        focusedErrorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(width: 1.w, color:  Colors.red),
          ),

      ),
      keyboardType: keyboardType,
      obscureText: obscure,
      enabled: enabled,
      readOnly: readOnly,

    );
  }
}