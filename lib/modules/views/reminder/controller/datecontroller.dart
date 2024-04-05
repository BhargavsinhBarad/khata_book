import 'package:get/get.dart';

class DateController extends GetxController {
  DateTime date = DateTime.now();
  DateTime viewdate = DateTime.now();

  void reminderdatepic({required DateTime dateTime}) {
    date = dateTime;
    update();
  }

  void viewdatepic({required DateTime dateTime}) {
    viewdate = dateTime;
    update();
  }
}
