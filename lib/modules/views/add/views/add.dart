import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khata_book/modules/utils/helper/database_helper.dart';
import 'package:khata_book/modules/views/add/controller/typecontroller.dart';
import 'package:khata_book/modules/views/add/model/datamodel.dart';
import 'package:khata_book/modules/views/home/views/home.dart';

import '../controller/datetimecontroller.dart';

class add extends StatelessWidget {
  add({super.key});
  TypeController typeController = Get.put(TypeController());
  DateTimeController datetimecontroller = Get.put(DateTimeController());
  String? name;

  String? mono;

  String? remarks;

  String? amount;

  String? amounttype;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AddData"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Name"),
              TextFormField(
                onChanged: (val) {
                  name = val;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              size10,
              const Text("MO NO."),
              TextFormField(
                onChanged: (val) {
                  mono = val;
                },
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              size10,
              const Text("Remarks."),
              TextFormField(
                onChanged: (val) {
                  remarks = val;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              size10,
              const Text("Amount."),
              TextFormField(
                onChanged: (val) {
                  amount = val;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              size10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickdate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      datetimecontroller.datepicker(dateTime: pickdate!);
                      log("${pickdate.day}");
                    },
                    child: Container(
                      height: 50,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(child: Text("Date")),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? timepick = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      datetimecontroller.timepicker(timeOfDay: timepick!);
                      log("${timepick.hour}:${timepick.minute}");
                    },
                    child: Container(
                      height: 50,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(child: Text("Time")),
                    ),
                  ),
                ],
              ),
              size10,
              GetBuilder<TypeController>(
                builder: (val) => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: "Debit",
                            title: const Text("Debit"),
                            groupValue: amounttype,
                            onChanged: (val) {
                              amounttype = val;
                              typeController.savevalue(type: amounttype!);

                              log("$amounttype");
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Credit"),
                            value: "Credit",
                            groupValue: amounttype,
                            onChanged: (val) {
                              amounttype = val;
                              typeController.savevalue(type: amounttype!);
                              log("$amounttype");
                            },
                          ),
                        ),
                      ],
                    ),
                    (typeController.amounttype == "Debit")
                        ? GestureDetector(
                            onTap: () async {
                              DateTime? pickdate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              datetimecontroller.redatepicker(
                                  dateTime: pickdate!);
                              log("${pickdate.day}");
                            },
                            child: Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text("Date")),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              size10,
              size10,
              Center(
                child: GestureDetector(
                  onTap: () async {
                    Datamodel dm = Datamodel(
                        recivedate:
                            "${datetimecontroller.redate.day}/${datetimecontroller.redate.month}/${datetimecontroller.redate.year}",
                        remark: remarks!,
                        name: name!,
                        type: typeController.amounttype!,
                        time:
                            "${datetimecontroller.time.hour}:${datetimecontroller.time.minute}",
                        date:
                            "${datetimecontroller.date.day}/${datetimecontroller.date.month}/${datetimecontroller.date.year}",
                        amount: amount!,
                        mono: mono!);
                    int res = await DatabaseHelper.db.insertdata(dm: dm);
                    log("$res");
                    Get.to(home());
                  },
                  child: Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox size10 = const SizedBox(
    height: 10,
  );
}
