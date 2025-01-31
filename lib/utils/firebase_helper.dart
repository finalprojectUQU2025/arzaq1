

import 'package:arzaq_app/model/fb_response.dart';

mixin FirebaseHelper {
  FbResponse get successResponse =>
      FbResponse('', true);

  FbResponse get errorResponse => FbResponse('فشلت العملية !', false);
}
