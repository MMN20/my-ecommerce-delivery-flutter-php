import 'package:my_ecommerce_delivery/core/class/request_status.dart';

RequestStatus hanldeRequestData(dynamic response) {
  if (response is! RequestStatus) {
    return RequestStatus.success;
  } else {
    return response;
  }
}
