
import 'package:get/get.dart';

class LoadingGetexController extends GetxController {
  static LoadingGetexController get to => Get.find<LoadingGetexController>();
  bool loading = false;
  bool timerEnd = false;
  void changeLoadingStatus(){
    loading = !loading;
    update();
  }

  void changeTimerEnd(){
    if(timerEnd==false){
      timerEnd =true;
      update();
    }

  }
}