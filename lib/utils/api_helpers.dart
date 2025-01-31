import 'dart:io';

import 'package:arzaq_app/prefs/shared_pref_controller.dart';
import 'package:arzaq_app/utils/api_response.dart';

mixin ApiHelpers{
  ApiResponse get errorResponse => ApiResponse('!حدث خطأ ما', false);

  Map<String, String> get headers => {
    HttpHeaders.acceptHeader: 'application/json',
    if (SharedPrefController().getValueFor(key: PrefKeys.loggedIn.name))
      HttpHeaders.authorizationHeader: SharedPrefController().getValueFor(key: PrefKeys.token.name),
  };
}