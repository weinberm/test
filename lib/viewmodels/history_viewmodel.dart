import 'package:flutter/material.dart';
import 'package:waste_walking_ba/services/amplify_record_service.dart';

import '../models/WasteWalkRecord.dart';

class HistoryViewModel extends ChangeNotifier {
  AmplifyWasteWalkRecordService amplifyWasteWalkRecordService =
      AmplifyWasteWalkRecordService();

  List<WasteWalkRecord> recordHistory = [];

  HistoryViewModel() {
    _initializeViewModel();
  }

  Future<void> _initializeViewModel() async {
    List<WasteWalkRecord?> records =
        await amplifyWasteWalkRecordService.queryListItems();
    //In diesem Code wird die Methode queryListItems() aufgerufen und die zurückgegebene Liste wird in records gespeichert.
    //Dann wird where() verwendet, um alle null-Werte zu filtern, und map() wird verwendet, um die optionalen WasteWalkRecord-Objekte in nicht optionale WasteWalkRecord-Objekte umzuwandeln.
    //Schließlich wird toList() aufgerufen, um die resultierende Liste von nicht optionalen WasteWalkRecord-Objekten in recordHistory zu speichern.
    recordHistory = records
        .where((record) => record != null)
        .map((record) => record!)
        .toList();
    print(recordHistory);
  }
}
