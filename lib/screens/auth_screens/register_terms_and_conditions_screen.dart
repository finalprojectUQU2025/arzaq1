import 'package:arzaq_app/api_controller/auth_api_controller.dart';
import 'package:arzaq_app/model/conditions_model.dart';
import 'package:arzaq_app/widgets/custom_app_loading.dart';
import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';


class RegisteredTermsAndConditionsScreen extends StatefulWidget {
  const RegisteredTermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredTermsAndConditionsScreen> createState() =>
      _RegisteredTermsAndConditionsScreenState();
}

class _RegisteredTermsAndConditionsScreenState extends State<RegisteredTermsAndConditionsScreen> {
  bool approved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
        children: [
          SizedBox(
            height: 60.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  height: 30.h,
                    width: 30.w,
                    child: const Icon(Icons.arrow_back,)),
              ),
              const Spacer(),
              const AppText(text: 'الشروط والاحكام',color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500,),
              const Spacer(),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          FutureBuilder<List<Conditions>>(
              future: AuthApiController().getConditions(),
              builder: (context, snapshot) {
                if(snapshot.connectionState ==ConnectionState.waiting){
                  return Center(child: Column(
                    children: [
                      SizedBox(height: 150.h,),
                      SizedBox(
                        height: 60.h,
                          width: 60.w,
                          child: CircularProgressIndicator(backgroundColor: Colors.grey.withOpacity(0.4),color: AppColors.primaryColor,strokeCap: StrokeCap.round,)),
                    ],
                  ));
                }else if(snapshot.hasData&&snapshot.data!.isNotEmpty){
                  return  ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         AppText(text: snapshot.data![index].title??'',fontSize: 14,fontWeight: FontWeight.w500,),
                        SizedBox(
                          height: 8.h,
                        ),
                         AppText(text: snapshot.data![index].subTitle??'',fontSize: 14),
                        SizedBox(
                          height: 24.h,
                        ),
                      ],
                    );
                  },);
                }else{
                  return const SizedBox();
                }
              },)


        ],
      ),
    );
  }
}
