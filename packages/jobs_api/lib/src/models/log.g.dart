// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) => Log(
      id: json['id'] as String?,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((dynamic e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      iadls: (json['iadls'] as List<dynamic>?)
              ?.map((dynamic e) => ADL.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      badls: (json['badls'] as List<dynamic>?)
              ?.map((dynamic e) => ADL.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      cMood: $enumDecodeNullable(_$MoodEnumMap, json['cMood']),
      iMood: $enumDecodeNullable(_$MoodEnumMap, json['iMood']),
      location: json['location'] as String? ?? '',
      completed: json['completed'] == null
          ? null
          : DateTime.parse(json['completed'] as String),
      started: json['started'] == null
          ? null
          : DateTime.parse(json['started'] as String),
    );

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'id': instance.id,
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'iadls': instance.iadls!.map((e) => e.toJson()).toList(),
      'badls': instance.badls!.map((e) => e.toJson()).toList(),
      'cMood': _$MoodEnumMap[instance.cMood],
      'iMood': _$MoodEnumMap[instance.iMood],
      'location': instance.location,
      'completed': instance.completed.toIso8601String(),
      'started': instance.started.toIso8601String(),
    };

const _$MoodEnumMap = {
  Mood.sad: 'sad',
  Mood.neutral: 'neutral',
  Mood.happy: 'happy',
};
