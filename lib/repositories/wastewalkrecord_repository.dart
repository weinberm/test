import 'package:waste_walking_ba/services/amplify_record_service.dart';

class WasteWalkRecordRepository {
  static final WasteWalkRecordRepository _instance =
      WasteWalkRecordRepository._internal();

  factory WasteWalkRecordRepository() {
    return _instance;
  }

  WasteWalkRecordRepository._internal();

  AmplifyWasteWalkRecordService recordService = AmplifyWasteWalkRecordService();
}
