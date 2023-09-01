import 'package:flutter/material.dart';

import 'package:waste_walking_ba/services/amplify_record_service.dart';
import '../services/amplify_auth_service.dart';

class MainViewModel extends ChangeNotifier {
  int selectedIndex = 2;

  AmplifyAuthService amplifyService = AmplifyAuthService();
  AmplifyRecordService amplifyRecordService = AmplifyRecordService();

  void changeTabIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
