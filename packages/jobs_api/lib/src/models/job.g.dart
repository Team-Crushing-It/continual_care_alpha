// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      id: json['id'] as String?,
      client: json['client'] as String? ?? '',
      pay: (json['pay'] as num?)?.toDouble() ?? 0,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      duration: (json['duration'] as num?)?.toDouble() ?? 0,
      location: json['location'] as String? ?? '',
      coordinator: json['coordinator'] == null
          ? User.empty
          : User.fromJson(json['coordinator'] as Map<String, dynamic>),
      caregivers: (json['caregivers'] as List<dynamic>?)
              ?.map((dynamic e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [User.empty],
      logs: (json['logs'] as List<dynamic>?)
              ?.map((dynamic e) => Log.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tasks: (json['tasks'] as List<dynamic>?)
              ?.map((dynamic e) => Task.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'pay': instance.pay,
      'startTime': instance.startTime.toIso8601String(),
      'duration': instance.duration,
      'location': instance.location,
      'coordinator': instance.coordinator.toJson(),
      'caregivers': instance.caregivers.map((e) => e.toJson()).toList(),
      'logs': instance.logs.map((e) => e.toJson()).toList(),
      'tasks': instance.tasks.map((e) => e.toJson()).toList(),
      'isCompleted': instance.isCompleted,
    };
