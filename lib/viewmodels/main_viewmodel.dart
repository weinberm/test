import 'package:flutter/material.dart';
import 'package:waste_walking_ba/repositories/authentification_repository.dart';

class MainViewModel extends ChangeNotifier {
  AuthentificationRepository authentificationRepository =
      AuthentificationRepository();

  void update() {
    print("Update");
    notifyListeners();
  }
}
