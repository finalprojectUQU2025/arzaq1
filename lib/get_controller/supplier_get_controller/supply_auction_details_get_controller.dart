import 'package:arzaq_app/api_controller/supply_api_controller.dart';
import 'package:arzaq_app/model/supplier_models/supply_auction_details.dart';
import 'package:get/get.dart';

class SupplyActionDetailsGetxController extends GetxController {
  static SupplyActionDetailsGetxController get to => Get.find<SupplyActionDetailsGetxController>();
  final SupplyHomeApiController _supplyHomeApiController = SupplyHomeApiController();
  SupplyAuctionDetails? auctionDetails;


  bool loading = false;
  bool moreLoading = false;
  int pageNum = 1;
  int id;

  SupplyActionDetailsGetxController(this.id);

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading = true;
    auctionDetails = await _supplyHomeApiController.getSupplyAuctionDetail(id: id);
    loading = false;
    update();
  }



}
