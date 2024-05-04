import 'package:my_ecommerce_delivery/main.dart';

class Delivery {
  int id;
  String email;
  String username;

  Delivery({required this.email, required this.id, required this.username});

  static Delivery? _currentDelivery;

  static Delivery get currentDelivery {
    if (_currentDelivery == null) {
      _currentDelivery = Delivery(
          email: sharedPref.getString("email")!,
          id: sharedPref.getInt("id")!,
          username: sharedPref.getString("username")!);
    }
    return _currentDelivery!;
  }
}
