// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampuskita/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        print(userCredential);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passC.text == 'password') {
              Get.offAllNamed(
                Routes.NEW_PASSWORD,
              );
            } else {
              Get.offAllNamed(
                Routes.HOME,
              );
            }
          } else {
            Get.defaultDialog(
              title: "Email not yet verified",
              middleText: "Are you want to send email verification?",
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
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar(
                        "Success",
                        "We've send email verification to your email",
                      );
                      isLoading.value = false;
                    } catch (e) {
                      isLoading.value = false;
                      Get.snackbar(
                        "Error",
                        "Cant send email verification. Error because : ${e.toString()}",
                      );
                    }
                  },
                  child: Text(
                    "Send Verification",
                  ),
                ),
              ],
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;

        if (e.code == 'user-not-found') {
          print(
            'No user found for that email.',
          );
          Get.snackbar(
            "Error",
            "User Tidak Ditemukan",
          );
        } else if (e.code == 'wrong-password') {
          print(
            'Wrong password provided for that user.',
          );
          Get.snackbar(
            "Error",
            "Masukkan Password Yang Benar",
          );
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          "Tidak Dapat Masuk",
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Email dan Password Wajib Diisi!",
      );
    }
  }
}
