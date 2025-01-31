import 'package:arzaq_app/main.dart';
import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextHelper on BuildContext {
  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: AppText(text: message,fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
        backgroundColor: error ? Colors.red.shade700 : Colors.green.shade300,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.down,
      ),
    );
  }
}
