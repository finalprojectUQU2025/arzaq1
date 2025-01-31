import 'dart:convert';
import 'dart:io';

import 'package:arzaq_app/api_controller/api_settings.dart';
import 'package:arzaq_app/model/supplier_models/my_sales.dart';
import 'package:arzaq_app/model/product_type_model.dart';
import 'package:arzaq_app/model/supplier_models/supplier_home_data.dart';
import 'package:arzaq_app/model/supplier_models/supply_auction_details.dart';
import 'package:arzaq_app/model/supplier_models/supply_invoices.dart';
import 'package:arzaq_app/prefs/shared_pref_controller.dart';
import 'package:arzaq_app/utils/api_helpers.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:http/http.dart' as http;

import '../model/supplier_models/wallet_model.dart';


class SupplyHomeApiController with ApiHelpers {
  Future<SupplyHomeData?> getSupplyHomeData() async {
    Uri uri = Uri.parse(ApiSettings.getSupplyHomeData);
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['allData'];
      return SupplyHomeData.fromJson(dataJsonObject);
    }else{
      return null;
    }


  }


  Future<MySales?> getSupplyMySales() async {
    Uri uri = Uri.parse(ApiSettings.getSupplyMySales);
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['allData'];
      return MySales.fromJson(dataJsonObject);
    }else{
      return null;
    }


  }



  Future<SupplyInvoices?> getSupplyInvoices({required int id}) async {
    Uri uri = Uri.parse(ApiSettings.getSupplyInvoices.replaceFirst('{id}', id.toString()));
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['allData'];
      return SupplyInvoices.fromJson(dataJsonObject);
    }else{
      return null;
    }


  }


  Future<List<ProductType>> getProductType() async {
    Uri uri = Uri.parse(ApiSettings.getProductType);
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'] as List;
      return dataJsonObject.map((jsonObject) =>
          ProductType.fromJson(jsonObject)).toList();
    }else{
      return [];
    }

  }
  Future<WalletDetails?> getWallet() async {
    Uri uri = Uri.parse(ApiSettings.getSupplyWalletDetail);
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'];
      return WalletDetails.fromJson(dataJsonObject);
    }else{
      return null;

    }

  }

  Future<ApiResponse<Auctions>> addAuction(
      {required String productType,
        required String name,
        required String quantity,
        required String startingPrice,
        required String address,
        File? image}) async {
    try {
      Uri url = Uri.parse(ApiSettings.addNewAuction);
      var request = http.MultipartRequest('POST', url);
      request.headers[HttpHeaders.acceptHeader] = 'application/json';
      request.headers[HttpHeaders.authorizationHeader] = SharedPrefController().getValueFor(key: PrefKeys.token.name)!;
      if (image != null) {
        http.MultipartFile multiPartFile =
        await http.MultipartFile.fromPath('image', image.path);
        request.files.add(multiPartFile);
      }
      request.fields["product_type"] = productType;
      request.fields["name"] = name;
      request.fields["quantity"] = quantity;
      request.fields["starting_price"] = startingPrice;
      request.fields["address"] = address;
      var response = await request.send();
      if (response.statusCode == 200) {
        String body = await response.stream.transform(utf8.decoder).first;
        print(response.statusCode);
        print(body);
        var jsonResponse = jsonDecode(body);
        Auctions newAuction = Auctions.fromJson(jsonResponse['data']);
        return ApiResponse<Auctions>(
          jsonResponse['message'], true, newAuction);
      } else if (response.statusCode == 400) {
        String body = await response.stream.transform(utf8.decoder).first;
        var jsonResponse = jsonDecode(body);
        return ApiResponse(
          jsonResponse['message'],
          false,
        );
      } else {
        return ApiResponse('عذرا حصل خطأ ما ! حاول لاحقا', false);
      }
    } on SocketException catch (e) {
      print('خطأ في الشبكة: $e');
      return ApiResponse('خطأ في الشبكة: $e', false);
    } catch (e) {
      print('خطأ: $e');
      return ApiResponse('خطأ: $e', false);
    }
  }

  Future<SupplyAuctionDetails?> getSupplyAuctionDetail({required int id}) async {
    Uri uri = Uri.parse(ApiSettings.getSupplyAuctionDetail.replaceFirst('{id}', id.toString()));
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'];
      return SupplyAuctionDetails.fromJson(dataJsonObject);
    }else{
      return null;
    }


  }

  Future<ApiResponse> deleteAuction({required int id}) async {
    try{
      Uri uri = Uri.parse(ApiSettings.deleteAuction.replaceFirst('{id}', id.toString()));
      var response = await http.delete(uri, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return ApiResponse('تم الحذف بنجاح', true);
      } else {
        return ApiResponse('حصل خطأ ما', false);
      }
    }on SocketException catch (e) {
      print('خطأ في الشبكة: $e');
      return ApiResponse('خطأ في الشبكة: $e', false);
    } catch (e) {
      print('خطأ: $e');
      return ApiResponse('خطأ: $e', false);
    }

  }


}