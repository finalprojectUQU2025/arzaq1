import 'package:arzaq_app/api_controller/supply_api_controller.dart';
import 'package:arzaq_app/model/supplier_models/supplier_home_data.dart';
import 'package:get/get.dart';

class SupplyHomeGetxController extends GetxController {
  static SupplyHomeGetxController get to => Get.find<SupplyHomeGetxController>();
  final SupplyHomeApiController _supplyHomeApiController = SupplyHomeApiController();
  SupplyHomeData? homeData;


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
    homeData = await _supplyHomeApiController.getSupplyHomeData();
    loading = false;
    update();
  }

  Future<void> addNewAuction(Auctions auction)async{
    homeData!.auctions!.add(auction);
    update();
  }

  Future<void> deleteAuction(int index) async{
    homeData!.auctions!.removeAt(index);
    update();
  }


}
