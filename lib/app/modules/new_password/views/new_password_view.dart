// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganti Password'),
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
              obscureText: true,
              controller: controller.newPassC,
              decoration: InputDecoration(
                labelText: "Change Password",
                hintText: "Change your password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                controller.newPassword();
              },
              child: Text(
                "Change Password",
              ),
            )
          ],
        ),
      ),
    );
  }
}
