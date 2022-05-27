// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(
            20,
          ),
          children: [
            TextField(
              autocorrect: false,
              controller: controller.emailC,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Masukkan email anda",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.sendEmail();
                  }
                },
                child: Text(
                  controller.isLoading.isFalse
                      ? "Send Reset Password"
                      : "Loading...",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
