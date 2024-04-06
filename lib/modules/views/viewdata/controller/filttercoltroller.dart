import 'package:get/get.dart';

class FiltterController extends GetxController {
  bool filtter = true;

  void changevalue() {
    filtter = !filtter;
    update();
  }
}
