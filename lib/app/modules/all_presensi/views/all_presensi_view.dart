// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampuskita/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/all_presensi_controller.dart';

class AllPresensiView extends GetView<AllPresensiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Presence'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.offAllNamed(Routes.HOME),
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () => Get.offAllNamed(Routes.ALL_PRESENSI),
            icon: Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Center(
        child: GetBuilder<AllPresensiController>(
          builder: (c) {
            return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: controller.getPresence(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data?.docs.length == 0 || snapshot.data == null) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text("Belum ada history presensi"),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        snapshot.data!.docs[index].data();

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Check In",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${DateFormat.yMMMEd().format(DateTime.parse(data["date"]))}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  // ${DateFormat.jms().format(DateTime.tryParse(data["masuk"]?["date"]) ??  )}
                                  data["masuk"]?["date"] == null
                                      ? "-"
                                      : "${DateFormat.jms().format(DateTime.parse(data["masuk"]?["date"]))}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Check Out",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  data["keluar"]?["date"] == null
                                      ? "-"
                                      : "${DateFormat.jms().format(DateTime.parse(data["keluar"]?["date"]))}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //syncfution datepicker
          Get.dialog(
            Dialog(
              child: Container(
                padding: EdgeInsets.all(20),
                height: 400,
                child: SfDateRangePicker(
                  // view: DateRangePickerView.year,
                  monthViewSettings:
                      DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (obj) {
                    if (obj != null) {
                      //
                      if ((obj as PickerDateRange).endDate != null) {
                        //proses
                        print(obj);
                        controller.pickDate(obj.startDate!, obj.endDate!);
                      }
                    }
                  },
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.format_list_bulleted_rounded),
      ),
    );
  }
}
