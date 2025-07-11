import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_app/config/api_config.dart';
import 'package:invoice_app/data/services/login_service.dart';
import 'package:invoice_app/domain/models/user_info_model.dart';

class ApiService {
  //DONE
  static Future<UserInfoModel?> signUpApi(
      {required String name,
      required String lastName,
      required String eMail,
      required String pass}) async {
    try {
      var data = jsonEncode({
        "firstName": name,
        "lastName": lastName,
        "email": eMail,
        "password": pass
      });
      http.Response response = await http.post(
          Uri.parse("${ApiConfig.baseUrl}auth/signup"),
          headers: ApiConfig.headers,
          body: data);
      log(response.body);
      if (response.statusCode == 200) {}
    } catch (e) {
      Get.snackbar("$e", "$e");
    }
    return null;
  }

// DONE
  static Future<UserInfoModel?> loginApi(
      {required String eMail, required String pass}) async {
    try {
      var data = jsonEncode({"email": eMail, "password": pass});
      http.Response res = await http.post(
          Uri.parse("${ApiConfig.baseUrl}auth/signin"),
          headers: ApiConfig.headers,
          body: data);

      if (res.statusCode == 200) {
        log('${jsonDecode(res.body)}');

        UserInfoModel model = UserInfoModel.mapToModel(jsonDecode(res.body));
        return model;
      }
    } catch (e) {
      log('$e');
    }
  }

  static forgotPasswordApi(String eMail) async {
    try {
      var data = jsonEncode({"email": eMail});

      http.Response res = await http.post(
          Uri.parse("${ApiConfig.baseUrl}auth/forgot-password"),
          headers: ApiConfig.headers,
          body: data);

      if (res.statusCode == 200) {
        log(res.body);
      }
    } catch (e) {
      log("$e");
    }
  }

  static sentOtp(String eMail) async {
    try {
      log("Sending OTP $eMail");
      var data = jsonEncode({"email": eMail});
      log(data);
      http.Response res = await http.post(
          Uri.parse("${ApiConfig.baseUrl}auth/send-otp"),
          headers: ApiConfig.headers,
          body: data);
      log("${ApiConfig.headers}");
      log(" OTP ${res.body}");

      if (res.statusCode == 200) {
        log("\n\n\n{$res.body}");
        LoginService.msg.value = "OTP verified successfully.";
      } else {
        LoginService.msg.value = "OTP varification failed";
      }
    } catch (e) {
      log("\n\n\n$e");
    }
  }

  static verifyOtp(String eMail, String otp) async {
    try {
      var data = jsonEncode({"email": eMail, "code": otp});

      http.Response res = await http.post(
          Uri.parse("${ApiConfig.baseUrl}auth/verify-otp"),
          headers: ApiConfig.headers,
          body: data);

      if (res.statusCode == 200) {
        log(res.body);
        return "success";
      } else {
        LoginService.msg.value = "OTP varification failed";
      }
    } catch (e) {
      log("$e");
    }
  }
}
