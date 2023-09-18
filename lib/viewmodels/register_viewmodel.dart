import 'package:flutter/material.dart';
import 'package:waste_walking_ba/repositories/authentification_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  AuthentificationRepository authentificationRepository =
      AuthentificationRepository();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> register() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String email = emailController.text;

    final userRegisterSuccess = await authentificationRepository.registerUser(
        username, password, email);
    // Nach dem Register, notifyListeners aufrufen, um die View zu aktualisieren
    if (userRegisterSuccess) {
      return userRegisterSuccess;
    }
    notifyListeners();
    return false;
  }
}
