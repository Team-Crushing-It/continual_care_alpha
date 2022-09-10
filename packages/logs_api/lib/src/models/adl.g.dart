// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ADL _$ADLFromJson(Map<String, dynamic> json) => ADL(
      id: json['id'] as String?,
      name: json['name'] as String? ?? '',
      isIndependent: json['isIndependent'] as bool? ?? false,
    );

Map<String, dynamic> _$ADLToJson(ADL instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isIndependent': instance.isIndependent,
    };
