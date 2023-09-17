import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/ModelProvider.dart';

class AmplifyWasteWalkRecordService {
  Future<void> createWasteWalkRecord(
      List<Coordinate> coordinates,
      String userId,
      double north,
      double east,
      double south,
      double west) async {
    try {
      final record = WasteWalkRecord(
          date: DateTime.now().toString(),
          coordinates: coordinates,
          user_id: userId,
          border_north: north,
          border_east: east,
          border_south: south,
          border_west: west);
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

  Future<List<WasteWalkRecord?>> queryItemsWithId(String id) async {
    try {
      final request = ModelQueries.list(WasteWalkRecord.classType,
          where: WasteWalkRecord.USER_ID
              .eq(id)); // Hier wird nach einer bestimmten ID gefiltert
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

  Future<List<WasteWalkRecord?>> queryItemsWithinBorder(
      north, east, south, west) async {
    try {
      final request = ModelQueries.list(WasteWalkRecord.classType,
          where: WasteWalkRecord.BORDER_NORTH
              .between(south, north)
              .or(WasteWalkRecord.BORDER_SOUTH.between(south, north))
              .or(WasteWalkRecord.BORDER_EAST.between(west, east))
              .or(WasteWalkRecord.BORDER_WEST.between(
                  west, east))); // Hier wird nach einer bestimmten ID gefiltert
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
