// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_mahasiswa_controller.dart';

class AddMahasiswaView extends GetView<AddMahasiswaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add College Student',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
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
            TextField(
              autocorrect: false,
              controller: controller.jurusanC,
              decoration: InputDecoration(
                labelText: "Jurusan Mahasiswa",
                hintText: "Masukkan jurusan mahasiswa",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
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
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.addMahasiswa();
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? "Add Student" : "Loading...",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
