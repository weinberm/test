import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart' as flutterMap;
import 'package:latlong2/latlong.dart';
import 'package:waste_walking_ba/models/Coordinate.dart';
import 'package:waste_walking_ba/models/ModelProvider.dart';

class MapData {
  List<flutterMap.Marker> markers = [];

  List<flutterMap.Polyline> wasteWalkRoutes = [];
  List<flutterMap.Polyline> otherWasteWalkRoutes = [];

  flutterMap.Polyline currentWasteWalkRoute = flutterMap.Polyline(
    points: [],
    color: Colors.green,
    strokeWidth: 6,
    borderStrokeWidth: 6,
    borderColor: Colors.green,
  );

  flutterMap.Marker currentPosMarker = flutterMap.Marker(
    point: LatLng(0, 0),
    width: 10,
    height: 10,
    builder: (context) => Icon(Icons.my_location),
  );
  late flutterMap.Marker startPosMarker;

  MapController mapController = MapController();

  double currentZoom = 18;

  late Coordinate lastCoordinate;

  MapData() {
    wasteWalkRoutes.add(currentWasteWalkRoute);
  }

  void setStartPosMarkerLocation() {
    startPosMarker = flutterMap.Marker(
      point: LatLng(lastCoordinate.latitude!, lastCoordinate.longtitude!),
      width: 10,
      height: 10,
      builder: (context) => Icon(Icons.start),
    );
    markers.add(startPosMarker);
  }

  void setCurrentPosMarker(Coordinate newCoordinate) {
    Coordinate coordinate = Coordinate(
        latitude: currentPosMarker.point.latitude,
        longtitude: currentPosMarker.point.longitude);
    lastCoordinate = coordinate;

    markers.remove(currentPosMarker);
    currentPosMarker = flutterMap.Marker(
      point: LatLng(newCoordinate.latitude!, newCoordinate.longtitude!),
      width: 10,
      height: 10,
      builder: (context) => Icon(Icons.my_location),
    );
    markers.add(currentPosMarker);
  }

  void addPointToCurrentWasteWalkRoute(Coordinate newCoordinate) {
    wasteWalkRoutes.remove(currentWasteWalkRoute);
    currentWasteWalkRoute.points
        .add(LatLng(newCoordinate.latitude!, newCoordinate.longtitude!));
    wasteWalkRoutes.add(currentWasteWalkRoute);
  }

  void changeMapCenter(Coordinate newCoordinate) {
    mapController.move(
        LatLng(newCoordinate.latitude!, newCoordinate.longtitude!),
        currentZoom);
  }

  void moveMapCenterToCurrentPos() {
    mapController.move(
        LatLng(lastCoordinate.latitude!, lastCoordinate.longtitude!),
        currentZoom);
  }

  void removeOtherWasteWalksFromBoxView() {
    wasteWalkRoutes.clear();
    wasteWalkRoutes.add(currentWasteWalkRoute);
  }

  void addOtherWasteWalksToBoxView() {
    wasteWalkRoutes.addAll(otherWasteWalkRoutes);
  }

  void setOtherWasteWalks(List<WasteWalkRecord> records) {
    records.forEach((record) {
      flutterMap.Polyline wasteWalkRoute = flutterMap.Polyline(
        points: [],
        color: Colors.red,
        strokeWidth: 6,
        borderStrokeWidth: 6,
        borderColor: Colors.red,
      );
      record.coordinates!.forEach((element) {
        wasteWalkRoute.points
            .add(LatLng(element.latitude!, element.longtitude!));
      });
      otherWasteWalkRoutes.add(wasteWalkRoute);
    });
  }
}
