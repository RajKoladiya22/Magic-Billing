import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_app/ui/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff276ee0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                WidgetClass.text('Invoices'),
                WidgetClass.text('Payments'),
                WidgetClass.text('Purchases'),
                WidgetClass.text('Inventory'),
                WidgetClass.text('Reports'),
                WidgetClass.text('GST'),
                WidgetClass.text('Insights'),
                WidgetClass.text('Online Store'),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    "There's everything for your\nbusiness in Swipe 🇮🇳",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8.w,
                  children: [
                    WidgetClass.circleAvatar(
                        'https://randomuser.me/api/portraits/men/1.jpg'),
                    WidgetClass.circleAvatar(
                        'https://randomuser.me/api/portraits/men/2.jpg'),
                    WidgetClass.circleAvatar(
                        'https://randomuser.me/api/portraits/men/3.jpg'),
                    WidgetClass.circleAvatar(
                        'https://randomuser.me/api/portraits/men/4.jpg'),
                    WidgetClass.circleAvatar(
                        'https://randomuser.me/api/portraits/men/5.jpg'),
                  ],
                ),
               
                SizedBox(height: 30.h),
                Hero(
                  tag: 'login',
                  child: GestureDetector(
                    onTap: () {
                      emailController.clear;
                      passwordController.clear;
                      WidgetClass.bottomSheet(
                          emailController, passwordController);
                    },
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        WidgetClass.button(
                            "Get Started", Colors.white, Colors.black, 50,Colors.black),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            )
          ],
        ),
      ),
    );
  }
}
