import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata_book/modules/views/reminder/controller/datecontroller.dart';
import 'package:khata_book/modules/views/update/views/update.dart';

import '../../../utils/helper/database_helper.dart';
import '../../add/model/datamodel.dart';

class viewsdata extends StatelessWidget {
  viewsdata({super.key});
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
              icon: Icon(Icons.calendar_month))
        ],
      ),
      body: FutureBuilder(
          future: DatabaseHelper.db.fetchdata(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              List<Datamodel>? data = snapshot.data;
              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, i) {
                    return GetBuilder<DateController>(
                      builder: (val) =>
                          ("${dateController.viewdate.day}/${dateController.viewdate.month}/${dateController.viewdate.year}" ==
                                  data![i].date)
                              ? GestureDetector(
                                  onTap: () {
                                    Datamodel d1 = Datamodel(
                                        recivedate: data[i].recivedate,
                                        remark: data[i].remark,
                                        name: data[i].name,
                                        type: data[i].type,
                                        time: data[i].time,
                                        date: data[i].date,
                                        amount: data[i].amount,
                                        mono: data[i].mono,
                                        id: data[i].id);
                                    Get.to(update(), arguments: d1);
                                  },
                                  child: Card(
                                    color: (data[i].type == "Debit")
                                        ? Colors.red.withOpacity(0.4)
                                        : Colors.green.withOpacity(0.4),
                                    child: ListTile(
                                      title: Text("${data![i].name}"),
                                      trailing: Text("${data[i].amount}"),
                                      subtitle: Text("${data[i].remark}"),
                                    ),
                                  ),
                                )
                              : Card(),
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
