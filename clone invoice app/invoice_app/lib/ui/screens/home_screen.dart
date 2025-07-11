import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/domain/models/user_info_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            // Text("${model.dataModel?.userModel?.firstName}"),
            // Text("${model.dataModel?.userModel?.lastName}"),
            // Text("${model.dataModel?.userModel?.email}"),
            // Text("${model.dataModel?.userModel?.isVerified}"),
          ],
        ),
      ),
    );
  }
}