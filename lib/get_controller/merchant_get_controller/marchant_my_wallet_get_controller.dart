
import 'package:get/get.dart';

import '../../api_controller/merchant_api_controller.dart';
import '../../model/merchant_models/AddwalletMarchant_model.dart';
import '../../model/merchant_models/walletMarchant_model.dart';
import '../../model/supplier_models/wallet_model.dart';

class MarchantMyWalletGetxController extends GetxController {
  static MarchantMyWalletGetxController get to => Get.find<MarchantMyWalletGetxController>();
  final MerchantApiController _merchantApiController = MerchantApiController();
  WalletmarchantDetails? myWallet;
  // AddWalletmarchant? addWallet;


  bool loading = false;
  bool moreLoading = false;

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading = true;
    myWallet = await _merchantApiController.getWalletMarchant();
    // addWallet = await _merchantApiController.addWalletMarchant();
    loading = false;
    update();
  }



}
