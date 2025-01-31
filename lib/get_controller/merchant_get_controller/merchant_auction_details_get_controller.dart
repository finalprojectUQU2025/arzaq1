import 'package:arzaq_app/api_controller/merchant_api_controller.dart';
import 'package:arzaq_app/model/merchant_models/merchant_auction_details.dart';
import 'package:get/get.dart';

class MerchantAuctionDetailsGetxController extends GetxController {
  static MerchantAuctionDetailsGetxController get to => Get.find<MerchantAuctionDetailsGetxController>();
  final MerchantApiController _merchantApiController = MerchantApiController();
  MerchantAuctionDetails? auctionDetails;


  bool loading = false;
  bool moreLoading = false;
  int pageNum = 1;
  int id;

  MerchantAuctionDetailsGetxController(this.id);

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading = true;
    auctionDetails = await _merchantApiController.getMerchantAuctionDetails(id: id);
    loading = false;
    update();
  }


}
