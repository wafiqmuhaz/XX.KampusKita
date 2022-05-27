// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.npmC.text = user["npm"];
    controller.nameC.text = user["name"];
    controller.emailC.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              readOnly: true,
              controller: controller.npmC,
              decoration: InputDecoration(
                labelText: "NPM Mahasiswa",
                hintText: "Masukkan npm mahasiswa",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              readOnly: true,
              controller: controller.emailC,
              decoration: InputDecoration(
                labelText: "Email Mahasiswa",
                hintText: "Masukkan email mahasiswa",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              autocorrect: false,
              controller: controller.nameC,
              decoration: InputDecoration(
                labelText: "Nama Mahasiswa",
                hintText: "Masukkan nama mahasiswa",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Photo Profile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // user["profile"] != null && user["profile"] != ""
                //     ? Text("foto profile")
                //     : Text("Belum Dipilih"),
                GetBuilder<UpdateProfileController>(
                  builder: (c) {
                    if (c.image != null) {
                      return ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.file(
                            File(c.image!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                      // Text("Ada data image");
                    } else {
                      if (user["profile"] != null) {
                        return Column(
                          children: [
                            ClipOval(
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  user["profile"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.deleteprofile(user["uid"]);
                              },
                              child: Text("hapus gambar"),
                            ),
                          ],
                        );
                      } else {
                        return Text("Gambar Belum Dipilih");
                      }
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: Text("pilih gambar"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.updateProfile(user["uid"]);
                  }
                },
                child: Text(
                  controller.isLoading.isFalse
                      ? "Update Profile"
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
