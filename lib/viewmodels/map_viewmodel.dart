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

  fm.Polyline currentWasteWalkRoute = fm.Polyline(points: []);
  List<fm.Polyline> wasteWalkRoutes = [];
  List<fm.Marker> markers = [];

  bool trackingActive = false;
  bool lockPositionValue = true;
  bool hideOtherWalks = false;

  late DateTime startTime; // Setze das Startdatum
  late Timer _timer;
  Duration difference = Duration.zero;

  String formattedDuration = "0:00:00";

  MapViewModel() {
    print("Init");
    backgroundLocationService.initBackgroundLocation();
    backgroundLocationService.onNewCoordinate =
        (p0) => proccessNewCoordinate(p0);
    backgroundLocationService.startLocationTimer();
  }

  void proccessNewCoordinate(Coordinate newCoordinate) {
    print("Callback Func");
    print(newCoordinate);
  }

  void toggleTracking() {
    if (!trackingActive) {
      startTimer();
    } else {
      stopTimer();
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
    print(formattedDuration + "New");
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
    if (lockPositionValue) {
      unlockPosition();
    }
    print("Center: ${position.center!.latitude} ${position.center!.longitude}");
    print("Zoom: ${position.zoom}");
    print(
        "Bounds: N${position.bounds!.north} E${position.bounds!.east} S${position.bounds!.south} W${position.bounds!.west}");
    print("Has Gesture: $hasGesture");
  }
}
