import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firesto;

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController npmC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firesto.FirebaseStorage storage = firesto.FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    update();
  }

  Future<void> updateProfile(String uid) async {
    if (npmC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          String upDir = "$uid/profile.$ext";
          await storage.ref(upDir).putFile(file);
          String urlImage = await storage.ref(upDir).getDownloadURL();

          data.addAll({"profile": "$urlImage"});
        }
        await firestore.collection("mahasiswa").doc(uid).update(data);
        image = null;
        Get.snackbar("Berhasil", "Berhasil Update Profile");
      } catch (e) {
        Get.snackbar("Error", "$e");
        print(e);
      } finally {
        isLoading.value = false;
      }
    }
  }

  void deleteprofile(String uid) async {
    try {
      await firestore.collection("mahasiswa").doc(uid).update({
        "profile": FieldValue.delete(),
      });
      Get.back();
      Get.snackbar("Berhasil", "Berhasil menghapus foto profil");
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat delete profile picture");
    } finally {
      update();
    }
  }
}
