import 'package:equatable/equatable.dart';
import 'package:logs_api/logs_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:logs_api/logs_api.dart';

part 'log.g.dart';

enum Mood { sad, neutral, happy }

/// {@template log}
/// A single log item.
/// TODO update
/// Contains a list of [comment]s, [task]s, adl's [id], in addition to the [location]
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Log]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class Log extends Equatable {
  /// {@macro log}
  Log({
    String? id,
    this.comments = const [],
    this.tasks = const [],
    this.iadls = const [],
    this.badls = const [],
    this.cMood = Mood.neutral,
    this.iMood = Mood.neutral,
    this.location = '',
    DateTime? completed,
    DateTime? started,
  })  : assert(
          id == null || id.isNotEmpty, // id: ''
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4(),
        completed = completed ?? DateTime.now(),
        started = started ?? DateTime.now();

  /// The unique identifier of the log.
  ///
  /// Cannot be empty.
  final String id;

  /// The comments on the log
  ///
  /// Note that the comments may be empty.
  final List<Comment> comments;

  /// The tasks on the log
  ///
  /// Note that the tasks may be empty.
  final List<Task> tasks;

  /// The iadls on the log
  ///
  /// Note that the iadls may be empty.
  final List<ADL> iadls;

  /// The badls on the log
  ///
  /// Note that the adls may be empty.
  final List<ADL> badls;

  /// The mood of the caregiver.
  ///
  /// Note that the cMood may be empty.
  final Mood cMood;

  /// The mood of the individual we are serving
  ///
  /// Note that the cMood may be empty.
  final Mood iMood;

  /// The location of the log.
  ///
  /// Note that the location may be empty.
  final String location;

  /// The completed time of the log.
  ///
  /// Note that the date may be empty.
  final DateTime completed;

  /// The start time of the log.
  ///
  /// Note that the date may be empty.
  final DateTime started;

  /// Returns a copy of this log with the given values updated.
  ///
  /// {@macro log}
  Log copyWith({
    String? id,
    List<Comment>? comments,
    List<Task>? tasks,
    List<ADL>? badls,
    List<ADL>? iadls,
    Mood? cMood,
    Mood? iMood,
    String? location,
    DateTime? completed,
    DateTime? started,
  }) {
    return Log(
      id: id ?? this.id,
      comments: comments ?? this.comments,
      tasks: tasks ?? this.tasks,
      iadls: iadls ?? this.iadls,
      badls: badls ?? this.badls,
      cMood: cMood ?? this.cMood,
      iMood: iMood ?? this.iMood,
      location: location ?? this.location,
      completed: completed ?? this.completed,
      started: started ?? this.started,
    );
  }

  /// Deserializes the given [JsonMap] into a [Log].
  static Log fromJson(JsonMap json) => _$LogFromJson(json);

  /// Converts this [Log] into a [JsonMap].
  JsonMap toJson() => _$LogToJson(this);

  @override
  List<Object> get props => [
        id,
        comments,
        tasks,
        iadls,
        badls,
        cMood,
        iMood,
        location,
        completed,
      ];
}
