import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_delivery/controllers/item_details_page_controller.dart';
import 'package:my_ecommerce_delivery/core/constants/colors.dart';
import 'package:my_ecommerce_delivery/widgets/items/item_details_images.dart';
import 'package:my_ecommerce_delivery/widgets/items/specs_list.dart';
import 'package:my_ecommerce_delivery/widgets/request_status_view.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemDetailsPageController());
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          splashColor: AppColors.thirdColor10.withOpacity(0.2),
          radius: 20,
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // controller.goToEditItemDetailsPage();
          },
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Edit", style: TextStyle(color: AppColors.thirdColor10)),
                SizedBox(width: 5),
                Icon(Icons.edit),
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.mainColor60,
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              onErrorTap: () {},
              requestStatus: controller.requestStatus,
              child: ListView(
                children: [
                  //! Main image
                  SizedBox(
                    height: Get.height * 0.50,
                    child: controller.flutterImages.isNotEmpty
                        ? controller
                            .flutterImages[controller.selectedImageIndex]
                        : null,
                  ),
                  const SizedBox(height: 10),
                  //! All images
                  SizedBox(
                    height: Get.height * 0.1,
                    child: ListView.builder(
                      itemCount: controller.flutterImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ItemDetailsImages(index: index);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  //! Descroption and specs
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        const Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(controller.currentItem.itemsDesc!),
                        const SizedBox(height: 10),
                        const Divider(),
                        const Text(
                          "Specifications",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const SpecsList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            );
          }),
    );
  }
}
