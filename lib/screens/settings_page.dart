import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_delivery/controllers/settings_page_controller.dart';
import 'package:my_ecommerce_delivery/core/constants/colors.dart';
import 'package:my_ecommerce_delivery/widgets/settings_page/settings_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsPageController());
    const Color dividerColor = Colors.grey;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            // color: Colors.red,
            height: Get.height * 0.35,
            alignment: Alignment.topCenter,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight * 0.5,
                  color: AppColors.thirdColor10,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                SettingsItem(
                  onTap: () {
                    controller.singOut();
                  },
                  name: "Sign out",
                  icon: const Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
