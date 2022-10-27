import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

/// {@template task}
/// A single task item.
/// TODO update
/// Contains a list of [task]s, [task]s, adl's [id], in addition to the [location]
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Task]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class Task extends Equatable {
  /// {@macro task}
  Task({
    String? id,
    this.action = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty, // id: ''
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the task.
  ///
  /// Cannot be empty.
  final String id;

  /// The action for the task
  ///
  /// Cannot be empty.
  final String action;

  /// Whether or not the task is completed
  ///
  /// Note that the date may be empty.
  final bool isCompleted;

  /// Returns a copy of this task with the given values updated.
  ///
  /// {@macro task}
  Task copyWith({
    String? id,
    String? action,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      action: action ?? this.action,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Deserializes the given [JsonMap] into a [Task].
  static Task fromJson(JsonMap json) => _$TaskFromJson(json);

  /// Converts this [Task] into a [JsonMap].
  JsonMap toJson() => _$TaskToJson(this);

  @override
  List<Object> get props => [
        id,
        action,
        isCompleted,
      ];
}
