import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

class AmplifyRecordService {
  static final AmplifyRecordService _instance =
      AmplifyRecordService._internal();

  factory AmplifyRecordService() {
    return _instance;
  }

  AmplifyRecordService._internal() {
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

  Future<List<Record?>> queryListItems() async {
    try {
      final request = ModelQueries.list(Record.classType);
      final response = await Amplify.API.query(request: request).response;

      final records = response.data?.items;
      print(records);
      if (records == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return records;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }
}
