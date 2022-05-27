// ignore_for_file: empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currC = TextEditingController();
  TextEditingController newC = TextEditingController();
  TextEditingController confirmC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePass() async {
    if (currC.text.isNotEmpty &&
        newC.text.isNotEmpty &&
        confirmC.text.isNotEmpty) {
      if (newC.text == confirmC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currC.text);

          // if (userCredential != null) {
          // }
          await auth.currentUser!.updatePassword(newC.text);

          // await auth.signInWithEmailAndPassword(
          //     email: emailUser, password: currC.text);

          Get.back();

          Get.snackbar(
            "Berhasil",
            "Berhasil Update Password",
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar(
              "Error",
              "Password Yang Dimasukkan Salah. Tidak Dapat Update Password",
            );
          } else {
            Get.snackbar(
              "Error",
              "Error = ${e.code.toLowerCase()}",
            );
          }
          Get.snackbar(
            "Error",
            "Tidak Dapat Update Password",
          );
        } catch (e) {
          Get.snackbar(
            "Error",
            "Tidak Dapat Update Password",
          );
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar(
          "Error",
          "Password Baru Harus Sama",
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Semua Kolom Wajib Diisi",
      );
    }
  }
}
