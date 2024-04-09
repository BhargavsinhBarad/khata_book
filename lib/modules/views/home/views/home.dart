import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:khata_book/modules/utils/helper/database_helper.dart';
import 'package:khata_book/modules/views/add/model/datamodel.dart';
import 'package:khata_book/modules/views/add/views/add.dart';
import 'package:khata_book/modules/views/home/controller/totalcontroller.dart';
import 'package:khata_book/modules/views/reminder/views/reminder.dart';
import 'package:khata_book/modules/views/viewdata/views/view.dart';

class home extends StatelessWidget {
  home({super.key});
  TotalController totalController = Get.put(TotalController());
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
            },
            icon: const Icon(Icons.sunny),
          ),
          IconButton(
              onPressed: () {
                Get.to(reminder());
              },
              icon: const Icon(Icons.account_balance_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => add());
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Credit",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GetBuilder<TotalController>(
                        builder: (ctx) => Text(
                          "${totalController.sumcredit[0]}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: 150,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Debit",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GetBuilder<TotalController>(
                        builder: (ctx) => Text(
                          "${totalController.sumcredit[1]}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(viewsdata());
                    },
                    child: const Text(
                      "SeeAll",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Card(),
            Expanded(
              child: GetBuilder<TotalController>(
                builder: (ctx) => FutureBuilder(
                  future: DatabaseHelper.db.fetchdata(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      totalController.data = snapshot.data;
                      return ListView.builder(
                        // reverse: true,
                        itemCount: totalController.data?.length,
                        itemBuilder: (context, i) {
                          return ("${date.day}/${date.month}/${date.year}" ==
                                  totalController.data?[i].date)
                              ? Card(
                                  color:
                                      (totalController.data![i].type == "Debit")
                                          ? Colors.red.withOpacity(0.4)
                                          : Colors.green.withOpacity(0.4),
                                  child: ListTile(
                                    title: Text(totalController.data![i].name),
                                    trailing:
                                        Text(totalController.data![i].amount),
                                    subtitle:
                                        Text(totalController.data![i].remark),
                                  ),
                                )
                              : const Card();
                        },
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
