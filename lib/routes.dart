import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_ecommerce_delivery/core/middleware/my_middleware.dart';
import 'package:my_ecommerce_delivery/screens/item_details_page.dart';
import 'package:my_ecommerce_delivery/screens/login_page.dart';
import 'package:my_ecommerce_delivery/screens/main_screen_window.dart';
import 'package:my_ecommerce_delivery/screens/map_page.dart';
import 'package:my_ecommerce_delivery/screens/order_details_page.dart';

class AppRoutes {
  static const String mainScreen = "/mainScreen";
  static const String loginPage = "/";
  static const String orderDetails = "/orderDetails";
  static const String itemDetails = "/itemDetails";
  static const String mapPage = "/mapPage";
}

List<GetPage> pages = [
  GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginPage(),
      middlewares: [MyMiddleWare()]),
  GetPage(name: AppRoutes.mainScreen, page: () => const MainScreenWindow()),
  GetPage(name: AppRoutes.orderDetails, page: () => const OrderDetailsPage()),
  GetPage(name: AppRoutes.itemDetails, page: () => const ItemDetailsPage()),
  GetPage(name: AppRoutes.mapPage, page: () => const MapPage()),
];
