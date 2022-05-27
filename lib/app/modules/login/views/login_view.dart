// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kampuskita/app/routes/app_pages.dart';
import 'package:lottie/lottie.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 40 / 100,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 32),
            child: Lottie.asset("assets/image/frontpctwo.json"),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  autocorrect: false,
                  controller: controller.emailC,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  autocorrect: false,
                  obscureText: true,
                  controller: controller.passC,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.login();
                        }
                      },
                      child: Text(
                        controller.isLoading.isFalse ? "Log in" : "Loading...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => Get.toNamed(
                      Routes.FORGOT_PASSWORD,
                    ),
                    child: Text(
                      "Forgot your password?",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
