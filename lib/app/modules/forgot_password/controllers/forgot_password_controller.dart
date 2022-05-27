import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);

        Get.snackbar(
          "Berhasil",
          "Berhasil Mengirimkan Email Reset Password. Periksa Email Anda",
        );
        Get.back();
      } catch (e) {
        Get.snackbar(
          "Error",
          "Tidak Dapat Mengirim Email Reset Password",
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
