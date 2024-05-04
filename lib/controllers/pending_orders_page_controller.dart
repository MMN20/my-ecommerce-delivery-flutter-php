import 'package:get/get.dart';
import 'package:my_ecommerce_delivery/controllers/accepted_orders_page_controller.dart';
import 'package:my_ecommerce_delivery/controllers/main_screen_window_controller.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';
import 'package:my_ecommerce_delivery/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_delivery/data/data_source/remote/orders_data.dart';
import 'package:my_ecommerce_delivery/data/models/delivery.dart';
import 'package:my_ecommerce_delivery/data/models/order_model.dart';
import 'package:my_ecommerce_delivery/routes.dart';

class PendingOrdersPageController extends GetxController {
  List<OrderModel> orders = [];
  RequestStatus requestStatus = RequestStatus.none;

  void refreshData() {
    if (requestStatus != RequestStatus.loading) {
      getPendingOrders();
    }
  }

  Future<void> getPendingOrders() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.getPendingOrders();
    requestStatus = hanldeRequestData(response);

    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        orders = responseData.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  Future<void> acceptOrder(OrderModel orderModel) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.acceptOrder(
        orderModel.ordersId.toString(), Delivery.currentDelivery.id.toString());
    requestStatus = hanldeRequestData(response);

    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        orderModel.ordersDeliveryid = Delivery.currentDelivery.id;
        showOrderAcceptedSnackBar(orderModel);
        orders.remove(orderModel);
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

  void showOrderAcceptedSnackBar(OrderModel orderModel) {
    Get.snackbar(
      "Success",
      "The order has been accepted successfully",
      onTap: (s) {
        final mainScreencontroller = Get.find<MainScreenWindowController>();
        final acceptedOrdersController =
            Get.find<AcceptedOrdersPageController>();
        // go to OrderDetails page and then update the AcceptedOrders page
        Get.toNamed(AppRoutes.orderDetails,
            arguments: {'orderModel': orderModel});
        mainScreencontroller.changeCurrentPageIndex(0);
        acceptedOrdersController.getAcceptedOrders();
      },
    );
  }

  void goToOrderDetailsPage(OrderModel orderModel) {
    Get.toNamed(AppRoutes.orderDetails, arguments: {"orderModel": orderModel});
  }

  @override
  void onInit() {
    getPendingOrders();
    super.onInit();
  }
}
