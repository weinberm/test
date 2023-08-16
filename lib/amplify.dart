import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

class AmplifyService {
  Future<void> configure() async {
    final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(api);

    try {
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }

  Future<void> createRecord(List<Coordinate> coordinates, int user_id) async {
    try {
      final record = Record(
        date: DateTime.now().toString(),
        coordinates: coordinates,
        user_id: user_id,
      );
      final request = ModelMutations.create(record);
      final response = await Amplify.API.mutate(request: request).response;

      final createdTodo = response.data;
      if (createdTodo == null) {
        print('errors: ${response.errors}');
        return;
      }
      print('Mutation result: ${createdTodo.id}');
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }
}
