import 'package:arzaq_app/api_controller/auth_api_controller.dart';
import 'package:arzaq_app/model/city_model.dart';
import 'package:get/get.dart';


class CitiesGetxController extends GetxController {
  static CitiesGetxController get to => Get.find<CitiesGetxController>();
  final AuthApiController _authApiController = AuthApiController();
  List<CityModel> cities = <CityModel>[];


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
    cities = await _authApiController.getCites();
    // print(allGyms.length);
    loading = false;
    update();
  }


}
