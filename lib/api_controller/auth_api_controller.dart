import 'dart:convert';
import 'dart:io';

import 'package:arzaq_app/api_controller/api_settings.dart';
import 'package:arzaq_app/model/city_model.dart';
import 'package:arzaq_app/model/conditions_model.dart';
import 'package:arzaq_app/prefs/shared_pref_controller.dart';
import 'package:arzaq_app/utils/api_response.dart';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class AuthApiController {

  Future<ApiResponse> login(
      {required String email, required String password}) async {
    try {
      var url = Uri.parse(ApiSettings.login);
      var response = await http.post(url, body: {
        'guard': 'accountApi',
        'email': email,
        'password': password,
      }, headers: {
        HttpHeaders.acceptHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var baseApiResponse = User.fromJson(json['data']);
        await SharedPrefController().save(user: baseApiResponse);
        return ApiResponse(json['message'], json['status']);
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


  Future<ApiResponse> register(
      {required String type,
      required String name,
      required String phone,
      required String email,
      required String password,
      required String checkConditions,
      required String cityId,
      File? image}) async {
    try {
      Uri url = Uri.parse(ApiSettings.register);
      var request = http.MultipartRequest('POST', url);
      request.headers[HttpHeaders.acceptHeader] = 'application/json';
      if (image != null) {
        http.MultipartFile multiPartFile =
            await http.MultipartFile.fromPath('image', image.path);
        request.files.add(multiPartFile);
      }
      request.fields["type"] = type;
      request.fields["name"] = name;
      request.fields["phone"] = phone;
      request.fields["email"] = email;
      request.fields["password"] = password;
      request.fields["check_conditions"] = checkConditions;
      request.fields["city_id"] = cityId;
      var response = await request.send();
      if (response.statusCode == 200) {
        String body = await response.stream.transform(utf8.decoder).first;
        print(response.statusCode);
        print(body);
        var jsonResponse = jsonDecode(body);
        return ApiResponse<String>(
          jsonResponse['message'],
          true,
          '${jsonResponse['code']}',
        );
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

  Future<ApiResponse> checkCodeVerification({
    required String email,
    required String code,
  }) async {
    try {
      Uri uri = Uri.parse(ApiSettings.checkOtp);
      var response = await http.post(uri, body: {
        'guard': 'accountApi',
        'email': email,
        'code': code,
      }, headers: {
        HttpHeaders.acceptHeader: 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 400) {
        var json = jsonDecode(response.body);
        return ApiResponse(json['message'], json['status']);
      } else {
        return ApiResponse('عذرا حصل خطأ ما !', false);
      }
    } on SocketException catch (e) {
      print('خطأ في الشبكة: $e');
      return ApiResponse('خطأ في الشبكة: $e', false);
    } catch (e) {
      print('خطأ: $e');
      return ApiResponse('خطأ: $e', false);
    }
  }

  Future<bool> logout() async {
    try {
      var url = Uri.parse(ApiSettings.logout);
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: SharedPrefController()
            .getValueFor<String>(key: PrefKeys.token.name)!,
        HttpHeaders.acceptHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        SharedPrefController().clear();
        return true;
      } else {
        return false;
      }
    } on SocketException catch (e) {
      print('خطأ في الشبكة: $e');
      return false;
    } catch (e) {
      print('خطأ: $e');
      return false;
    }
  }
  Future<ApiResponse> reSendMobileNumber({required String email}) async {
    try{
      Uri uri = Uri.parse(ApiSettings.reGenerateOtp);
      var response = await http.post(uri, body: {
        'guard':'accountApi',
        'email':email,
      },headers: {
        HttpHeaders.acceptHeader: 'application/json',
      });
      print(response.statusCode);
      if (response.statusCode == 201) {
        var json = jsonDecode(response.body);
        return ApiResponse<String>(json['message'], json['status'],'${json['code']}');
      }else if(response.statusCode == 400){
        var json = jsonDecode(response.body);
        return ApiResponse(json['message'], false,);
      } else {
        return ApiResponse('عذرا حصل خطأ ما !', false);
      }
    } on SocketException catch (e) {
      print('خطأ في الشبكة: $e');
      return ApiResponse('خطأ في الشبكة: $e', false);
    } catch (e) {
      print('خطأ: $e');
      return ApiResponse('خطأ: $e', false);
    }

  }

  Future<List<Conditions>> getConditions() async {
    Uri uri = Uri.parse(ApiSettings.getConditions);
    var response = await http.get(uri,headers: {
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'] as List;
      return dataJsonObject.map((jsonObject) =>
          Conditions.fromJson(jsonObject)).toList();
    }else{
      return [];
    }

  }
  Future<ApiResponse> sendForgetPasswordCode({required String email}) async {
    try{
      Uri uri = Uri.parse(ApiSettings.sendForgetCode);
      var response = await http.post(uri, body: {
        'guard':'accountApi',
        'email':email,
      },headers: {
        HttpHeaders.acceptHeader: 'application/json',
      });
      print(response.statusCode);
      if (response.statusCode == 201) {
        var json = jsonDecode(response.body);
        return ApiResponse<String>(json['message'], json['status'],'${json['code']}');
      }else if(response.statusCode == 400){
        var json = jsonDecode(response.body);
        return ApiResponse(json['message'], false,);
      } else {
        return ApiResponse('عذرا حصل خطأ ما !', false);
      }
    } on SocketException catch (e) {
      print('خطأ في الشبكة: $e');
      return ApiResponse('خطأ في الشبكة: $e', false);
    } catch (e) {
      print('خطأ: $e');
      return ApiResponse('خطأ: $e', false);
    }

  }

  Future<ApiResponse> checkCodeForget({
    required String email,
    required String code,
  }) async {
    try {
      Uri uri = Uri.parse(ApiSettings.checkCodeForget);
      var response = await http.post(uri, body: {
        'guard': 'accountApi',
        'email': email,
        'code': code,
      }, headers: {
        HttpHeaders.acceptHeader: 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 400) {
        var json = jsonDecode(response.body);
        return ApiResponse(json['message'], json['status']);
      } else {
        return ApiResponse('عذرا حصل خطأ ما !', false);
      }
    } on SocketException catch (e) {
      print('خطأ في الشبكة: $e');
      return ApiResponse('خطأ في الشبكة: $e', false);
    } catch (e) {
      print('خطأ: $e');
      return ApiResponse('خطأ: $e', false);
    }
  }

  Future<ApiResponse> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      Uri uri = Uri.parse(ApiSettings.resetPassword);
      var response = await http.post(uri, body: {
        'guard': 'accountApi',
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }, headers: {
        HttpHeaders.acceptHeader: 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 400) {
        var json = jsonDecode(response.body);
        return ApiResponse(json['message'], json['status']);
      } else {
        return ApiResponse('عذرا حصل خطأ ما !', false);
      }
    } on SocketException catch (e) {
      print('خطأ في الشبكة: $e');
      return ApiResponse('خطأ في الشبكة: $e', false);
    } catch (e) {
      print('خطأ: $e');
      return ApiResponse('خطأ: $e', false);
    }
  }

  Future<ApiResponse> contactUs(
      {required String title, required String details}) async {
    try {
      var url = Uri.parse(ApiSettings.contactUs);
      var response = await http.post(url, body: {
        'title': title,
        'details': details,
      }, headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: SharedPrefController().getValueFor(key: PrefKeys.token.name)!,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return ApiResponse(json['message'], true);
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

  Future<List<CityModel>> getCites() async {
    Uri uri = Uri.parse(ApiSettings.getCities);
    var response = await http.get(uri,headers: {
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'] as List;
      return dataJsonObject.map((jsonObject) =>
          CityModel.fromJson(jsonObject)).toList();
    }else{
      return [];
    }

  }
}
