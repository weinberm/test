import 'package:waste_walking_ba/services/amplify_record_service.dart';

import '../models/ModelProvider.dart';

class WasteWalkRecordRepository {
  static final WasteWalkRecordRepository _instance =
      WasteWalkRecordRepository._internal();

  factory WasteWalkRecordRepository() {
    return _instance;
  }

  WasteWalkRecordRepository._internal();

  AmplifyWasteWalkRecordService awsRecordService =
      AmplifyWasteWalkRecordService();

  Future<void> createWasteWalkRecord(
      List<Coordinate> currentWasteWalkCoordinates,
      String userId,
      double top,
      double right,
      double bottom,
      double left) async {
    await awsRecordService.createWasteWalkRecord(
        currentWasteWalkCoordinates, userId, top, right, bottom, left);
  }

  Future<List<WasteWalkRecord?>> queryItemsWithUserId(String id) async {
    return await awsRecordService.queryItemsWithId(id);
  }

  Future<List<WasteWalkRecord?>> queryItemsWithinBorder(
      north, east, south, west) async {
    return await awsRecordService.queryItemsWithinBorder(
        north, east, south, west);
  }
}
