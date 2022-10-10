// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ADL _$ADLFromJson(Map<String, dynamic> json) => ADL(
      id: json['id'] as String?,
      name: json['name'] as String? ?? '',
      isIndependent: json['isIndependent'] as bool? ?? false,
      dependence: json['dependence'] as String,
      independence: json['independence'] as String,
    );

Map<String, dynamic> _$ADLToJson(ADL instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'independence': instance.independence,
      'dependence': instance.dependence,
      'isIndependent': instance.isIndependent,
    };
