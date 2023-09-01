import '../amplifyconfiguration.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class AmplifyAuthService {
  static final AmplifyAuthService _instance = AmplifyAuthService._internal();

  bool signedIn = false;

  factory AmplifyAuthService() {
    return _instance;
  }

  AmplifyAuthService._internal() {
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    signedIn = result.isSignedIn;
    print(signedIn);
    return result.isSignedIn;
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    print(user);
    return user;
  }

  Future<void> signInWithWebUI() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI();
      safePrint('Sign in result: $result');
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<void> signInUser() async {
    try {
      final result = await Amplify.Auth.signIn(
        username: "weinberm",
        password: "123456789MaLe.",
      );
      await _handleSignInResult(result);
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<void> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
  }

  Future<void> confirmNewPassword() async {
    try {
      final result = await Amplify.Auth.confirmSignIn(
        confirmationValue: "123456789MaLe.",
      );
      return _handleSignInResult(result);
    } on AuthException catch (e) {
      safePrint('Error confirming new password: ${e.message}');
    }
  }

  Future<void> _handleSignInResult(SignInResult result) async {
    switch (result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignInStep.confirmSignInWithNewPassword:
        safePrint('Enter a new password to continue signing in');

        //confirmNewPasswordFunktion
        break;
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        final parameters = result.nextStep.additionalInfo;
        final prompt = parameters['prompt']!;
        safePrint(prompt);
        break;
      case AuthSignInStep.resetPassword:
        // final resetResult = await Amplify.Auth.resetPassword(
        //   username: username,
        // );
        // await _handleResetPasswordResult(resetResult);
        break;
      case AuthSignInStep.confirmSignUp:
        // Resend the sign up code to the registered device.
        // final resendResult = await Amplify.Auth.resendSignUpCode(
        //   username: username,
        // );
        // _handleCodeDelivery(resendResult.codeDeliveryDetails);
        break;
      case AuthSignInStep.done:
        safePrint('Sign in is complete');
        break;
      default:
        print("");
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }
}
