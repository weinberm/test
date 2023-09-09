import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

class AmplifyWasteWalkRecordService {
  static final AmplifyWasteWalkRecordService _instance =
      AmplifyWasteWalkRecordService._internal();

  factory AmplifyWasteWalkRecordService() {
    return _instance;
  }

  AmplifyWasteWalkRecordService._internal() {
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(api);

    try {
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }

  Future<void> createWasteWalkRecord(List<Coordinate> coordinates,
      String userId, WasteWalkMapBorder border) async {
    try {
      final record = WasteWalkRecord(
          date: DateTime.now().toString(),
          coordinates: coordinates,
          user_id: userId,
          walk_border_coordinates: border);
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

  Future<List<WasteWalkRecord?>> queryListItems() async {
    try {
      final request = ModelQueries.list(WasteWalkRecord.classType);
      final response = await Amplify.API.query(request: request).response;

      final items = response.data?.items;
      if (items == null) {
        print('errors: ${response.errors}');
        return <WasteWalkRecord?>[];
      }
      return items;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return <WasteWalkRecord?>[];
  }
}
