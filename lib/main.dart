// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kampuskita/app/controllers/page_index_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final pageC = Get.put(PageIndexController(), permanent: true);

  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "KampusKita",
          initialRoute: snap.data != null ? Routes.HOME : Routes.LOGIN,
          getPages: AppPages.routes,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'inter',
          ),
        );
      },
    ),
  );
}
