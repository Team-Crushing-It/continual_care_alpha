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
      todos: (json['todos'] as List<dynamic>?)
              ?.map((dynamic e) => Todo.fromJson(e as Map<String, dynamic>))
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
      sentiment: json['sentiment'] as String? ?? '',
      completed: json['completed'] == null
          ? null
          : DateTime.parse(json['completed'] as String),
    );

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'id': instance.id,
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'todos': instance.todos.map((e) => e.toJson()).toList(),
      'iadls': instance.iadls.map((e) => e.toJson()).toList(),
      'badls': instance.badls.map((e) => e.toJson()).toList(),
      'sentiment': instance.sentiment,
      'completed': instance.completed.toIso8601String(),
    };
