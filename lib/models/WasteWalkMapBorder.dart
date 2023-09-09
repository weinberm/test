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


/** This is an auto generated class representing the WasteWalkMapBorder type in your schema. */
class WasteWalkMapBorder {
  final double? _north;
  final double? _east;
  final double? _south;
  final double? _west;

  double? get north {
    return _north;
  }
  
  double? get east {
    return _east;
  }
  
  double? get south {
    return _south;
  }
  
  double? get west {
    return _west;
  }
  
  const WasteWalkMapBorder._internal({north, east, south, west}): _north = north, _east = east, _south = south, _west = west;
  
  factory WasteWalkMapBorder({double? north, double? east, double? south, double? west}) {
    return WasteWalkMapBorder._internal(
      north: north,
      east: east,
      south: south,
      west: west);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WasteWalkMapBorder &&
      _north == other._north &&
      _east == other._east &&
      _south == other._south &&
      _west == other._west;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("WasteWalkMapBorder {");
    buffer.write("north=" + (_north != null ? _north!.toString() : "null") + ", ");
    buffer.write("east=" + (_east != null ? _east!.toString() : "null") + ", ");
    buffer.write("south=" + (_south != null ? _south!.toString() : "null") + ", ");
    buffer.write("west=" + (_west != null ? _west!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  WasteWalkMapBorder copyWith({double? north, double? east, double? south, double? west}) {
    return WasteWalkMapBorder._internal(
      north: north ?? this.north,
      east: east ?? this.east,
      south: south ?? this.south,
      west: west ?? this.west);
  }
  
  WasteWalkMapBorder copyWithModelFieldValues({
    ModelFieldValue<double?>? north,
    ModelFieldValue<double?>? east,
    ModelFieldValue<double?>? south,
    ModelFieldValue<double?>? west
  }) {
    return WasteWalkMapBorder._internal(
      north: north == null ? this.north : north.value,
      east: east == null ? this.east : east.value,
      south: south == null ? this.south : south.value,
      west: west == null ? this.west : west.value
    );
  }
  
  WasteWalkMapBorder.fromJson(Map<String, dynamic> json)  
    : _north = (json['north'] as num?)?.toDouble(),
      _east = (json['east'] as num?)?.toDouble(),
      _south = (json['south'] as num?)?.toDouble(),
      _west = (json['west'] as num?)?.toDouble();
  
  Map<String, dynamic> toJson() => {
    'north': _north, 'east': _east, 'south': _south, 'west': _west
  };
  
  Map<String, Object?> toMap() => {
    'north': _north,
    'east': _east,
    'south': _south,
    'west': _west
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "WasteWalkMapBorder";
    modelSchemaDefinition.pluralName = "WasteWalkMapBorders";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'north',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'east',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'south',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'west',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
  });
}