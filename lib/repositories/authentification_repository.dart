import 'package:waste_walking_ba/services/amplify_auth_service.dart';

class AuthentificationRepository {
  static final AuthentificationRepository _instance =
      AuthentificationRepository._internal();

  factory AuthentificationRepository() {
    return _instance;
  }

  AuthentificationRepository._internal() {
    initialize();
    print(isSignedIn);
  }

  AmplifyAuthService authentification = AmplifyAuthService();

  bool isSignedIn = false;

  Future<void> initialize() async {
    await isUserSignedIn();
    await signOutCurrentUser();
  }

  Future<bool> isUserSignedIn() async {
    final result = await authentification.isUserSignedIn();
    isSignedIn = result;
    return result;
  }

  // //TODO Create USerMOdel
  //  Future<AuthUser> getCurrentUser() async {
  //   final user = await authentification.getCurrentUser();
  //   return user;
  // }

  Future<bool> signInUser(String username, String password) async {
    try {
      await authentification.signInUser(username, password);
      isSignedIn = true;
      return true;
    } catch (e) {
      print("x");
      return false;
    }
  }

  Future<bool> signOutCurrentUser() async {
    await authentification.signOutCurrentUser();
    isSignedIn = false;
    return true;
  }

  Future<void> confirmNewPassword() async {}

  getCurrentUserId() {}

  Future<bool> registerUser(
      String username, String password, String email) async {
    try {
      await authentification.signUpUser(
          username: username, password: password, email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> confirmUser(String username, String confirmationCode) async {
    try {
      await authentification.confirmUser(
          username: username, confirmationCode: confirmationCode);
      return true;
    } catch (e) {
      return false;
    }
  }
}
