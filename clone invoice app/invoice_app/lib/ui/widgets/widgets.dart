import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_app/data/services/api_service.dart';
import 'package:invoice_app/data/services/login_service.dart';
import 'package:invoice_app/domain/models/user_info_model.dart';
import 'package:invoice_app/domain/validations/validation.dart';
import 'package:invoice_app/routes/app_routes.dart';

class WidgetClass {
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController repasswordController = TextEditingController();
  static TextEditingController otpController = TextEditingController();

  static dynamic bottomSheet(TextEditingController emailController,
      TextEditingController passwordController) {
    emailController.clear();
    passwordController.clear();
    LoginService.msg.value = "";

    return Get.bottomSheet(
        Container(
          height: 460.h,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: SingleChildScrollView(
            child: Obx(() {
              if (LoginService.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "SWIPE",
                    style: GoogleFonts.poppins(
                        fontSize: 26.sp, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Welcome ",
                    style: GoogleFonts.poppins(
                        fontSize: 26.sp, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "E-mail"),
                  ),
                  (LoginService.msg.value == "invalid email")
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            LoginService.msg.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                  ),
                  (LoginService.msg.value == "invalid password" ||
                          LoginService.msg.value == "Invalid Password.")
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(LoginService.msg.value,
                              style: const TextStyle(color: Colors.red)),
                        )
                      : Container(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        (emailController.text == "")
                            ? LoginService.msg.value = "invalid email"
                            : Get.snackbar(
                                "Please check your email for further instructions.",
                                "",
                                colorText: Colors.white,
                                backgroundColor: Color(0xff276ee0));
                        ApiService.forgotPasswordApi(
                            emailController.text.trim());
                      },
                      child: Text(
                        "forget password",
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp, color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        LoginService.msg.value = "";
                        emailController.clear();
                        passwordController.clear();
                        signUpBottomsheet(emailController, passwordController);
                      },
                      child: Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp, color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();
                          bool isEmail = Validation.emailValidation(email);
                          bool isPassword =
                              Validation.passwordValidation(password);

                          if (!isEmail) {
                            LoginService.msg.value = "invalid email";
                          } else if (!isPassword) {
                            LoginService.msg.value = "invalid password";
                          } else {
                            LoginService.isLoading.value = true;
                            UserInfoModel? model = await ApiService.loginApi(
                                eMail: email, pass: password);
                            LoginService.isLoading.value = false;
                            if (model?.success == true) {
                              if (model?.dataModel?.userModel?.isVerified ==
                                  false) {
                                LoginService.isLoading.value = true;
                                await ApiService.sentOtp(
                                    emailController.text.trim());
                                otpController.clear();
                                LoginService.isLoading.value = false;
                                LoginService.txtColor.value = Colors.grey;
                                Get.bottomSheet(
                                    Container(
                                      height: 300.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          spacing: 10,
                                          children: [
                                            Text(
                                              "Verify OTP :",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            TextField(
                                              controller: otpController,
                                              maxLength: 6,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                if (value.length == 6) {
                                                  LoginService.txtColor.value =
                                                      Color(0xff276ee0);
                                                } else {
                                                  LoginService.txtColor.value =
                                                      Colors.grey;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder()),
                                            ),
                                            (LoginService.msg.value ==
                                                    "OTP varification failed")
                                                ? Text(
                                                    "OTP varification failed",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ))
                                                : Container(),
                                            GestureDetector(onTap: () async {
                                              await ApiService.verifyOtp(
                                                  email, otpController.text);
                                              if (LoginService.msg.value ==
                                                  "OTP verified successfully.") {
                                                Get.offNamed(AppRoutes.home);
                                              } else {
                                                LoginService.msg.value =
                                                    "OTP varification failed";
                                              }
                                            }, child: Obx(() {
                                              return button(
                                                  "verify OTP",
                                                  LoginService.txtColor.value,
                                                  Colors.white,
                                                  45,
                                                  Colors.white);
                                            })),
                                          ],
                                        ),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    enableDrag: false,
                                    isDismissible: false);
                              } else {
                                Get.toNamed(AppRoutes.home, arguments: model);
                              }
                            } else {
                              log('${model?.message}');
                              LoginService.msg.value = "Invalid Password.";
                            }
                          }
                        },
                        child: button("Log in", const Color(0xff276ee0),
                            Colors.white, 40, Colors.white),
                      ),
                      Text(
                        "---------------- or ----------------",
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
                      GestureDetector(
                          child: button(
                              "Continue with Google",
                              const Color(0xff276ee0),
                              Colors.white,
                              40,
                              Colors.white))
                    ],
                  )
                ],
              );
            }),
          ),
        ),
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true);
  }

  static Future signUpBottomsheet(TextEditingController emailController,
      TextEditingController passwordController) {
    emailController.clear();
    passwordController.clear();
    repasswordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    return Get.bottomSheet(
        Container(
          padding: EdgeInsets.all(20),
          height: 590.h,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: SingleChildScrollView(
            child: Obx(() {
              if (LoginService.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "Sign-up",
                    style: GoogleFonts.poppins(
                        fontSize: 26.sp, fontWeight: FontWeight.w700),
                  ),
                  (LoginService.msg.value == "pls fill all field")
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: const Text(
                            "pls fill all field",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(),
                  TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "First name"),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 2.h)),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Last name"),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 2.h)),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "E-mail"),
                  ),
                  (LoginService.msg.value == "invalid email")
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: const Text(
                            "invalid email",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "password"),
                  ),
                  (LoginService.msg.value ==
                          "Password must have at least 1 digit, 1 lowercase letter, 1 uppercase letter, 1 special character, and be at least 8 characters long")
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: const Text(
                            "Password must have at least 1 digit, 1 lowercase letter, 1 uppercase letter, 1 special character, and be at least 8 characters long",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(),
                  TextFormField(
                    controller: repasswordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirm password"),
                  ),
                  (LoginService.msg.value == "confirm password" ||
                          LoginService.msg.value == "Already registered")
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            LoginService.msg.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 15.h),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        LoginService.msg.value = "";
                        emailController.clear();
                        passwordController.clear();
                        Get.back();
                      },
                      child: Text(
                        "Already have an account? ",
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp, color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            LoginService.msg.value = "";
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();
                            bool isEmail = Validation.emailValidation(email);
                            bool isPassword =
                                Validation.passwordValidation(password);

                            if (firstNameController.text.isEmpty ||
                                lastNameController.text.isEmpty) {
                              LoginService.msg.value = "pls fill all field";
                            } else if (passwordController.text !=
                                repasswordController.text) {
                              LoginService.msg.value = "confirm password";
                            } else if (!isEmail) {
                              LoginService.msg.value = "invalid email";
                            } else if (!isPassword) {
                              LoginService.msg.value =
                                  "Password must have at least 1 digit, 1 lowercase letter, 1 uppercase letter, 1 special character, and be at least 8 characters long";
                            } else {
                              LoginService.isLoading.value = true;

                              UserInfoModel? model = await ApiService.signUpApi(
                                  name: firstNameController.text,
                                  lastName: lastNameController.text,
                                  eMail: emailController.text,
                                  pass: passwordController.text);

                              LoginService.isLoading.value = false;

                              if (model?.success == true) {
                                Get.toNamed(AppRoutes.home, arguments: model);
                              } else {
                                log('${model?.message}');
                                LoginService.msg.value = "Already registered";
                              }
                              Get.back();
                              LoginService.msg.value = "";
                            }
                          },
                          child: button("Sign up", const Color(0xff276ee0),
                              Colors.white, 40, Colors.white)),
                      Text(
                        "---------------- or ----------------",
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
                      GestureDetector(
                          child: button(
                              "Continue with Google",
                              const Color(0xff276ee0),
                              Colors.white,
                              40,
                              Colors.white))
                    ],
                  )
                ],
              );
            }),
          ),
        ),
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true);
  }

  static Widget button(
      String text, Color color, Color textColor, int height, Color iconColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, left: 15.w, right: 15.w),
      child: Container(
        height: height.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Icon(Icons.arrow_forward, color: iconColor),
            ),
          ],
        ),
      ),
    );
  }

  static Widget text(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static Widget circleAvatar(String link) {
    return CircleAvatar(
      radius: 18.r,
      backgroundImage: NetworkImage(link),
    );
  }
}
