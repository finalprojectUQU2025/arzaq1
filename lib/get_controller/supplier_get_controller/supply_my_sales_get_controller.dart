import 'package:arzaq_app/api_controller/supply_api_controller.dart';
import 'package:arzaq_app/model/supplier_models/my_sales.dart';
import 'package:get/get.dart';

class SupplyMySalesGetxController extends GetxController {
  static SupplyMySalesGetxController get to => Get.find<SupplyMySalesGetxController>();
  final SupplyHomeApiController _supplyHomeApiController = SupplyHomeApiController();
  MySales? mySales;


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
    mySales = await _supplyHomeApiController.getSupplyMySales();
    loading = false;
    update();
  }



}
