import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_delivery/controllers/item_details_page_controller.dart';
import 'package:my_ecommerce_delivery/core/constants/colors.dart';

class SpecsList extends StatelessWidget {
  const SpecsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemDetailsPageController>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.specs.map((e) => Row(
                children: [
                  const Icon(
                    Icons.circle,
                    color: AppColors.thirdColor10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("${e.specValue}"),
                ],
              ))
        ],
      ),
    );
  }
}
