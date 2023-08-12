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


/** This is an auto generated class representing the Coordinate type in your schema. */
class Coordinate {
  final double? _longtitude;
  final double? _latitude;

  double? get longtitude {
    return _longtitude;
  }
  
  double? get latitude {
    return _latitude;
  }
  
  const Coordinate._internal({longtitude, latitude}): _longtitude = longtitude, _latitude = latitude;
  
  factory Coordinate({double? longtitude, double? latitude}) {
    return Coordinate._internal(
      longtitude: longtitude,
      latitude: latitude);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Coordinate &&
      _longtitude == other._longtitude &&
      _latitude == other._latitude;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Coordinate {");
    buffer.write("longtitude=" + (_longtitude != null ? _longtitude!.toString() : "null") + ", ");
    buffer.write("latitude=" + (_latitude != null ? _latitude!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Coordinate copyWith({double? longtitude, double? latitude}) {
    return Coordinate._internal(
      longtitude: longtitude ?? this.longtitude,
      latitude: latitude ?? this.latitude);
  }
  
  Coordinate copyWithModelFieldValues({
    ModelFieldValue<double?>? longtitude,
    ModelFieldValue<double?>? latitude
  }) {
    return Coordinate._internal(
      longtitude: longtitude == null ? this.longtitude : longtitude.value,
      latitude: latitude == null ? this.latitude : latitude.value
    );
  }
  
  Coordinate.fromJson(Map<String, dynamic> json)  
    : _longtitude = (json['longtitude'] as num?)?.toDouble(),
      _latitude = (json['latitude'] as num?)?.toDouble();
  
  Map<String, dynamic> toJson() => {
    'longtitude': _longtitude, 'latitude': _latitude
  };
  
  Map<String, Object?> toMap() => {
    'longtitude': _longtitude,
    'latitude': _latitude
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Coordinate";
    modelSchemaDefinition.pluralName = "Coordinates";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'longtitude',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'latitude',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
  });
}