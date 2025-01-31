import 'package:arzaq_app/api_controller/supply_api_controller.dart';
import 'package:arzaq_app/model/supplier_models/my_sales.dart';
import 'package:get/get.dart';

import '../../model/supplier_models/wallet_model.dart';

class SupplyMyWalletGetxController extends GetxController {
  static SupplyMyWalletGetxController get to => Get.find<SupplyMyWalletGetxController>();
  final SupplyHomeApiController _supplyHomeApiController = SupplyHomeApiController();
  WalletDetails? myWallet;


  bool loading = false;
  bool moreLoading = false;

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading = true;
    myWallet = await _supplyHomeApiController.getWallet();
    loading = false;
    update();
  }



}
