import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:waste_walking_ba/services/amplify_auth_service.dart';
import 'package:waste_walking_ba/services/amplify_record_service.dart';
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

class AmplifyService {
  static final AmplifyService _instance = AmplifyService._internal();

  factory AmplifyService() {
    return _instance;
  }

  AmplifyService._internal();

  bool configured = false;

  Future<void> configureAmplify() async {
    if (configured) {
      return;
    }

    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      final api = AmplifyAPI(modelProvider: ModelProvider.instance);
      await Amplify.addPlugin(api);

      await Amplify.configure(amplifyconfig);

      configured = true;
    } catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }
}
