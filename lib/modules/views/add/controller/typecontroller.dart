import 'package:flutter/semantics.dart';
import 'package:get/get.dart';

class TypeController extends GetxController {
  String? amounttype;

  void savevalue({required String type}) {
    amounttype = type;
    update();
  }
}
