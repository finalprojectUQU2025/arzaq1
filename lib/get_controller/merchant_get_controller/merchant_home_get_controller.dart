import 'package:arzaq_app/api_controller/merchant_api_controller.dart';
import 'package:arzaq_app/model/merchant_models/merchant_home_data.dart';
import 'package:get/get.dart';

class MerchantHomeGetxController extends GetxController {
  static MerchantHomeGetxController get to => Get.find<MerchantHomeGetxController>();
  final MerchantApiController _merchantApiController = MerchantApiController();
  MerchantHomeData? homeData;


  bool loading = false;
  bool moreLoading = false;
  bool isFirst = true;
  int pageNum = 1;

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading = true;
    homeData = await _merchantApiController.getMerchantHomeData(id: 1);
    loading = false;
    isFirst = false;
    update();
  }

  Future<void> showAuctionType(int id)async{
    moreLoading = true;
    MerchantHomeData? typeAuction = await _merchantApiController.getMerchantHomeData(id: id);
    if(typeAuction != null){
      homeData!.openAuction = typeAuction.openAuction;
    }
    moreLoading = false;
    update();
  }

/*  Future<void> showVegetableAuction()async{
    moreLoading = true;
    MerchantHomeData? vegetableAuction = await _merchantApiController.getMerchantHomeData(id: 1);
    if(vegetableAuction != null){
      homeData!.openAuction = vegetableAuction.openAuction;
    }
    moreLoading = false;
    update();
  }*/


}
