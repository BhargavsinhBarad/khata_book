import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/database_helper.dart';
import '../../add/controller/datetimecontroller.dart';
import '../../add/controller/typecontroller.dart';
import '../../add/model/datamodel.dart';

class update extends StatelessWidget {
  update({super.key});
  TypeController typeController = Get.put(TypeController());
  DateTimeController datetimecontroller = Get.put(DateTimeController());
  @override
  Widget build(BuildContext context) {
    Datamodel data = ModalRoute.of(context)!.settings.arguments as Datamodel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
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
                  data.name = val;
                },
                decoration: InputDecoration(
                  hintText: data.name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              size10,
              const Text("MO NO."),
              TextFormField(
                onChanged: (val) {
                  data.mono = val;
                },
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: data.mono,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              size10,
              const Text("Remarks."),
              TextFormField(
                onChanged: (val) {
                  data.remark = val;
                },
                decoration: InputDecoration(
                  hintText: data.remark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              size10,
              const Text("Amount."),
              TextFormField(
                onChanged: (val) {
                  data.amount = val;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: data.amount,
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
                            groupValue: data.type,
                            onChanged: (val) {
                              data.type = val!;
                              typeController.savevalue(type: data.type);
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Credit"),
                            value: "Credit",
                            groupValue: data.type,
                            onChanged: (val) {
                              data.type = val!;
                              typeController.savevalue(type: data.type);
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
              Center(
                child: GestureDetector(
                  onTap: () async {
                    Datamodel dm = Datamodel(
                        recivedate:
                            "${datetimecontroller.redate.day}/${datetimecontroller.redate.month}/${datetimecontroller.redate.year}",
                        remark: data.remark,
                        name: data.name,
                        type: data.type,
                        time:
                            "${datetimecontroller.time.hour}:${datetimecontroller.time.minute}",
                        date:
                            "${datetimecontroller.date.day}/${datetimecontroller.date.month}/${datetimecontroller.date.year}",
                        amount: data.amount,
                        mono: data.mono,
                        id: data.id);
                    int res = await DatabaseHelper.db.updatedata(dm: dm);
                    log("$res");
                    Get.back();
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
