// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMahasiswaController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddMahasiswa = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController npmC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
  TextEditingController jurusanC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddMahasiswa() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddMahasiswa.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        final userCredentialAdmin = await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        final mahasiswaCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailC.text,
          password: 'password',
        );

        if (mahasiswaCredential.user != null) {
          String uid = mahasiswaCredential.user!.uid;

          await firestore.collection("mahasiswa").doc(uid).set(
            {
              "npm": npmC.text,
              "name": nameC.text,
              "email": emailC.text,
              "jurusan": jurusanC.text,
              "uid": uid,
              "role": "Mahasiswa",
              "createdAt": DateTime.now().toIso8601String(),
            },
          );
          await mahasiswaCredential.user!.sendEmailVerification();

          await auth.signOut();

          final userCredentialAdmin = await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );

          Get.back(); //tutup dialog
          Get.back(); //tutup ke home
          Get.snackbar(
            "Berhasil",
            "Berhasil Menambahkan Mahasiswa",
          );
        }
        isLoadingAddMahasiswa.value = false;

        print(mahasiswaCredential);
      } on FirebaseAuthException catch (e) {
        isLoadingAddMahasiswa.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar(
            "Error",
            "Password Terlalu Singkat",
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
            "Error",
            "Pegawai Sudah Terdaftar, Kamu tidak Dapat Menambahkan Mahasiswa Dengan Email Ini",
          );
          print('The account already exists for that email.');
        } else if (e.code == "wrong-password") {
          Get.snackbar(
            "Error",
            "Admin Tidak Dapat Login. Password Salah",
          );
        } else {
          Get.snackbar(
            "Error",
            "Error = ${e.code}",
          );
        }
      } catch (e) {
        isLoadingAddMahasiswa.value = false;
        Get.snackbar(
          "Error",
          "Tidak Dapat Menambahkan Mahasiswa!",
        );
        print(e);
      }
    } else {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        "Password Wajib Diisi Untuk Validasi",
      );
    }
  }

  Future<void> addMahasiswa() async {
    if (nameC.text.isNotEmpty &&
        jurusanC.text.isNotEmpty &&
        npmC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        title: "Validasi Admin",
        content: Column(
          children: [
            Text(
              "Masukkan password untuk validasi admin",
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              autocorrect: false,
              controller: passAdminC,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Masukkan Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              isLoading.value = false;
              Get.back();
            },
            child: Text(
              "Cancel",
            ),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (isLoadingAddMahasiswa.isFalse) {
                  await prosesAddMahasiswa();
                }
                isLoading.value = false;
              },
              child: Text(
                isLoadingAddMahasiswa.isFalse
                    ? "Tambah Mahasiswa"
                    : "Loading...",
              ),
            ),
          ),
        ],
      );
    } else {
      Get.snackbar("Error", "Semua Kolom Harus Diisi");
    }
  }
}
