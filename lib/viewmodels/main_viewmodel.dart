import 'package:flutter/material.dart';

import 'package:waste_walking_ba/services/amplify_record_service.dart';
import 'package:waste_walking_ba/services/amplify_service.dart';
import '../services/amplify_auth_service.dart';

class MainViewModel extends ChangeNotifier {
  int selectedIndex = 2;

  AmplifyAuthService amplifyService = AmplifyService().authentification;
  AmplifyWasteWalkRecordService amplifyWasteWalkRecordService =
      AmplifyService().recordService;

  void changeTabIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
