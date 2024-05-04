import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_delivery/screens/accepted_orders_page.dart';
import 'package:my_ecommerce_delivery/screens/pending_orders_page.dart';
import 'package:my_ecommerce_delivery/screens/settings_page.dart';
import 'package:my_ecommerce_delivery/widgets/keep_child_alive.dart';

class MainScreenWindowController extends GetxController {
  // for every page there is corresponding icon and color
  Map<String, List<dynamic>> pages = {
    "pages": <Widget>[
      const KeepChildAlive(child: AcceptedOrdersPage()),
      const KeepChildAlive(child: PendingOrdersPage()),
      const KeepChildAlive(child: SettingsPage()),
    ],
    "icons": <IconData>[
      Icons.circle,
      Icons.circle,
      Icons.settings,
    ],
    "colors": [Colors.green, Colors.orange, Colors.black]
  };
  int currentPageIndex = 0;
  PageController pageController = PageController();

  void changeCurrentPageIndex(int newIndex) {
    if (newIndex != currentPageIndex) {
      pageController.jumpToPage(
        newIndex,
      );
      currentPageIndex = newIndex;
      update();
    }
  }

  StreamSubscription? prepareingOrdersTopic;

  void listenToPreparingOrdersTopic() {
    FirebaseMessaging.instance.subscribeToTopic("preparingOrders");

    prepareingOrdersTopic = FirebaseMessaging.onMessage.listen((message) {
      Get.snackbar(
        "New order",
        "There is a new order that is ready to deliver",
      );
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    if (prepareingOrdersTopic != null) {
      prepareingOrdersTopic!.cancel();
    }
    super.onClose();
  }

  @override
  void onInit() {
    listenToPreparingOrdersTopic();
    super.onInit();
  }
}
