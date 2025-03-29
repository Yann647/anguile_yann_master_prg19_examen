import 'package:get/get.dart';

class UserController extends GetxController {
  var status = "En ligne".obs;

  void toggleStatus() {
    status.value = status.value == "En ligne" ? "Hors ligne" : "En ligne";
  }
}