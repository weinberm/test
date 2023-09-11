// Importiere erforderliche Pakete und Bibliotheken
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import 'package:waste_walking_ba/models/MapData.dart';
import 'package:waste_walking_ba/models/ModelProvider.dart';
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
  late double top;
  late double right;
  late double bottom;
  late double left;

  late double boxBorderTop;
  late double boxBorderRight;
  late double boxBorderBottom;
  late double boxBorderLeft;

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

    setNewBoxBorder(currentPos);

    List<WasteWalkRecord?> wasteWalkRecords =
        await amplifyWasteWalkRecordService.queryItemsWithinBorder(
            boxBorderTop, boxBorderRight, boxBorderBottom, boxBorderLeft);

    List<WasteWalkRecord> filteredList = wasteWalkRecords
        .where((record) => record != null)
        .map((record) => record!) // Unwrap the non-null values
        .toList();

    if (wasteWalkRecords.isNotEmpty) {
      mapData.setOtherWasteWalks(filteredList);
    }

    print(wasteWalkRecords.toString());

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

        if (newCoordinate.latitude! > top) {
          top = newCoordinate.latitude!;
        }
        if (newCoordinate.latitude! < bottom) {
          bottom = newCoordinate.latitude!;
        }
        if (newCoordinate.longtitude! > right) {
          right = newCoordinate.longtitude!;
        }
        if (newCoordinate.longtitude! < left) {
          left = newCoordinate.longtitude!;
        }
      }

      mapData.setCurrentPosMarker(newCoordinate);

      notifyListeners();
    } else {
      if (trackingActive) {
        currentWasteWalkCoordinates.add(newCoordinate);

        if (newCoordinate.latitude! > top) {
          top = newCoordinate.latitude!;
        }
        if (newCoordinate.latitude! < bottom) {
          bottom = newCoordinate.latitude!;
        }
        if (newCoordinate.longtitude! > right) {
          right = newCoordinate.longtitude!;
        }
        if (newCoordinate.longtitude! < left) {
          left = newCoordinate.longtitude!;
        }
      }
    }
  }

  // Methode zum Verarbeiten des Widget-Zerstörungsereignisses
  void onWidgetDisposed() {
    widgetAlive = false;
  }

  void onWidgetInit() {
    widgetAlive = true;
    // mapData.moveMapCenterToCurrentPos();
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
    top = mapData.lastCoordinate.latitude!;
    left = mapData.lastCoordinate.longtitude!;
    bottom = mapData.lastCoordinate.latitude!;
    right = mapData.lastCoordinate.longtitude!;
    startTimer();
    notifyListeners();
  }

  void stopTracking() async {
    trackingActive = false;
    stopTimer();
    String userId = await amplifyService.getCurrentUserId();
    amplifyWasteWalkRecordService.createWasteWalkRecord(
        currentWasteWalkCoordinates, userId, top, right, bottom, left);

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
    if (hideOtherWalks) {
      mapData.removeOtherWasteWalksFromBoxView();
    } else {
      mapData.addOtherWasteWalksToBoxView();
    }
    hideOtherWalks = !hideOtherWalks;
    notifyListeners();
  }

//   /// Wird aufgerufen, wenn die Kartenposition geändert wird
  void onPositionChanged(MapPosition position, bool hasGesture) async {
    if (lockPositionValue && hasGesture) {
      unlockPosition();
    }
    // _currentZoom = position.zoom!;
    // // print("Center: ${position.center!.latitude} ${position.center!.longitude}");
    // print(mapData.currentPosMarker.point);
    // print("Zoom: ${position.zoom}");
    // print(
    //     "Bounds: N${position.bounds!.north} E${position.bounds!.east} S${position.bounds!.south} W${position.bounds!.west}");

    // print("Inside Bounds");
    // // print("Has Gesture: $hasGesture");
    if (viewOutOfBox(position.bounds!.north, position.bounds!.east,
        position.bounds!.south, position.bounds!.west)) {
      List<WasteWalkRecord?> wasteWalkRecords =
          await amplifyWasteWalkRecordService.queryItemsWithinBorder(
              position.bounds!.north,
              position.bounds!.east,
              position.bounds!.south,
              position.bounds!.west);

      List<WasteWalkRecord> filteredList = wasteWalkRecords
          .where((record) => record != null)
          .map((record) => record!) // Unwrap the non-null values
          .toList();

      if (wasteWalkRecords.isNotEmpty) {
        mapData.setOtherWasteWalks(filteredList);
      }

      setNewBoxBorder(Coordinate(
          latitude: position.center!.latitude,
          longtitude: position.center!.longitude));
    } else {
      print("View inside Box Border");
    }

    print("onposchanged box border");
    print("T Box: $boxBorderTop View: ${position.bounds!.north} ");
    print("R Box: $boxBorderRight View: ${position.bounds!.east}");
    print("B Box: $boxBorderBottom View: ${position.bounds!.south}");
    print("L Box: $boxBorderLeft View: ${position.bounds!.west}");

    notifyListeners();
  }

  bool viewOutOfBox(double viewTopBorder, double viewRightBorder,
      double viewBottomBorder, double viewLeftBorder) {
    if (boxBorderBottom > viewBottomBorder) {
      return true;
    } else if (boxBorderTop < viewTopBorder) {
      return true;
    } else if (boxBorderLeft > viewLeftBorder) {
      return true;
    } else if (boxBorderRight < viewRightBorder) {
      return true;
    }

    return false;
  }

  void setNewBoxBorder(Coordinate currentCoordinate) {
    boxBorderTop = currentCoordinate.latitude! + 1;
    boxBorderBottom = currentCoordinate.latitude! - 1;
    boxBorderRight = currentCoordinate.longtitude! + 0.5;
    boxBorderLeft = currentCoordinate.longtitude! - 0.5;

    print("T $boxBorderTop");
    print("R $boxBorderRight");
    print("B $boxBorderBottom");
    print("L $boxBorderLeft");
  }
}
