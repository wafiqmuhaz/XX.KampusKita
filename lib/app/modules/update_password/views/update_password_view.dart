// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              obscureText: true,
              controller: controller.currC,
              decoration: InputDecoration(
                labelText: "Password Lama",
                hintText: "Masukkan Password Lama Anda",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              obscureText: true,
              controller: controller.newC,
              decoration: InputDecoration(
                labelText: "Password Baru",
                hintText: "Masukkan Password Baru Anda",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              obscureText: true,
              controller: controller.confirmC,
              decoration: InputDecoration(
                labelText: "Password Baru",
                hintText: "Masukkan Password Baru Anda Sekali Lagi",
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
                    controller.updatePass();
                  }
                },
                child: Text(
                  (controller.isLoading.isFalse)
                      ? "Ganti Password"
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
