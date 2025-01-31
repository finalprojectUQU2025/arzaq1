import 'dart:convert';
import 'dart:io';

import 'package:arzaq_app/api_controller/api_settings.dart';
import 'package:arzaq_app/model/merchant_models/merchant_auction_details.dart';
import 'package:arzaq_app/model/merchant_models/merchant_home_data.dart';
import 'package:arzaq_app/model/merchant_models/merchant_invoices.dart';
import 'package:arzaq_app/model/merchant_models/my_purchases.dart';
import 'package:arzaq_app/model/supplier_models/supply_auction_details.dart';
import 'package:arzaq_app/utils/api_helpers.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:http/http.dart' as http;

import '../model/merchant_models/AddwalletMarchant_model.dart';
import '../model/merchant_models/walletMarchant_model.dart';

class MerchantApiController  with ApiHelpers {


  Future<MerchantHomeData?> getMerchantHomeData({required int id}) async {
    Uri uri = Uri.parse(ApiSettings.getMerchantHomeData.replaceFirst('{id}', id.toString()));
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      print(response);
      var json = jsonDecode(response.body);
      var dataJsonObject = json['allData'];
      return MerchantHomeData.fromJson(dataJsonObject);
    }else{
      return null;
    }


  }

  Future<MyPurchases?> getMyPurchases() async {
    Uri uri = Uri.parse(ApiSettings.getMyPurchases);
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['allData'];
      return MyPurchases.fromJson(dataJsonObject);
    }else{
      return null;
    }


  }

  Future<MerchantInvoices?> getMerchantInvoices({required int id}) async {
    Uri uri = Uri.parse(ApiSettings.getMerchantInvoices.replaceFirst('{id}', id.toString()));
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['allData'];
      return MerchantInvoices.fromJson(dataJsonObject);
    }else{
      return null;
    }


  }

  Future<MerchantAuctionDetails?> getMerchantAuctionDetails({required int id}) async {
    Uri uri = Uri.parse(ApiSettings.getMerchantAuctionDetail.replaceFirst('{id}', id.toString()));
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'];
      return MerchantAuctionDetails.fromJson(dataJsonObject);
    }else{
      return null;
    }


  }
  Future<WalletmarchantDetails?> getWalletMarchant() async {
    Uri uri = Uri.parse(ApiSettings.getMarchantWalletDetail);
    var response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'];
      return WalletmarchantDetails.fromJson(dataJsonObject);
    }else{
      return null;

    }

  }
  Future<ApiResponse<AddWalletmarchant>> addWalletMarchant(
      {required String card_holder_name,
        required String card_number,
        required String card_expiry,
        required String card_cvv,
        required String balance,
      }) async {
    try {
      var url = Uri.parse(ApiSettings.AddMarchntWallet);
      var response = await http.post(url, body: {
        'card_holder_name': card_holder_name,
        'card_number': card_number,
        'card_expiry': card_expiry,
        'card_cvv': card_cvv,
        'balance': balance,
      }, headers: headers);
      print(response.statusCode);
      print('1 ${card_holder_name}');
      print('2 ${card_number}');
      print('3 ${card_expiry}');
      print('4 ${card_cvv}');
      print('5 ${balance}');
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        AddWalletmarchant newaddWallet = AddWalletmarchant.fromJson(json['data']);
        return ApiResponse(json['message'], true, newaddWallet);
      } else if (response.statusCode == 400) {
        var json = jsonDecode(response.body);
        print('12333 ${response.body}');

        return ApiResponse(json['message'], false);
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


  Future<ApiResponse<AllOffer>> merchantAddOffer(
      {required int id,required String offerAmount}) async {
    try {
      var url = Uri.parse(ApiSettings.merchantAddOffer.replaceFirst('{id}', id.toString()));
      var response = await http.post(url, body: {
        'offer_amount': offerAmount,
      }, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        AllOffer newOffer = AllOffer.fromJson(json['data']);
        return ApiResponse(json['message'], true, newOffer);
      } else if (response.statusCode == 400) {
        var json = jsonDecode(response.body);
        return ApiResponse(json['message'], false);
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



}