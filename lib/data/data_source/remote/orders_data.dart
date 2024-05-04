import 'package:dartz/dartz.dart';
import 'package:my_ecommerce_delivery/api_links.dart';
import 'package:my_ecommerce_delivery/core/class/crud.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';
import 'package:my_ecommerce_delivery/data/models/delivery.dart';

class OrdersData {
  static Future<dynamic> getPendingOrders() async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.pendingOrders, {});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getAcceptedOrders() async {
    Either<RequestStatus, Map> response = await CRUD.post(
        APILinks.acceptedOrders,
        {"deliveryid": Delivery.currentDelivery.id.toString()});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getOrderItems(String orderid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.orderItems, {"orderid": orderid});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> acceptOrder(String orderid, String deliveryid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.acceptOrder, {
      "orderid": orderid,
      "deliveryid": deliveryid,
    });
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> finishDelivering(String orderid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.finishDelivering, {
      "orderid": orderid,
    });
    return response.fold((l) => l, (r) => r);
  }

  // make the orderStatus = 4
  static Future<dynamic> startDelivering(String orderid, String userid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.startDelivering, {
      "orderid": orderid,
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }
}
