import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginService extends GetxController {
  static RxString msg = "".obs;
  static RxBool isLoading = false.obs;
  static RxBool isOtp = true.obs;
  static Rx<Color> txtColor = Colors.grey.obs;
}
