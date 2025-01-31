import 'dart:io';

import 'package:arzaq_app/api_controller/fb_controller.dart';
import 'package:arzaq_app/api_controller/supply_api_controller.dart';
import 'package:arzaq_app/get_controller/supplier_get_controller/supply_home_get_controller.dart';
import 'package:arzaq_app/get_controller/product_type_get_controller.dart';
import 'package:arzaq_app/main.dart';
import 'package:arzaq_app/model/supplier_models/supplier_home_data.dart';
import 'package:arzaq_app/model/supplier_models/supply_auction_details.dart';
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
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddAuctionScreen extends StatefulWidget {
  const AddAuctionScreen({super.key});

  @override
  State<AddAuctionScreen> createState() => _AddAuctionScreenState();
}

class _AddAuctionScreenState extends State<AddAuctionScreen> {
  ProductTypeGetxController productController =Get.put<ProductTypeGetxController>(ProductTypeGetxController());
  late TextEditingController _nameTextEditingController;
  late TextEditingController _amontTextEditingController;
  late TextEditingController _costTextEditingController;
  late TextEditingController _addressTextEditingController;
  bool isLoading = false;
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  int? selectedItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextEditingController = TextEditingController();
    _amontTextEditingController = TextEditingController();
    _costTextEditingController = TextEditingController();
    _addressTextEditingController = TextEditingController();
    _imagePicker = ImagePicker();

  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _amontTextEditingController.dispose();
    _costTextEditingController.dispose();
    _addressTextEditingController.dispose();
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
                      text: 'إضافة مزاد',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                                 ),
                   ],
                 ),
                SizedBox(
                  height: 36.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 114.w,right: 114.w),
                  child: InkWell(
                    onTap: () => _pickImage(),
                    child: Container(
                      alignment: Alignment.center,
                      // width: 113.w,
                      height: 90.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Color(0xFFE3E3E3)),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: _pickedImage == null?Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/upload.svg',),
                          SizedBox(height: 8.h,),
                          const AppText(
                            text: 'أرفق صورة المنتج',
                            color: Color(0xFFB9B9B9),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ):Image.file(
                        File(_pickedImage!.path),
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                const AppText(
                  text: 'مسموح بJPG او GIF او PNG. الحد الأقصى للحجم 2ميجا بايت',
                  color: Color(0xFFB9B9B9),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),

                SizedBox(
                  height: 36.h,
                ),




                const AppText(
                  text: 'نوع المنتج',
                  color: Color(0xFF606060),
                  fontSize: 13,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),


                SizedBox(
                  height: 8.h,
                ),
                GetBuilder<ProductTypeGetxController>(
                  builder: (ProductTypeGetxController controller) {
                    if(controller.loading == true){
                      return Container(
                          width: 342.w,
                          height: 56.h,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0XFFE0E0E0)),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          child: Padding(

                            padding:EdgeInsets.symmetric(horizontal: 16.w),
                            child:  const Row(
                              children: [
                                AppText(
                                  text: 'نوع المنتج',
                                  color: Color(0xFF5C5C5C),
                                  fontSize: 12,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                ),
                                Spacer(),
                                Icon(Icons.keyboard_arrow_down_sharp)
                              ],
                            ),


                          )

                      );
                    }else if(controller.auctionType.isNotEmpty){
                      var types = controller.auctionType;
                      return Container(
                        width: 342.w,
                        height: 56.h,
                        padding:EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0XFFE0E0E0)),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          hint: Text(
                            'نوع المنتج',
                            style: GoogleFonts.tajawal(color: Color(0xFF5C5C5C),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,),
                          ),
                          underline: const SizedBox(),
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          items: types.map((type) {
                            return DropdownMenuItem<int>(
                              value: type.id,
                              child: AppText(
                                text: type.name??'',
                                color: Color(0xFF5C5C5C),
                                fontSize: 16,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }).toList(),
                          onChanged: (int? value) {
                            setState(() {
                              selectedItem = value;
                            });
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          value: selectedItem,
                        ),
                      );
                    }else{
                      return Container(
                          width: 342.w,
                          height: 56.h,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0XFFE0E0E0)),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          child: Padding(

                            padding:EdgeInsets.symmetric(horizontal: 16.w),
                            child:  const Row(
                              children: [
                                AppText(
                                  text: 'نوع المنتج',
                                  color: Color(0xFF5C5C5C),
                                  fontSize: 12,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                ),
                                Spacer(),
                                Icon(Icons.keyboard_arrow_down_sharp)
                              ],
                            ),


                          )

                      );
                    }
                  },),
                SizedBox(
                  height: 16.h,
                ),

                const AppText(
                  text: 'اسم المنتج',
                  color: Color(0xFF606060),
                  fontSize: 13,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),


                SizedBox(
                  height: 8.h,
                ),


                AppTextField(
                  controller: _nameTextEditingController,
                  hintText: 'مثال: باذنجان',
                  height: 56,
                  maxLines: 1,

                ),
                SizedBox(
                  height: 16.h,
                ),

                const AppText(
                  text: 'العنوان',
                  color: Color(0xFF606060),
                  fontSize: 13,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),


                SizedBox(
                  height: 8.h,
                ),


                AppTextField(
                  controller: _addressTextEditingController,
                  hintText: 'مثال: جدة - حي الصفا - سوق الفواكه والخضراوات',
                  height: 56,
                  maxLines: 1,

                ),
                SizedBox(
                  height: 24.h,
                ),
                const AppText(
                  text: 'كمية المنتج',
                  color: Color(0xFF606060),
                  fontSize: 13,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppTextField(
                  controller: _amontTextEditingController,
                  hintText: 'مثال: 500 كغم',
                  onChanged: (p0) {

                  },
                  height: 56,
                  maxLines: 1,

                ),
                SizedBox(
                  height: 24.h,
                ),
                const AppText(
                  text: 'السعر الإبتدائي للمزاد',
                  color: Color(0xFF606060),
                  fontSize: 13,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppTextField(
                  controller: _costTextEditingController,
                  hintText: 'مثال: 12.000 ر.س',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {

                  },
                  height: 56,
                  maxLines: 1,

                ),
                SizedBox(
                  height: 51.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 80.w),
                  child: AppElevatedButton(
                    text: 'إضافة المزاد',
                    height: 46,
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      await _performAddAuction();
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
  void _pickImage() async {
    XFile? imageFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() => _pickedImage = imageFile);
    }
  }

  Future<void> _performAddAuction() async {
    if (_checkData()) {
      await _addAuction();
    }
  }

  bool _checkData() {
    if (_nameTextEditingController.text.isNotEmpty &&
        _amontTextEditingController.text.isNotEmpty &&
        _costTextEditingController.text.isNotEmpty &&
        _addressTextEditingController.text.isNotEmpty&&_pickedImage != null&&selectedItem != null ) {
      return true;
      }else{
        context.showSnackBar(message: 'الرجاء اكمال جميع التفاصيل!', error: true);
        return false;
      }
    }

  Future<void> _addAuction() async {
    ApiResponse<Auctions> apiResponse = await SupplyHomeApiController().addAuction(
      productType: selectedItem!.toString(),
      name: _nameTextEditingController.text,
      quantity: _amontTextEditingController.text,
      startingPrice: _costTextEditingController.text,
      address: _addressTextEditingController.text,
      image:_pickedImage != null? File(_pickedImage!.path):null,);
    if (apiResponse.success) {
      await SupplyHomeGetxController.to.addNewAuction(apiResponse.object!);
      await FbFirestoreController().createAuctionTime(apiResponse.object!.id.toString(),selectedItem! == 1?true:false);
      context.showSnackBar(
          message: apiResponse.message, error: !apiResponse.success);
      Navigator.pop(context);
    } else {
      context.showSnackBar(
          message: apiResponse.message, error: !apiResponse.success);
    }
  }
/*  AllOffer get offer {
    AllOffer offer = AllOffer();
    offer.id = 0;
    offer.name ='';
    offer.image = '' ;
    offer.offerAmount= '';

    return offer;
  }*/
}
