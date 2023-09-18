import 'package:flutter/material.dart';
import 'package:waste_walking_ba/repositories/authentification_repository.dart';

class LoginViewModel extends ChangeNotifier {
  AuthentificationRepository authentificationRepository =
      AuthentificationRepository();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Geschäftslogik hier, zum Beispiel für den Login
  bool passwordObscured = true;

  Future<bool> login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    final userSignedInSuccess =
        await authentificationRepository.signInUser(username, password);
    // Nach dem Login, notifyListeners aufrufen, um die View zu aktualisieren
    if (userSignedInSuccess) {
      return userSignedInSuccess;
    }
    notifyListeners();
    return false;
  }

  void togglePasswordObscured() {
    passwordObscured = !passwordObscured;
    print(passwordObscured);
    notifyListeners();
  }
}
