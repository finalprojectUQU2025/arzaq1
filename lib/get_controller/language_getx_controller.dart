import 'package:get/get.dart';

class LanguageGetexController extends GetxController {

  String? language;

 static LanguageGetexController get to => Get.find<LanguageGetexController>();

/* final GeneralAppRequest _generalAppRequest =GeneralAppRequest();
  List<LanguageModel> langItem =<LanguageModel>[];*/
  List<dynamic> permissionList = <dynamic>[];
  bool loading = false;


}