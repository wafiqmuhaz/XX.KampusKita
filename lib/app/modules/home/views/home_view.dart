// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_if_null_operators

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampuskita/app/routes/app_pages.dart';
import '../../../controllers/page_index_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;

              String defaultImage =
                  "https://ui-avatars.com/api/?name=${user['name']}";

              return ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 75,
                          width: 75,
                          color: Colors.blue[100],
                          child: Image.network(
                            user["profile"] != null
                                ? user["profile"]
                                : defaultImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WELCOME",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${user["name"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user["role"]}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${user["npm"]}",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 200,
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  "Lokasi saat ini :",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  user["address"] != null
                                      ? "${user["address"]}"
                                      : "Belum ada lokasi",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.streamTodayPresence(),
                            builder: (context, snapToday) {
                              if (snapToday.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              Map<String, dynamic>? dataToday =
                                  snapToday.data?.data();

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Check In",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        dataToday?["masuk"] == null
                                            ? "-"
                                            : "${DateFormat.jms().format(DateTime.parse(dataToday!['masuk']['date']))}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: Colors.white,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Check Out",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        dataToday?["keluar"] == null
                                            ? "-"
                                            : "${DateFormat.jms().format(DateTime.parse(dataToday!['keluar']['date']))}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last 5 Days Ago",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.ALL_PRESENSI);
                        },
                        child: Text("see more"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streamLastPresence(),
                      builder: (context, snapPresence) {
                        if (snapPresence.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        print(snapPresence.data?.docs);
                        if (snapPresence.data?.docs.length == 0 ||
                            snapPresence.data == null) {
                          return SizedBox(
                            height: 100,
                            child: Center(
                              child: Text("No history yet"),
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapPresence.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data =
                                snapPresence.data!.docs[index].data();

                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue[100],
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_PRESENSI,
                                        arguments: data);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Check In",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${DateFormat.yMMMEd().format(DateTime.parse(data["date"]))}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            // ${DateFormat.jms().format(DateTime.tryParse(data["masuk"]?["date"]) ??  )}
                                            data["masuk"]?["date"] == null
                                                ? "-"
                                                : "${DateFormat.jms().format(DateTime.parse(data["masuk"]?["date"]))}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Check Out",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(data["keluar"]?["date"] == null
                                            ? "-"
                                            : "${DateFormat.jms().format(DateTime.parse(data["keluar"]?["date"]))}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ],
              );
            } else {
              return Center(
                child: Text("Tidak dapat memuat database user..."),
              );
            }
          },
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
