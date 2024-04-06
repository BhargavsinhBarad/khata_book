import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khata_book/modules/views/reminder/controller/datecontroller.dart';
import 'package:khata_book/modules/views/update/views/update.dart';
import 'package:khata_book/modules/views/viewdata/controller/filttercoltroller.dart';

import '../../../utils/helper/database_helper.dart';
import '../../add/model/datamodel.dart';

class viewsdata extends StatefulWidget {
  viewsdata({super.key});

  @override
  State<viewsdata> createState() => _viewsdataState();
}

class _viewsdataState extends State<viewsdata> {
  FiltterController filtterController = Get.put(FiltterController());

  DateController dateController = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ViewData"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                DateTime? pickdate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                dateController.viewdatepic(dateTime: pickdate!);
              },
              icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<FiltterController>(
          builder: (val) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (filtterController.filtter == false) {
                        filtterController.changevalue();
                      }
                      log("${filtterController.filtter}");
                    },
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (filtterController.filtter == true)
                              ? Colors.green.withOpacity(0.8)
                              : Colors.green.withOpacity(0.4)),
                      child: const Center(
                        child: Text(
                          "Credit",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (filtterController.filtter == true) {
                        filtterController.changevalue();
                      }
                      log("${filtterController.filtter}");
                    },
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (filtterController.filtter == false)
                            ? Colors.red.withOpacity(0.8)
                            : Colors.red.withOpacity(0.4),
                      ),
                      child: const Center(
                        child: Text(
                          "Debit",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                    future: DatabaseHelper.db.fetchdata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        List<Datamodel>? data = snapshot.data;
                        return (filtterController.filtter == true)
                            ? ListView.builder(
                                itemCount: data?.length,
                                itemBuilder: (context, i) {
                                  return GetBuilder<DateController>(
                                    builder: (val) =>
                                        ("${dateController.viewdate.day}/${dateController.viewdate.month}/${dateController.viewdate.year}" ==
                                                    data![i].date &&
                                                data[i].type == "Credit")
                                            ? GestureDetector(
                                                onTap: () {
                                                  Datamodel d1 = Datamodel(
                                                      recivedate:
                                                          data[i].recivedate,
                                                      remark: data[i].remark,
                                                      name: data[i].name,
                                                      type: data[i].type,
                                                      time: data[i].time,
                                                      date: data[i].date,
                                                      amount: data[i].amount,
                                                      mono: data[i].mono,
                                                      id: data[i].id);
                                                  Get.to(update(),
                                                      arguments: d1);
                                                },
                                                child: Card(
                                                  color:
                                                      (data[i].type == "Debit")
                                                          ? Colors.red
                                                              .withOpacity(0.4)
                                                          : Colors.green
                                                              .withOpacity(0.4),
                                                  child: ListTile(
                                                    title: Text(data![i].name),
                                                    trailing:
                                                        Text(data[i].amount),
                                                    leading: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          DatabaseHelper.db
                                                              .delete(
                                                                  deleteid: data[
                                                                              i]
                                                                          .id
                                                                      as int);
                                                        });

                                                        log("${data[i].id}");
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete),
                                                    ),
                                                    subtitle:
                                                        Text(data[i].remark),
                                                  ),
                                                ),
                                              )
                                            : const Card(),
                                  );
                                })
                            : ListView.builder(
                                itemCount: data?.length,
                                itemBuilder: (context, i) {
                                  return GetBuilder<DateController>(
                                    builder: (val) =>
                                        ("${dateController.viewdate.day}/${dateController.viewdate.month}/${dateController.viewdate.year}" ==
                                                    data![i].date &&
                                                data[i].type == "Debit")
                                            ? GestureDetector(
                                                onTap: () {
                                                  Datamodel d1 = Datamodel(
                                                      recivedate:
                                                          data[i].recivedate,
                                                      remark: data[i].remark,
                                                      name: data[i].name,
                                                      type: data[i].type,
                                                      time: data[i].time,
                                                      date: data[i].date,
                                                      amount: data[i].amount,
                                                      mono: data[i].mono,
                                                      id: data[i].id);
                                                  Get.to(update(),
                                                      arguments: d1);
                                                },
                                                child: Card(
                                                  color:
                                                      (data[i].type == "Debit")
                                                          ? Colors.red
                                                              .withOpacity(0.4)
                                                          : Colors.green
                                                              .withOpacity(0.4),
                                                  child: ListTile(
                                                    title: Text(data[i].name),
                                                    trailing:
                                                        Text(data[i].amount),
                                                    leading: IconButton(
                                                      onPressed: () {
                                                        DatabaseHelper.db
                                                            .delete(
                                                                deleteid:
                                                                    data[i].id
                                                                        as int);
                                                        log("${data[i].id}");
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete),
                                                    ),
                                                    subtitle:
                                                        Text(data[i].remark),
                                                  ),
                                                ),
                                              )
                                            : const Card(),
                                  );
                                });
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
