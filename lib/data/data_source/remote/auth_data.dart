import 'package:dartz/dartz.dart';
import 'package:my_ecommerce_delivery/api_links.dart';
import 'package:my_ecommerce_delivery/core/class/crud.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';

class AuthData {
  static Future<dynamic> login(String email, String password) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.login, {'email': email, 'password': password});
    return response.fold((l) => l, (r) => r);
  }
}
