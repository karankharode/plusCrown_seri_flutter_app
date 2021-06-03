import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final passwordCtrl = TextEditingController();
  final confrimPasswordCtrl = TextEditingController();
  final int pinLength = 6;

  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  void togglePassword() =>
      showPassword.value = showPassword.value ? false : true;

  void toggleConfrimPassword() =>
      showConfirmPassword.value = showConfirmPassword.value ? false : true;

  @override
  void onClose() {
    super.onClose();
    passwordCtrl.dispose();
    confrimPasswordCtrl.dispose();
  }
}
