import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/helper/database_helper.dart';
import '../../add/model/datamodel.dart';
import '../controller/datecontroller.dart';

class reminder extends StatelessWidget {
  reminder({super.key});
  DateController dateController = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                DateTime? pickdate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                dateController.reminderdatepic(dateTime: pickdate!);
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
                          ("${dateController.date.day}/${dateController.date.month}/${dateController.date.year}" ==
                                      data![i].recivedate &&
                                  data![i].type == "Debit")
                              ? Card(
                                  color: (data![i].type == "Debit")
                                      ? Colors.red.withOpacity(0.4)
                                      : Colors.green.withOpacity(0.4),
                                  child: ListTile(
                                    title: Text("${data![i].name}"),
                                    trailing: Text("${data[i].amount}"),
                                    subtitle: Text("${data[i].recivedate}"),
                                    leading: IconButton(
                                      onPressed: () async {
                                        launchUrl(
                                          Uri(
                                              scheme: 'tel',
                                              path: data[i].mono),
                                        );
                                      },
                                      icon: Icon(Icons.call),
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
