import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_delivery/controllers/item_details_page_controller.dart';
import 'package:my_ecommerce_delivery/core/constants/colors.dart';

class ItemDetailsImages extends StatelessWidget {
  const ItemDetailsImages({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemDetailsPageController>();
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        controller.changeSelectedImageIndex(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: controller.selectedImageIndex == index
              ? Border.all(
                  color: AppColors.thirdColor10,
                  width: 2,
                )
              : null,
        ),
        width: Get.height * 0.1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: controller.flutterImages[index],
        ),
      ),
    );
  }
}
