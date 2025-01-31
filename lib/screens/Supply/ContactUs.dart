import 'package:arzaq_app/api_controller/auth_api_controller.dart';
import 'package:arzaq_app/main.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:arzaq_app/utils/app_colors.dart';
import 'package:arzaq_app/utils/extention.dart';
import 'package:arzaq_app/widgets/app_elevated_button.dart';
import 'package:arzaq_app/widgets/app_text_field.dart';
import 'package:arzaq_app/widgets/custom_app_loading.dart';
import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactusScreen extends StatefulWidget {
  const ContactusScreen({super.key});

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _TitleTextEditingController;
  late TextEditingController _DetailsTextEditingController;
  bool obscure = true;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _TitleTextEditingController = TextEditingController();
    _DetailsTextEditingController = TextEditingController();

  }

  @override
  void dispose() {
    _tabController.dispose();
    /*_firstNode.dispose();
    _passNode.dispose();*/
    _TitleTextEditingController.dispose();
    _DetailsTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              children: [
                SizedBox(
                  height: 70.h,),
                 Row(
                   children: [
                     InkWell(
                       onTap: (){
                         Navigator.of(context).pop();
                       },
                         child: const Icon(Icons.arrow_back)),
                     SizedBox(width: 110.w,),

                     const AppText(
                      text: 'تواصل معنا',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                                 ),],
                 ),
                SizedBox(height: 32.h,),
                const AppText(
                  text: 'عنوان الرسالة',
                  color: Color(0xFF606060),
                  fontSize: 13,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppTextField(
                  controller: _TitleTextEditingController,
                  hintText: 'مثال: استفسار عن  مشكلة',
                  height: 56,
                  maxLines: 1,
                ),
                SizedBox(height: 32.h,),
                const AppText(
                  text: 'تفاصيل الرسالة',
                  color: Color(0xFF606060),
                  fontSize: 13,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppTextField(
                  controller: _DetailsTextEditingController,
                  hintText: 'مثال: حل نزاع بسبب مشكلة...',
                  height: 114,
                  maxLines: 30,
                  minLines: 20,

                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 80.w),
                  child: AppElevatedButton(
                    text: 'إرسال',
                    height: 46,
                    width: 185.w,
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      await _performContactUs();
                      setState(() {
                        isLoading = false;
                      });
                    },),
                ),

              ],
            ),
            Visibility(
                visible: isLoading == true,
                child: const CustomAppLoading()),
          ],
        ),
      ),
    );
  }
  Future _performContactUs() async {
    if (checkData()) {
      await _contactUs();
    }
  }

  bool checkData() {
    if (_TitleTextEditingController.text.isNotEmpty &&
        _DetailsTextEditingController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(
        message: 'الرجاء ادخل البيانات المطلوبة!', error: true);
    return false;
  }

  Future<void> _contactUs() async {
    ApiResponse apiResponse = await AuthApiController().contactUs(
      title: _TitleTextEditingController.text,
      details: _DetailsTextEditingController.text,
    );
    if (apiResponse.success) {
      _TitleTextEditingController.clear();
      _DetailsTextEditingController.clear();
    }
    context.showSnackBar(
      message: apiResponse.message,
      error: !apiResponse.success,
    );

  }
}
