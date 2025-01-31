import 'package:arzaq_app/api_controller/supply_api_controller.dart';
import 'package:arzaq_app/model/product_type_model.dart';
import 'package:get/get.dart';


class ProductTypeGetxController extends GetxController {
  static ProductTypeGetxController get to => Get.find<ProductTypeGetxController>();
  final SupplyHomeApiController _auctionApiController = SupplyHomeApiController();
  List<ProductType> auctionType = <ProductType>[];


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
    auctionType = await _auctionApiController.getProductType();
    // print(allGyms.length);
    loading = false;
    update();
  }


}
