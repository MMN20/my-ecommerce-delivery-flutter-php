import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce_delivery/controllers/map_page_controller.dart';
import 'package:my_ecommerce_delivery/widgets/request_status_view.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapPageController());
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (controller) {
          return RequestStatusView(
            onErrorTap: () {},
            requestStatus: controller.requestStatus,
            child: controller.cameraPosition != null
                ? GoogleMap(
                    initialCameraPosition: controller.cameraPosition!,
                    polylines: controller.polyLines,
                    markers: controller.markers,
                    mapType: MapType.normal,
                    onMapCreated: (gmc) {
                      controller.gmc = gmc;
                    },
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
