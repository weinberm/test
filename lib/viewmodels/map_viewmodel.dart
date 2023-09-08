// Importiere erforderliche Pakete und Bibliotheken
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import 'package:waste_walking_ba/models/MapData.dart';
import '../models/Coordinate.dart';
import 'package:waste_walking_ba/services/backgroundlocation_service.dart';
import 'dart:async';

import 'package:waste_walking_ba/services/amplify_record_service.dart';
import '../services/amplify_auth_service.dart';

// Definiere die ViewModel-Klasse für die Kartenansicht
class MapViewModel extends ChangeNotifier {
  /// Initialisiere den Hintergrundortungsdienst für die Kartenansicht
  final BackgroundLocationService backgroundLocationService =
      BackgroundLocationService();

  AmplifyAuthService amplifyService = AmplifyAuthService();
  AmplifyWasteWalkRecordService amplifyWasteWalkRecordService =
      AmplifyWasteWalkRecordService();

  final MapData mapData = MapData();

  /// Zustandsvariablen für die Kartenansicht
  bool trackingActive = false;
  bool lockPositionValue = true;
  bool hideOtherWalks = false;
  bool widgetAlive = false;

  /// Variablen für die Zeitmessung
  late DateTime startTime; // Setze das Startdatum
  late Timer _timer;
  Duration difference = Duration.zero;
  String formattedDuration = "0:00:00";

  List<Coordinate> currentWasteWalkCoordinates = [];

  MapViewModel() : super() {
    initialize();
  }

  Future<void> initialize() async {
    /// Initialisiere den Hintergrundortungsdienst und setze Callbacks
    backgroundLocationService.initBackgroundLocation();
    backgroundLocationService.onNewCoordinate =
        (newCoordinate) => proccessNewCoordinate(newCoordinate);

    Coordinate currentPos =
        await backgroundLocationService.getCurrentPosition();

    mapData.setCurrentPosMarker(currentPos);
    mapData.changeMapCenter(currentPos);

    backgroundLocationService.startLocationTimer();

    notifyListeners();
  }

  void proccessNewCoordinate(Coordinate newCoordinate) {
    print(newCoordinate);
    if (widgetAlive) {
      if (lockPositionValue) {
        mapData.changeMapCenter(newCoordinate);
      }

      if (trackingActive) {
        currentWasteWalkCoordinates.add(newCoordinate);
        mapData.addPointToCurrentWasteWalkRoute(newCoordinate);
        print(mapData.currentWasteWalkRoute.points);
      }

      mapData.setCurrentPosMarker(newCoordinate);

      notifyListeners();
    } else {
      if (trackingActive) {
        currentWasteWalkCoordinates.add(newCoordinate);
      }
    }
  }

  // Methode zum Verarbeiten des Widget-Zerstörungsereignisses
  void onWidgetDisposed() {
    widgetAlive = false;
    print("Disposed");
  }

  void onWidgetInit() {
    widgetAlive = true;
    print("Init");
  }

  /// Funktion zum Starten des Timers
  void startTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, _updateTimer);
    startTime = DateTime.now();
  }

  /// Funktion zum Aktualisieren des Timerwerts
  void _updateTimer(Timer timer) {
    final currentTime = DateTime.now();
    difference = currentTime.difference(startTime);
    formattedDuration = difference.toString().split('.')[0];
    notifyListeners();
  }

  /// Funktion zum Stoppen des Timers
  void stopTimer() {
    _timer.cancel();
    formattedDuration = "0:00:00";
    notifyListeners();
  }

  void startTracking() {
    trackingActive = true;
    mapData.setStartPosMarkerLocation();
    mapData.addPointToCurrentWasteWalkRoute(mapData.lastCoordinate);
    currentWasteWalkCoordinates.add(mapData.lastCoordinate);
    startTimer();
    notifyListeners();
  }

  void stopTracking() async {
    trackingActive = false;
    stopTimer();
    String userId = await amplifyService.getCurrentUserId();
    amplifyWasteWalkRecordService.createWasteWalkRecord(
        currentWasteWalkCoordinates, userId);

    currentWasteWalkCoordinates.clear();
    mapData.currentWasteWalkRoute.points.clear();
    mapData.markers.remove(mapData.startPosMarker);

    notifyListeners();
  }

  /// Funktionen zum Sperren und Entsperren der Kartenposition
  void lockPosition() {
    lockPositionValue = true;
    mapData.moveMapCenterToCurrentPos();
    notifyListeners();
  }

  void unlockPosition() {
    lockPositionValue = false;
    notifyListeners();
  }

  /// Funktion zum Ein- und Ausschalten des Ausblendens anderer Abfallwege
  void toggleHideOtherWalks() {
    hideOtherWalks = !hideOtherWalks;
    notifyListeners();
  }

//   /// Wird aufgerufen, wenn die Kartenposition geändert wird
  void onPositionChanged(MapPosition position, bool hasGesture) {
    if (lockPositionValue && hasGesture) {
      unlockPosition();
    }
    // _currentZoom = position.zoom!;
    // // print("Center: ${position.center!.latitude} ${position.center!.longitude}");
    // // print("Zoom: ${position.zoom}");
    // // print(
    // //     "Bounds: N${position.bounds!.north} E${position.bounds!.east} S${position.bounds!.south} W${position.bounds!.west}");
    // // print("Has Gesture: $hasGesture");
  }
}
