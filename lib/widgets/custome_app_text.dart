import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class AppText extends StatelessWidget {
  const AppText({
    required this.text,
     this.color= Colors.black,
    this.height,
     this.fontSize=16,
    this.textAlign,
    this.fontWeight,
    this.letterSpacing,
    this.wordSpacing,
    this.maxLines,
    this.overflow,
    this.decoration,
    super.key,
  });
  final String text;
  final double fontSize;
  final double? height;
  final Color color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? wordSpacing;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.tajawal(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      ),
    );
  }
}