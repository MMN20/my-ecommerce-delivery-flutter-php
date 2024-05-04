import 'package:dartz/dartz.dart';
import 'package:my_ecommerce_delivery/api_links.dart';
import 'package:my_ecommerce_delivery/core/class/crud.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';

class ItemsData {
  static Future<dynamic> getItemDetails(String itemid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.itemDetails, {'itemid': itemid});
    return response.fold((l) => l, (r) => r);
  }
}
