import 'package:get/get.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';
import 'package:my_ecommerce_delivery/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_delivery/data/data_source/remote/orders_data.dart';
import 'package:my_ecommerce_delivery/data/models/order_model.dart';
import 'package:my_ecommerce_delivery/routes.dart';

class AcceptedOrdersPageController extends GetxController {
  List<OrderModel> orders = [];
  RequestStatus requestStatus = RequestStatus.none;

  void rerfreshData() {
    if (requestStatus != RequestStatus.loading) {
      getAcceptedOrders();
    }
  }

  Future<void> getAcceptedOrders() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.getAcceptedOrders();
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

  void goToOrderDetailsPage(OrderModel orderModel) {
    Get.toNamed(AppRoutes.orderDetails, arguments: {"orderModel": orderModel});
  }

  @override
  void onInit() {
    getAcceptedOrders();
    super.onInit();
  }
}
