import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampuskita/app/routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
//    pageIndex.value = i;
    switch (i) {
      case 1:
        Map<String, dynamic> dataRespone = await determinePosition();
        if (dataRespone["error"] != true) {
          Position position = dataRespone["position"];
          // print("${position.latitude} , ${position.latitude} ");

          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );

          String address =
              "${placemarks[0].name} , ${placemarks[0].subLocality}, ${placemarks[0].locality}";

          print(placemarks[0]);
          await updatePosition(position, address);
          //-7.0307609, 107.5454209
          //-7.0405899, 107.5490272,
          // cek distance between 2 position
          double distance = Geolocator.distanceBetween(
              -7.0405899, 107.5490272, position.latitude, position.longitude);

          // absen / presensi
          await presensi(position, address, distance);

          // Get.snackbar("${dataRespone["message"]}", address);
        } else {
          Get.snackbar("Error", dataRespone["message"]);
        }
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> presensi(
      Position position, String address, double distance) async {
    //
    String uid = await auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> colPresence =
        await firestore.collection("mahasiswa").doc(uid).collection("presence");

    QuerySnapshot<Map<String, dynamic>> snapPresence = await colPresence.get();

    // print(snapPresence.docs.length);
    DateTime now = DateTime.now();

    String todayDocId = DateFormat.yMd().format(now).replaceAll("/", "-");

    String status = "Di Luar area";

    if (distance <= 200) {
      status = "Di Dalam area";
    }

    if (snapPresence.docs.length == 0) {
      // belum pernah absen & set absen masuk

      await Get.defaultDialog(
        title: "Valdasi Presence",
        middleText:
            "Apakah kamu yakin  akan mengisi daftar hadir masuk sekarang ?",
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await colPresence.doc(todayDocId).set({
                "date": now.toIso8601String(),
                "masuk": {
                  "date": now.toIso8601String(),
                  "lat": position.latitude,
                  "long": position.longitude,
                  "address": address,
                  "status": status,
                  "distance": distance,
                },
              });
              Get.back();
              Get.snackbar("Berhasil", "Kamu telah mengisi daftar hadir");
            },
            child: Text("Yes"),
          ),
        ],
      );
    } else {
      //sudah pernah absen => cek hari ini udah absen masuk/keluar ?
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await colPresence.doc(todayDocId).get();

      if (todayDoc.exists == true) {
        // abse keluar atau sudah absen masuk & keluar
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();
        if (dataPresenceToday?["keluar"] != null) {
          // sudah absen masuk & keluar
          Get.snackbar("Informasi", "Kamu telah absen. Tunggu besok");
        } else {
          // absen keluar
          await Get.defaultDialog(
            title: "Valdasi Presence",
            middleText: "Apakah kamu yakin akan keluar sekarang ?",
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await colPresence.doc(todayDocId).update({
                    "keluar": {
                      "date": now.toIso8601String(),
                      "lat": position.latitude,
                      "long": position.longitude,
                      "address": address,
                      "status": status,
                      "distance": distance,
                    },
                  });
                  Get.back();
                  Get.snackbar("Berhasil", "Kamu telah kular dari sesi");
                },
                child: Text("Yes"),
              ),
            ],
          );
        }
      } else {
        await Get.defaultDialog(
          title: "Valdasi Presence",
          middleText:
              "Apakah kamu yakin  akan mengisi daftar hadir masuk sekarang ?",
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                print("DIJALANKAN");
                //absen masuk
                await colPresence.doc(todayDocId).set({
                  "date": now.toIso8601String(),
                  "masuk": {
                    "date": now.toIso8601String(),
                    "lat": position.latitude,
                    "long": position.longitude,
                    "address": address,
                    "status": status,
                    "distance": distance,
                  },
                });
                Get.back();
                Get.snackbar("Berhasil", "Kamu telah mengisi daftar hadir");
              },
              child: Text("Yes"),
            ),
          ],
        );
      }
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = await auth.currentUser!.uid;

    await firestore.collection("mahasiswa").doc(uid).update(
      {
        "position": {
          "lat": position.latitude,
          "long": position.longitude,
        },
        "address": address,
      },
    );
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return {
        "message": "Location services are disabled.",
        "error": false,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
          "message": "Location permissions are denied",
          "error": false,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Location permissions are permanently denied, we cannot request permissions.",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return {
      "position": position,
      "message": "Berhasil mendapatkan posisi device",
      "error": false,
    };
  }
}
