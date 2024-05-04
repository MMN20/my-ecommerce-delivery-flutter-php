import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_delivery/controllers/accepted_orders_page_controller.dart';
import 'package:my_ecommerce_delivery/core/constants/colors.dart';
import 'package:my_ecommerce_delivery/data/models/order_model.dart';
import 'package:my_ecommerce_delivery/widgets/orders/order_card.dart';
import 'package:my_ecommerce_delivery/widgets/request_status_view.dart';

class AcceptedOrdersPage extends StatelessWidget {
  const AcceptedOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AcceptedOrdersPageController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Accepted Orders"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.rerfreshData();
              },
              icon: const Icon(Icons.replay),
            ),
          ],
        ),
        body: GetBuilder(
            init: controller,
            builder: (context) {
              return RequestStatusView(
                onErrorTap: () {},
                requestStatus: controller.requestStatus,
                child: ListView.builder(
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    double orderPrice;
                    OrderModel order = controller.orders[index];
                    if (order.isUsedCoupon == 1) {
                      orderPrice = order.priceAfterCoupon!;
                    } else {
                      orderPrice = order.fullPrice!;
                    }
                    return OrderCard(
                      values: [
                        OrderValue(
                          name: "Order ID",
                          value: order.ordersId.toString(),
                        ),
                        OrderValue(
                          name: "Status",
                          value: order.ordersDeliveryid != null &&
                                  order.ordersStatusid == 3
                              ? "Accepted"
                              : order.orderStatusName!,
                        ),
                        OrderValue(
                            name: "Address", value: order.addressesName!),
                        OrderValue(
                            name: "Price",
                            value: orderPrice.toStringAsFixed(2)),
                        OrderValue(
                          name: "Delivering Price",
                          value: order.ordersDeliveryprice.toString(),
                        ),
                        OrderValue(
                          name: "Payment method",
                          value: order.paymentMethodsName!,
                        ),
                      ],
                      color: index.isEven
                          ? AppColors.secondColor30
                          : AppColors.mainColor60,
                      actionName: "Start delivering",
                      orderModel: order,
                      onDetailsTap: () {
                        controller.goToOrderDetailsPage(order);
                      },
                      onAction: () {
                        // controller.acceptOrder(order);
                      },
                    );
                  },
                ),
              );
            }));
  }
}
