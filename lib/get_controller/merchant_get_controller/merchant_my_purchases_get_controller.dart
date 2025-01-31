import 'package:arzaq_app/api_controller/merchant_api_controller.dart';
import 'package:arzaq_app/model/merchant_models/my_purchases.dart';
import 'package:get/get.dart';

class MerchantMyPurchasesGetxController extends GetxController {
  static MerchantMyPurchasesGetxController get to => Get.find<MerchantMyPurchasesGetxController>();
  final MerchantApiController _merchantApiController = MerchantApiController();
  MyPurchases? myPurchases;


  bool loading = false;
  bool moreLoading = false;
  int pageNum = 1;

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading = true;
    myPurchases = await _merchantApiController.getMyPurchases();
    loading = false;
    update();
  }



}
