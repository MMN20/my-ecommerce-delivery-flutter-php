import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce_delivery/controllers/accepted_orders_page_controller.dart';
import 'package:my_ecommerce_delivery/controllers/main_screen_window_controller.dart';
import 'package:my_ecommerce_delivery/controllers/pending_orders_page_controller.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';
import 'package:my_ecommerce_delivery/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_delivery/data/data_source/remote/orders_data.dart';
import 'package:my_ecommerce_delivery/data/models/delivery.dart';
import 'package:my_ecommerce_delivery/data/models/items_model.dart';
import 'package:my_ecommerce_delivery/data/models/order_model.dart';
import 'package:my_ecommerce_delivery/routes.dart';
import 'package:my_ecommerce_delivery/widgets/general_button.dart';

class OrderDetailsPageController extends GetxController {
  late OrderModel orderModel;
  List<ItemModel> items = [];
  late double orderPrice;

  // I used this method because the deliverer shouldn't care if the price was
  // with or without the coupon so just the final result
  void setOrderPrice() {
    if (orderModel.isUsedCoupon == 1) {
      orderPrice = orderModel.priceAfterCoupon!;
    } else {
      orderPrice = orderModel.fullPrice!;
    }
  }

  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllItems() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response =
        await OrdersData.getOrderItems(orderModel.ordersId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        items = List.generate(responseData.length,
            (index) => ItemModel.fromJson(responseData[index]));
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  Future<void> acceptOrder() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.acceptOrder(
        orderModel.ordersId.toString(), Delivery.currentDelivery.id.toString());
    requestStatus = hanldeRequestData(response);

    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        orderModel.ordersDeliveryid = Delivery.currentDelivery.id;
        removeCurrentOrderFromPendingOrders();
        Get.back();
        showOrderAcceptedSnackBar();
      } else if (response['status'] == 'failure' &&
          response['message'] == '5') {
        Get.snackbar(
            "Error", "The delivery can't have more than 5 accepted orders!");
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  void removeCurrentOrderFromPendingOrders() {
    final controller = Get.find<PendingOrdersPageController>();
    controller.orders.remove(orderModel);
    controller.update();
  }

  void refreshAcceptedOrdersPage() {
    final controller = Get.find<AcceptedOrdersPageController>();
    controller.getAcceptedOrders();
  }

  void showOrderAcceptedSnackBar() {
    Get.snackbar(
      "Success",
      "The order has been accepted successfully",
      onTap: (s) {
        final mainScreencontroller = Get.find<MainScreenWindowController>();
        final acceptedOrdersController =
            Get.find<AcceptedOrdersPageController>();
        // go to OrderDetails page and then update the AcceptedOrders page
        Get.toNamed(AppRoutes.orderDetails,
            arguments: {"orderModel": orderModel});
        mainScreencontroller.changeCurrentPageIndex(0);
        acceptedOrdersController.getAcceptedOrders();
      },
    );
  }

  Future<void> startDelivering() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.startDelivering(
        orderModel.ordersId.toString(), orderModel.userId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        refreshAcceptedOrdersPage();
        Get.back();
        Get.snackbar("Success", "The order is marked as (On the way)");
      } else {
        Get.snackbar("Error", "The was a problem, please try again");
      }
    }
  }

  Future<void> openGoogleMaps() async {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(orderModel.addressLat!, orderModel.addressLong!),
      zoom: 14,
    );
    Set<Marker> makers = {
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(orderModel.addressLat!, orderModel.addressLong!),
      ),
    };

    Get.dialog(
      Material(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: cameraPosition,
              markers: makers,
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> finishDelivering() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response =
        await OrdersData.finishDelivering(orderModel.ordersId.toString());
    requestStatus = hanldeRequestData(response);

    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        orderModel.ordersDeliveryid = Delivery.currentDelivery.id;
        refreshAcceptedOrdersPage();
        Get.back();
        Get.snackbar(
            "Success", "The orders was marked as delivered successfully!");
      }
    }
    update();
  }

  void showConfirmDialog() {
    Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Did you deliver the order?",
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GeneralButton(
                      onPressed: () {
                        Get.back();
                        finishDelivering();
                      },
                      child: const Text("YES")),
                  const SizedBox(width: 10),
                  GeneralButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("NO"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void goToMapPage() {
    Get.toNamed(AppRoutes.mapPage, arguments: {'orderModel': orderModel});
  }

  void initData() {
    orderModel = Get.arguments['orderModel'];
    setOrderPrice();
  }

  void goToItemDetailsPage(ItemModel itemModel) {
    Get.toNamed(AppRoutes.itemDetails, arguments: {"item": itemModel});
  }

  @override
  void onInit() {
    initData();
    getAllItems();
    super.onInit();
  }
}
