import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_ecommerce_delivery/controllers/login_page_controller.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';
import 'package:my_ecommerce_delivery/core/constants/app_assets.dart';
import 'package:my_ecommerce_delivery/core/functions/validator.dart';
import 'package:my_ecommerce_delivery/widgets/general_button.dart';
import 'package:my_ecommerce_delivery/widgets/my_text_form_field.dart';
import 'package:my_ecommerce_delivery/widgets/request_status_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginPageController());
    return Scaffold(
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              onErrorTap: () {},
              requestStatus: controller.requestStatus,
              child: Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),
                      SizedBox(
                        height: Get.height * 0.20,
                        child: Image.asset(
                          AppAssets.login,
                          height: Get.height * 0.20,
                        ),
                      ),
                      const Spacer(flex: 1),
                      MyTextFormField(
                        controller: controller.emailController,
                        icon: const Icon(Icons.login),
                        labelText: "Email",
                        validator: (s) {
                          return validator(
                            s!,
                            1,
                            s.length,
                            "Please enter a valid email",
                            "",
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      MyTextFormField(
                        obsecureText: controller.lockPassword,
                        controller: controller.passwordController,
                        icon: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            controller.changePasswordFieldLock();
                          },
                          child: Icon(
                            controller.lockPassword
                                ? Icons.lock_outline
                                : Icons.lock_open_rounded,
                          ),
                        ),
                        labelText: "Password",
                        validator: (s) {
                          return validator(
                            s!,
                            1,
                            s.length,
                            "Please enter a valid email",
                            "",
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      GeneralButton(
                        onPressed: () {
                          controller.login();
                        },
                        minSize: const Size.fromHeight(40),
                        child: const Text("Login"),
                      ),
                      const Spacer(flex: 4),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
