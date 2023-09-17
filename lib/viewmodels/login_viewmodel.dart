import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Geschäftslogik hier, zum Beispiel für den Login
  bool passwordObscured = true;

  void login() {
    String email = emailController.text;
    String password = passwordController.text;
    // Überprüfe die Anmeldedaten und führe den Login durch
    // ...
    print(email);
    print(password);
    // Nach dem Login, notifyListeners aufrufen, um die View zu aktualisieren
    notifyListeners();
  }
}
