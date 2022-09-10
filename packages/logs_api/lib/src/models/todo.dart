import 'package:equatable/equatable.dart';
import 'package:logs_api/logs_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:logs_api/logs_api.dart';

part 'todo.g.dart';

/// {@template todo}
/// A single todo item.
/// TODO update
/// Contains a list of [todo]s, [todo]s, adl's [id], in addition to the [sentiment]
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Todo]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class Todo extends Equatable {
  /// {@macro todo}
  Todo({
    String? id,
    this.action = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty, // id: ''
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the todo.
  ///
  /// Cannot be empty.
  final String id;

  /// The action for the todo
  ///
  /// Cannot be empty.
  final String action;

  /// Whether or not the todo is completed
  ///
  /// Note that the date may be empty.
  final bool isCompleted;

  /// Returns a copy of this todo with the given values updated.
  ///
  /// {@macro todo}
  Todo copyWith({
    String? id,
    String? action,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      action: action ?? this.action,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Deserializes the given [JsonMap] into a [Todo].
  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

  /// Converts this [Todo] into a [JsonMap].
  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object> get props => [
        id,
        action,
        isCompleted,
      ];
}
