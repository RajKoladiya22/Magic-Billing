import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_app/domain/validations/validation.dart';

class WidgetClass {
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController repasswordController = TextEditingController();

  static dynamic bottomSheet(TextEditingController emailController,
      TextEditingController passwordController) {
    return Get.bottomSheet(
        Container(
          height: 440.h,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: SingleChildScrollView(
            child: Column(
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter your email"),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter password"),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "forget password",
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp, color: Colors.grey.shade700),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      emailController.clear;
                      passwordController.clear;
                      signUpBottomsheet(emailController, passwordController);
                    },
                    child: Text(
                      "Don't have an account? ",
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp, color: Colors.grey.shade700),
                    ),
                    
                  ),
                ),
                 SizedBox(
                height: 5.h,
              ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();
                          bool isEmail = Validation.emailValidation(email);
                          bool isPassword =
                              Validation.passwordValidation(password);

                          if (isEmail == false) {
                            Get.snackbar('invalid email', "",
                                backgroundColor: Colors.white);
                          } else if (isPassword == false) {
                            Get.snackbar('invalid password', "",
                                backgroundColor: Colors.white);
                          } else if (isEmail == false && isPassword == false) {
                            Get.snackbar('invalid email - password', "",
                                backgroundColor: Colors.white);
                          } else {
                            Get.snackbar('ur logged in', "",
                                backgroundColor: Colors.green);
                          }
                        },
                        child: button("Log in", Colors.blue, Colors.white, 40)),
                    Text(
                      "---------------- or ----------------",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                    GestureDetector(
                        child: button(
                      "Continue with Google",
                      Colors.blue,
                      Colors.white,
                      40,
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
        isScrollControlled: true);
  }

  static Widget button(String text, Color color, Color textColor, int height) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, left: 15.w, right: 15.w),
      child: Container(
        alignment: Alignment.center,
        height: height.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              color: textColor, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static Future signUpBottomsheet(TextEditingController emailController,
      TextEditingController passwordController) {
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        height: 550.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                "Sign-up",
                style: GoogleFonts.poppins(
                    fontSize: 26.sp, fontWeight: FontWeight.w700),
              ),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter First name"),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Enter Last name"),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter your email"),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Enter password"),
              ),
              TextFormField(
                controller: repasswordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "re-Enter password"),
              ),
             
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    emailController.clear;
                    passwordController.clear;
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
                      onTap: () {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        bool isEmail = Validation.emailValidation(email);
                        bool isPassword =
                            Validation.passwordValidation(password);

                        if (firstNameController.text.isEmpty &&
                            lastNameController.text.isEmpty) {
                          Get.snackbar('pls fill all field', "",
                              backgroundColor: Colors.white);
                        } else if (passwordController.text !=
                            repasswordController.text) {
                          Get.snackbar('enter same password', "",
                              backgroundColor: Colors.white);
                        } else if (isEmail == false) {
                          Get.snackbar('invalid email', "",
                              backgroundColor: Colors.white);
                        } else if (isPassword == false) {
                          Get.snackbar('invalid password', "",
                              backgroundColor: Colors.white);
                        } else if (isEmail == false && isPassword == false) {
                          Get.snackbar('invalid email - password', "",
                              backgroundColor: Colors.white);
                        } else {
                          firstNameController.clear();
                          lastNameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          repasswordController.clear();

                          Get.snackbar('ur logged in', "",
                              backgroundColor: Colors.green);
                        }
                      },
                      child: button("Sign up", Colors.blue, Colors.white, 40)),
                  Text(
                    "---------------- or ----------------",
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                  GestureDetector(
                      child: button(
                    "Continue with Google",
                    Colors.blue,
                    Colors.white,
                    40,
                  ))
                ],
              )
            ],
          ),
          
        ),), isScrollControlled: true);
  }
}
