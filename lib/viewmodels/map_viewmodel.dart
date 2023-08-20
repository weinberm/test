import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';

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
  bool lockPosition = false;
  bool hideOtherWalks = false;

  late DateTime startTime; // Setze das Startdatum
  late Timer _timer;
  Duration difference = Duration.zero;

  String formattedDuration = "0:00:00";

  void startTracking() {
    if (!trackingActive) {
      startTime = DateTime.now();
      const duration = Duration(seconds: 1);
      _timer = Timer.periodic(duration, (Timer timer) {
        final currentTime = DateTime.now();
        difference = currentTime.difference(startTime);
        formattedDuration =
            difference.toString().split('.')[0]; // Entfernt die Millisekunden

        print(formattedDuration);
        notifyListeners();
      });
    } else {
      _timer.cancel();
      formattedDuration = "0:00:00";
    }

    trackingActive = !trackingActive;
    notifyListeners();
  }

  void toggleLockPosition() {
    lockPosition = !lockPosition;
    notifyListeners();
  }

  void toggleHideOtherWalks() {
    hideOtherWalks = !hideOtherWalks;
    notifyListeners();
  }
}
