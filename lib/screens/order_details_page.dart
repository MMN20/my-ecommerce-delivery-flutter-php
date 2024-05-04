import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_delivery/controllers/order_details_page_controller.dart';
import 'package:my_ecommerce_delivery/core/functions/get_price_and_currency.dart';
import 'package:my_ecommerce_delivery/widgets/general_button.dart';
import 'package:my_ecommerce_delivery/widgets/order_details/bottom_app_bar.dart';
import 'package:my_ecommerce_delivery/widgets/order_details/item_card.dart';
import 'package:my_ecommerce_delivery/widgets/orders/order_data.dart';
import 'package:my_ecommerce_delivery/widgets/request_status_view.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsPageController());
    return Scaffold(
      bottomNavigationBar: controller.orderModel.ordersStatusid! > 4
          ? null
          : controller.orderModel.ordersDeliveryid == null
              ? OrderDetailsBottomAppBar(
                  onTap: () {
                    controller.acceptOrder();
                  },
                  text: "Accept",
                )
              : controller.orderModel.ordersStatusid == 4
                  ? OrderDetailsBottomAppBar(
                      onTap: () {
                        controller.goToMapPage();
                      },
                      text: "Open map",
                    )
                  : OrderDetailsBottomAppBar(
                      onTap: () {
                        controller.startDelivering();
                      },
                      text: "Start delivering",
                    ),
      appBar: AppBar(
        title: const Text("Order details"),
        actions: [
          if (controller.orderModel.ordersStatusid == 4)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GeneralButton(
                onPressed: () {
                  controller.showConfirmDialog();
                },
                child: const Text("Done"),
              ),
            )
        ],
        centerTitle: true,
      ),
      body: GetBuilder(
        init: controller,
        builder: (controller) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderData(
                      name: "Order ID",
                      value: controller.orderModel.ordersId.toString(),
                    ),
                    const Divider(thickness: 0.2),
                    OrderData(
                      name: "Order Status",
                      value: controller.orderModel.ordersDeliveryid != null &&
                              controller.orderModel.ordersStatusid == 3
                          ? "Accepted"
                          : controller.orderModel.orderStatusName!,
                    ),
                    const Divider(thickness: 0.2),
                    Column(
                      children: [
                        OrderData(
                          name: "Order Address",
                          value: controller.orderModel.addressesName!,
                        ),
                        const Divider(thickness: 0.2),
                      ],
                    ),
                    OrderData(
                      name: "Payment Method",
                      value: controller.orderModel.paymentMethodsName!,
                    ),
                    const Divider(thickness: 0.2),
                    if (controller.orderModel.priceAfterCoupon != null)
                      Column(
                        children: [
                          OrderData(
                            name: "Price without coupon",
                            value: getPriceAndCurrency(
                                controller.orderModel.fullPrice!),
                          ),
                          const Divider(thickness: 0.2),
                        ],
                      ),
                    if (controller.orderModel.ordersTypeid == 1)
                      Column(
                        children: [
                          OrderData(
                            name: "Delivering price",
                            value: getPriceAndCurrency(
                                controller.orderModel.ordersDeliveryprice!),
                          ),
                          const Divider(thickness: 0.2),
                        ],
                      ),
                    OrderData(
                      name: "Price",
                      value: getPriceAndCurrency(controller.orderPrice),
                    ),
                    if (controller.orderModel.ordersAddressid != null)
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: GeneralButton(
                                onPressed: () {
                                  controller.openGoogleMaps();
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Map location"),
                                    SizedBox(width: 5),
                                    Icon(Icons.location_on_sharp)
                                  ],
                                )),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    const Text("Items"),
                  ],
                ),
              ),
              RequestStatusView(
                onErrorTap: () {},
                requestStatus: controller.requestStatus,
                child: Column(
                  children: [
                    ...List.generate(
                      controller.items.length,
                      (index) => ItemCard(
                        item: controller.items[index],
                        onCartTap: () {
                          controller
                              .goToItemDetailsPage(controller.items[index]);
                        },
                        amount: controller.items[index].cartAmount!,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
