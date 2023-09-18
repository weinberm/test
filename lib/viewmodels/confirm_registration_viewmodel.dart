import 'package:flutter/material.dart';
import 'package:waste_walking_ba/repositories/authentification_repository.dart';

class ConfirmRegistrationViewModel extends ChangeNotifier {
  AuthentificationRepository authentificationRepository =
      AuthentificationRepository();

  final TextEditingController verificationCodeController =
      TextEditingController();

  Future<bool> verify(username) async {
    String verificationCode = verificationCodeController.text;

    final userSignedInSuccess = await authentificationRepository.confirmUser(
        username, verificationCode);
    // Nach dem ConfirmRegistration, notifyListeners aufrufen, um die View zu aktualisieren
    if (userSignedInSuccess) {
      return userSignedInSuccess;
    }
    notifyListeners();
    return false;
  }
}
