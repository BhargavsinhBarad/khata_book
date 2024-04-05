import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeController extends GetxController {
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
  DateTime redate = DateTime.now();

  void timepicker({required TimeOfDay timeOfDay}) {
    time = timeOfDay;
    update();
  }

  void datepicker({required DateTime dateTime}) {
    date = dateTime;
    update();
  }

  void redatepicker({required DateTime dateTime}) {
    redate = dateTime;
    update();
  }
}
