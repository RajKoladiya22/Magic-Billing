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
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              '\n\nInvoice\nPayments\nPurchases\nInventory\nReports\nGST\nInsights\nOnline',
              textScaler: TextScaler.linear(1.5),
              style: GoogleFonts.aBeeZee(
                  color: Colors.white60,
                  fontWeight: FontWeight.bold,
                  fontSize: 26.sp),
            ),
          ),
          Hero(
              tag: 'login',
              child: GestureDetector(
                  onTap: () {
                    emailController.clear;
                    passwordController.clear;
                    WidgetClass.bottomSheet(
                        emailController, passwordController);
                  },
                  child: WidgetClass.button(
                      "Get Started", Colors.white, Colors.black, 50)))
        ],
      ),
    );
  }
}
