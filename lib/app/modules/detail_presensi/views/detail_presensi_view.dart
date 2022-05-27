// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  final Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Presence'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "${DateFormat.yMMMEd().format(DateTime.parse(data["date"]))}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Check In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${DateFormat.jms().format(DateTime.parse(data["masuk"]!["date"]))}",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Position",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${data["masuk"]!["lat"]} , ${data["masuk"]?["long"]}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${data["masuk"]!["status"]}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${data["masuk"]!["address"]}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Distance",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      "${data["masuk"]!["distance"].toString().split(".").first} meter"),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "${DateFormat.yMMMEd().format(DateTime.parse(data["date"]))}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Keluar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data["keluar"]?["date"] == null
                        ? "-"
                        : "${DateFormat.jms().format(DateTime.parse(data["keluar"]!["date"]))}",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Position",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data["keluar"]?["lat"] == null &&
                            data["keluar"]?["long"] == null
                        ? "-"
                        : "${data["keluar"]!["lat"]} , ${data["keluar"]?["long"]}",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data["keluar"]?["status"] == null
                        ? "-"
                        : "${data["keluar"]!["status"]}",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data["keluar"]?["address"] == null
                        ? "-"
                        : "${data["keluar"]!["address"]}",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Distance",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data["keluar"]?["distance"] == null
                        ? "-"
                        : "${data["keluar"]!["distance"].toString().split(".").first} meter",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
