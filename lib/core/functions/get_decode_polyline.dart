import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<Set<Polyline>> getPolylines(
    double lat, double long, double destLat, double destLong) async {
  Set<Polyline> polylineSet = {};
  List<LatLng> polylineCo = [];
  PolylinePoints polylinePoints = PolylinePoints();

  var url =
      "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destLat,$destLong&key=AIzaSyAnx2X9Fsr-cH-J1Bb3owOSecfrnOT9IPY";
  var response = await http.post(Uri.parse(url));
  var reponseBody = jsonDecode(response.body);
  var point = reponseBody['routes'][0]['overview_polyline']['points'];
  List<PointLatLng> result = polylinePoints.decodePolyline(point);

  if (result.isNotEmpty) {
    result.forEach((PointLatLng pointLatLng) {
      polylineCo.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
    });
  }
  Polyline polyline = Polyline(
    polylineId: const PolylineId("11"),
    color: Colors.red,
    width: 5,
    points: polylineCo,
  );
  polylineSet.add(polyline);
  return polylineSet;
}
