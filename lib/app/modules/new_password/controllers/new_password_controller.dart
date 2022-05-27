import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampuskita/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(
            newPassC.text,
          );

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPassC.text,
          );

          Get.offAllNamed(
            Routes.HOME,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print(
              'No user found for that email.',
            );
            Get.snackbar(
              "Error",
              "Password Minimal 6 Karakter",
            );
          }
        } catch (e) {
          Get.snackbar(
            "Error",
            "Tidak Dapat Membuat Password Baru. Hubungi Customer Service",
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Password Baru Harus Berbeda Dari Sebelumnya",
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Password Baru Wajib Diisi",
      );
    }
  }
}
