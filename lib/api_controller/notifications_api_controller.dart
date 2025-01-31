import 'dart:convert';

import 'package:arzaq_app/api_controller/api_settings.dart';
import 'package:arzaq_app/model/all_notifications.dart';
import 'package:arzaq_app/utils/api_helpers.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:http/http.dart' as http;

class NotificationsApiController  with ApiHelpers  {

  Future<List<AllNotifications>> getNotifications() async {
    Uri uri = Uri.parse(ApiSettings.getNotifications);
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['notifications'] as List;
      return dataJsonObject.map((jsonObject) =>
          AllNotifications.fromJson(jsonObject)).toList();
    }else{
      return [];
    }

  }

  Future<void> closeAuction(
      {required int id}) async {
      var url = Uri.parse(ApiSettings.closedAuction.replaceFirst('{id}', id.toString()));
      var response = await http.post(url, headers: headers);
      print('close auction ${response.statusCode}');
  }
}