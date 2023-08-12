import '../lib/amplifyconfiguration.dart';
import '../lib/models/ModelProvider.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> createRecord() async {
  try {
    final record = Record(
        date: DateTime.now().toString(),
        coordinates: [Coordinate(longtitude: 48.00, latitude: 9.0)],
        user_id: 1);
    final request = ModelMutations.create(record);
    final response = await Amplify.API.mutate(request: request).response;

    final createdTodo = response.data;
    if (createdTodo == null) {
      safePrint('errors: ${response.errors}');
      return;
    }
    safePrint('Mutation result: ${createdTodo.id}');
  } on ApiException catch (e) {
    safePrint('Mutation failed: $e');
  }
}
