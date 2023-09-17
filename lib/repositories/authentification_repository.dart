import 'package:waste_walking_ba/services/amplify_auth_service.dart';

class AuthentificationRepository {
  static final AuthentificationRepository _instance =
      AuthentificationRepository._internal();

  factory AuthentificationRepository() {
    return _instance;
  }

  AuthentificationRepository._internal();

  AmplifyAuthService authentification = AmplifyAuthService();

  bool isSignedIn = false;

  Future<bool> isUserSignedIn() async {
    final result = await authentification.isUserSignedIn();
    return result;
  }

  // //TODO Create USerMOdel
  //  Future<AuthUser> getCurrentUser() async {
  //   final user = await authentification.getCurrentUser();
  //   return user;
  // }

  Future<void> signInUser(String username, String password) async {
    final result = await authentification.signInUser(username, password);
  }

  Future<void> signOutCurrentUser() async {
    authentification.signOutCurrentUser();
  }
}
