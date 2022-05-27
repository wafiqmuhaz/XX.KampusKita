// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unnecessary_string_interpolations, prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kampuskita/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';
import '../../../controllers/page_index_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snap.hasData) {
                Map<String, dynamic> user = snap.data!.data()!;
                String defaultImage =
                    "https://ui-avatars.com/api/?name=${user['name']}";
                return ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Image.network(
                              user["profile"] != null
                                  ? user["profile"] != ""
                                      ? user["profile"]
                                      : defaultImage
                                  : defaultImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${user['name'].toString().toUpperCase()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${user['email']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.blue[100],
                      child: ListTile(
                        onTap: () => Get.toNamed(
                          Routes.UPDATE_PROFILE,
                          arguments: user,
                        ),
                        leading: Icon(Icons.person),
                        title: Text("Update Profile"),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.blue[100],
                      child: ListTile(
                        onTap: () => Get.toNamed(
                          Routes.UPDATE_PASSWORD,
                        ),
                        leading: Icon(Icons.vpn_key),
                        title: Text("Ubah Password"),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                        ),
                      ),
                    ),
                    if (user["role"] == "admin")
                      Card(
                        color: Colors.blue[100],
                        child: ListTile(
                          onTap: () => Get.toNamed(
                            Routes.ADD_MAHASISWA,
                          ),
                          leading: Icon(Icons.person_add),
                          title: Text("Tambah Mahasiswa"),
                          trailing: Icon(
                            Icons.navigate_next_outlined,
                          ),
                        ),
                      ),
                    Card(
                      color: Colors.blue[100],
                      child: ListTile(
                        onTap: () => controller.logout(),
                        leading: Icon(Icons.logout_outlined),
                        title: Text("Sign Out"),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text("Tidak Dapat Memuat Data User..."),
                );
              }
            },
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.fingerprint_outlined, title: 'Add'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: pageC.pageIndex.value, //optional, default as 0
          onTap: (int i) => pageC.changePage(i),
        ),
      ),
    );
  }
}
