import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';
import 'package:my_ecommerce_delivery/core/functions/get_decode_polyline.dart';
import 'package:my_ecommerce_delivery/data/models/order_model.dart';

class MapPageController extends GetxController {
  RequestStatus requestStatus = RequestStatus.loading;
  CameraPosition? cameraPosition;
  String? locationErrorMessage = "";
  Set<Polyline> polyLines = {};
  late OrderModel orderModel;
  Set<Marker> markers = {};
  StreamSubscription<Position>? locationListener;
  bool isThereLocationError = true;

  Position? myPosition;
  // distination position (customer)
  late LatLng destPosition;
  GoogleMapController? gmc;

  void updateCameraPosition() {
    if (gmc != null) {
      gmc!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            myPosition!.latitude,
            myPosition!.longitude,
          ),
        ),
      );
    }
  }

  Future<void> getCurrentPosition() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          locationErrorMessage =
              "The location permission must be granted first!";
          isThereLocationError = true;
          return;
        }
      }
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        myPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
      }
    } else {
      locationErrorMessage = "The location service must be enabled first!";
      isThereLocationError = true;
    }
  }

  Future<void> getPolyLines() async {
    await getCurrentPosition();
    if (myPosition != null) {
      polyLines = await getPolylines(
        myPosition!.latitude,
        myPosition!.longitude,
        destPosition.latitude,
        destPosition.longitude,
      );
      markers.add(Marker(
        markerId: const MarkerId("2"),
        position: LatLng(myPosition!.latitude, myPosition!.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ));
      cameraPosition = CameraPosition(
          target: LatLng(myPosition!.latitude, myPosition!.longitude),
          zoom: 16);
      locationStream();
    }
    update();
  }

  void initData() async {
    orderModel = Get.arguments['orderModel'];
    destPosition = LatLng(orderModel.addressLat!, orderModel.addressLong!);
    markers.add(
      Marker(markerId: const MarkerId("1"), position: destPosition),
    );
    await getPolyLines();
    requestStatus = RequestStatus.none;
  }

  void locationStream() {
    locationListener = Geolocator.getPositionStream().listen((newPosition) {
      myPosition = newPosition;
      markers.add(
        Marker(
          markerId: const MarkerId("2"),
          position: LatLng(myPosition!.latitude, myPosition!.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueYellow,
          ),
        ),
      );

      updateCameraPosition();
      updateLocationInFirebase();
    });
  }

  Future<void> updateLocationInFirebase() async {
    FirebaseFirestore.instance
        .collection("delivery")
        .doc(orderModel.ordersId.toString())
        .set(
      {
        "lat": myPosition!.latitude,
        "long": myPosition!.longitude,
      },
    );
  }

  void cancelLocationStream() {
    if (locationListener != null) {
      locationListener!.cancel();
    }
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onClose() {
    cancelLocationStream();
    super.onClose();
  }
}
