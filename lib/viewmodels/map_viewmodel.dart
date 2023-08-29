import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import '../models/Coordinate.dart';

import 'package:waste_walking_ba/services/backgroundlocation_service.dart';

import 'dart:async';

class MapViewModel extends ChangeNotifier {
  final BackgroundLocationService backgroundLocationService =
      BackgroundLocationService();

  MapController controller = MapController();

  fm.Polyline currentWasteWalkRoute = fm.Polyline(
      points: [],
      color: Colors.green,
      strokeWidth: 6,
      borderStrokeWidth: 6,
      borderColor: Colors.green);
  List<fm.Polyline> wasteWalkRoutes = [];

  fm.Marker currentPosMarker = fm.Marker(
    point: LatLng(0, 0),
    width: 10,
    height: 10,
    builder: (context) => Icon(Icons.my_location),
  );
  fm.Marker startPosMarker = fm.Marker(
    point: LatLng(0, 0),
    width: 10,
    height: 10,
    builder: (context) => Icon(Icons.start),
  );

  List<fm.Marker> markers = [];

  bool trackingActive = false;
  bool lockPositionValue = true;
  bool hideOtherWalks = false;

  late DateTime startTime; // Setze das Startdatum
  late Timer _timer;
  Duration difference = Duration.zero;

  String formattedDuration = "0:00:00";

  double _currentZoom = 16;

  late Coordinate lastCoordinate;

  MapViewModel() {
    backgroundLocationService.initBackgroundLocation();
    backgroundLocationService.onNewCoordinate =
        (p0) => proccessNewCoordinate(p0);
    backgroundLocationService.startLocationTimer();

    markers.add(currentPosMarker);
    wasteWalkRoutes.add(currentWasteWalkRoute);
  }

  void proccessNewCoordinate(Coordinate newCoordinate) {
    if (trackingActive) {
      wasteWalkRoutes.remove(currentWasteWalkRoute);
      currentWasteWalkRoute.points
          .add(LatLng(newCoordinate.latitude!, newCoordinate.longtitude!));
      wasteWalkRoutes.add(currentWasteWalkRoute);
      print(currentWasteWalkRoute.points);
    }
    if (lockPositionValue) {
      controller.move(
          LatLng(newCoordinate.latitude!, newCoordinate.longtitude!),
          _currentZoom);
    }

    markers.remove(currentPosMarker);
    currentPosMarker = fm.Marker(
      point: LatLng(newCoordinate.latitude!, newCoordinate.longtitude!),
      width: 10,
      height: 10,
      builder: (context) => Icon(Icons.my_location),
    );
    markers.add(currentPosMarker);

    lastCoordinate = newCoordinate;
    notifyListeners();
  }

  void toggleTracking() {
    if (!trackingActive) {
      startTimer();
      print(lastCoordinate);
      startPosMarker = fm.Marker(
        point: LatLng(lastCoordinate.latitude!, lastCoordinate.longtitude!),
        width: 10,
        height: 10,
        builder: (context) => Icon(Icons.start),
      );
      markers.add(startPosMarker);
    } else {
      stopTimer();
      markers.remove(startPosMarker);
      wasteWalkRoutes.remove(currentWasteWalkRoute);
      currentWasteWalkRoute.points.clear();
    }
    trackingActive = !trackingActive;
    notifyListeners();
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, _updateTimer);
    startTime = DateTime.now();
  }

  void _updateTimer(Timer timer) {
    final currentTime = DateTime.now();
    difference = currentTime.difference(startTime);
    formattedDuration = difference.toString().split('.')[0];
    notifyListeners();
  }

  void stopTimer() {
    _timer.cancel();
    formattedDuration = "0:00:00";
    notifyListeners();
  }

  void lockPosition() {
    lockPositionValue = true;
    print(lockPositionValue);
    notifyListeners();
  }

  void unlockPosition() {
    lockPositionValue = false;
    notifyListeners();
  }

  void toggleHideOtherWalks() {
    hideOtherWalks = !hideOtherWalks;
    notifyListeners();
  }

  void onPositionChanged(MapPosition position, bool hasGesture) {
    if (lockPositionValue && hasGesture) {
      unlockPosition();
    }
    _currentZoom = position.zoom!;
    // print("Center: ${position.center!.latitude} ${position.center!.longitude}");
    // print("Zoom: ${position.zoom}");
    // print(
    //     "Bounds: N${position.bounds!.north} E${position.bounds!.east} S${position.bounds!.south} W${position.bounds!.west}");
    // print("Has Gesture: $hasGesture");
  }
}
