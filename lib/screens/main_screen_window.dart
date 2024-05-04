import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_ecommerce_delivery/controllers/main_screen_window_controller.dart';
import 'package:my_ecommerce_delivery/widgets/main_screen_window/custom_navigation_bar.dart';

class MainScreenWindow extends StatelessWidget {
  const MainScreenWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainScreenWindowController());
    return Scaffold(
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return Stack(
              children: [
                PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    controller.pages['pages']!.length,
                    (index) => controller.pages['pages']![index],
                  ),
                ),
                CustomNavigationBar(
                  children: List.generate(
                    controller.pages['icons']!.length,
                    (index) {
                      bool isCurrentIndex =
                          controller.currentPageIndex == index;
                      return InkWell(
                        onTap: () {
                          controller.changeCurrentPageIndex(index);
                        },
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 100),
                          scale: isCurrentIndex ? 1.2 : 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              controller.pages['icons']![index],
                              color: isCurrentIndex
                                  ? Colors.white
                                  : controller.pages['colors']![index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }),
    );
  }
}
