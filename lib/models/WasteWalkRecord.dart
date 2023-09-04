/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the WasteWalkRecord type in your schema. */
class WasteWalkRecord extends amplify_core.Model {
  static const classType = const _WasteWalkRecordModelType();
  final String id;
  final List<Coordinate>? _coordinates;
  final String? _date;
  final String? _user_id;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  WasteWalkRecordModelIdentifier get modelIdentifier {
      return WasteWalkRecordModelIdentifier(
        id: id
      );
  }
  
  List<Coordinate>? get coordinates {
    return _coordinates;
  }
  
  String? get date {
    return _date;
  }
  
  String get user_id {
    try {
      return _user_id!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const WasteWalkRecord._internal({required this.id, coordinates, date, required user_id, createdAt, updatedAt}): _coordinates = coordinates, _date = date, _user_id = user_id, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory WasteWalkRecord({String? id, List<Coordinate>? coordinates, String? date, required String user_id}) {
    return WasteWalkRecord._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      coordinates: coordinates != null ? List<Coordinate>.unmodifiable(coordinates) : coordinates,
      date: date,
      user_id: user_id);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WasteWalkRecord &&
      id == other.id &&
      DeepCollectionEquality().equals(_coordinates, other._coordinates) &&
      _date == other._date &&
      _user_id == other._user_id;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("WasteWalkRecord {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("coordinates=" + (_coordinates != null ? _coordinates!.toString() : "null") + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("user_id=" + "$_user_id" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  WasteWalkRecord copyWith({List<Coordinate>? coordinates, String? date, String? user_id}) {
    return WasteWalkRecord._internal(
      id: id,
      coordinates: coordinates ?? this.coordinates,
      date: date ?? this.date,
      user_id: user_id ?? this.user_id);
  }
  
  WasteWalkRecord copyWithModelFieldValues({
    ModelFieldValue<List<Coordinate>?>? coordinates,
    ModelFieldValue<String?>? date,
    ModelFieldValue<String>? user_id
  }) {
    return WasteWalkRecord._internal(
      id: id,
      coordinates: coordinates == null ? this.coordinates : coordinates.value,
      date: date == null ? this.date : date.value,
      user_id: user_id == null ? this.user_id : user_id.value
    );
  }
  
  WasteWalkRecord.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _coordinates = json['coordinates'] is List
        ? (json['coordinates'] as List)
          .where((e) => e != null)
          .map((e) => Coordinate.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _date = json['date'],
      _user_id = json['user_id'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'coordinates': _coordinates?.map((Coordinate? e) => e?.toJson()).toList(), 'date': _date, 'user_id': _user_id, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'coordinates': _coordinates,
    'date': _date,
    'user_id': _user_id,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<WasteWalkRecordModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<WasteWalkRecordModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final COORDINATES = amplify_core.QueryField(fieldName: "coordinates");
  static final DATE = amplify_core.QueryField(fieldName: "date");
  static final USER_ID = amplify_core.QueryField(fieldName: "user_id");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "WasteWalkRecord";
    modelSchemaDefinition.pluralName = "WasteWalkRecords";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'coordinates',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Coordinate')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: WasteWalkRecord.DATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: WasteWalkRecord.USER_ID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _WasteWalkRecordModelType extends amplify_core.ModelType<WasteWalkRecord> {
  const _WasteWalkRecordModelType();
  
  @override
  WasteWalkRecord fromJson(Map<String, dynamic> jsonData) {
    return WasteWalkRecord.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'WasteWalkRecord';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [WasteWalkRecord] in your schema.
 */
class WasteWalkRecordModelIdentifier implements amplify_core.ModelIdentifier<WasteWalkRecord> {
  final String id;

  /** Create an instance of WasteWalkRecordModelIdentifier using [id] the primary key. */
  const WasteWalkRecordModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'WasteWalkRecordModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is WasteWalkRecordModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}