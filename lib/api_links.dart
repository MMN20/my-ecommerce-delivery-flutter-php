class APILinks {
  // add the link of your server here
  static const String _server = "https://example.com/myecommerce/delivery";
  static const String itemImages =
      "https://mustafa2000.com/myecommerce/upload/items";

  // auth
  static const String login = "$_server/auth/login.php";
  static const String pendingOrders = "$_server/orders/pending_orders.php";
  static const String orderItems = "$_server/orders/order_items.php";
  static const String itemDetails = "$_server/orders/item_details.php";
  static const String acceptOrder = "$_server/orders/accept_order.php";
  static const String acceptedOrders = "$_server/orders/accepted_orders.php";
  static const String startDelivering = "$_server/orders/start_delivering.php";
  static const String finishDelivering =
      "$_server/orders/finish_delivering.php";
}
