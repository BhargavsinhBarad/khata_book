import 'dart:developer';

import 'package:get/get.dart';

import '../../add/model/datamodel.dart';

class TotalController extends GetxController {
  List<Datamodel>? data = [];
  int debit = 0;
  get sumcredit {
    int credit = 0;

    for (int i = 0; i < data!.length; i++) {
      (data![i].type == "Credit")
          ? credit += int.parse(data![i].amount)
          : debit += int.parse(data![i].amount);
    }

    log("===================================");
    log("====${credit}");
    log("===================================");
    return credit;
  }
}
