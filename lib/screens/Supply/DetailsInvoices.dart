
import 'package:arzaq_app/api_controller/supply_api_controller.dart';
import 'package:arzaq_app/model/supplier_models/supply_invoices.dart';
import 'package:arzaq_app/utils/app_colors.dart';
import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsInvocesScreen extends StatefulWidget {
  const DetailsInvocesScreen({required this.id,super.key});
  final int id;

  @override
  State<DetailsInvocesScreen> createState() => _DetailsInvocesScreenState();
}

class _DetailsInvocesScreenState extends State<DetailsInvocesScreen> {

  @override
  Widget build(BuildContext context) {
    print(widget.id);
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

                 const AppText(
                  text: 'تفاصيل الفاتورة',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                             ),
               ],
             ),
            SizedBox(height: 32.h,),
            FutureBuilder<SupplyInvoices?>(
              future: SupplyHomeApiController().getSupplyInvoices(id: widget.id),
              builder: (context, snapshot) {
              if(snapshot.connectionState ==ConnectionState.waiting){
                return Center(child: Column(
                  children: [
                    SizedBox(height: 150.h,),
                    CircularProgressIndicator(backgroundColor: Colors.grey.withOpacity(0.4),color: AppColors.primaryColor,strokeCap: StrokeCap.round,),
                  ],
                ));
              }else if(snapshot.hasData&&snapshot.data!= null){
                return Column(
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const AppText(
                          text: 'الرقم التسلسلي للفاتورة : ',
                          color: Colors.black,
                          fontSize: 16,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,


                                             ),
                         AppText(
                          text: snapshot.data!.serialNumber??'',
                          color: Colors.black,
                          fontSize: 16,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,


                                             ),
                       ],
                     ),
                    SizedBox(height: 10.h,),
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
                        padding:  EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            const AppText(
                              text: 'تفاصيل المزاد',
                              color: Colors.black,
                              fontSize: 18,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w300,


                            ),
                            SizedBox(height: 10.h,),
                             AppText(
                              text: snapshot.data!.name??'',
                              color: Colors.black,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w500,


                            ),
                            SizedBox(height: 4.h,),

                             AppText(
                              text: snapshot.data!.quantity??'',
                              color: Colors.black,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w500,


                            ),
                            SizedBox(height: 8.h,),

                             AppText(
                              text: snapshot.data!.sellPrice??'',
                              color: const Color(0xFF064356),
                              fontSize: 17,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: 15.h,),





                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h,),
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
                        padding:  EdgeInsets.all(24.w),
                        child: Column(
                          children: [
                            const AppText(
                              text: 'تفاصيل المشتري',
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
                              decoration:const BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              child: FadeInImage.assetNetwork(
                                placeholder:
                                'assets/images/businessman.png',
                                image: snapshot.data!.image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 4.h,),

                             AppText(
                              text: snapshot.data!.buyerName??'',
                              color: Colors.black,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400,


                            ),
                            SizedBox(height: 4.h,),
                             AppText(
                              text: snapshot.data!.buyerAddress??'',
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
                );
              }else{
                return const SizedBox();
              }
            }
            ,),


          ],
        ),
      ),
    );
  }
}
