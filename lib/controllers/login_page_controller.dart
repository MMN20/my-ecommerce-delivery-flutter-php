import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';
import 'package:my_ecommerce_delivery/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_delivery/data/data_source/remote/auth_data.dart';
import 'package:my_ecommerce_delivery/main.dart';
import 'package:my_ecommerce_delivery/routes.dart';

class LoginPageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool lockPassword = true;
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      requestStatus = RequestStatus.loading;
      update();
      dynamic response =
          await AuthData.login(emailController.text, passwordController.text);
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          Get.snackbar("Success", "Logged in");
          await saveCurrentDeliveryUser(response['data']);
          goToMainScreen();
        } else if (response['status'] == 'failure' &&
            response['message'] == "not active") {
          Get.snackbar("Error", "This account is disabled");
        } else {
          Get.snackbar("Error", "Invalid information");
        }
      }
      update();
    }
  }

  Future<void> saveCurrentDeliveryUser(Map<String, dynamic> map) async {
    sharedPref.setInt("id", map['delivery_id']);
    sharedPref.setString("email", map['delivery_email']);
    sharedPref.setString("username", map['delivery_username']);
  }

  void goToMainScreen() {
    Get.offAllNamed(AppRoutes.mainScreen);
  }

  void changePasswordFieldLock() {
    lockPassword = !lockPassword;
    update();
  }
}
