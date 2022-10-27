import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'comment.g.dart';

/// {@template comment}
/// A single comment item.
/// TODO update
/// Contains a list of [comment]s, [task]s, adl's [id], in addition to the [location]
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Comment]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class Comment extends Equatable {
  /// {@macro comment}
  Comment({
    String? id,
    this.username = '',
    this.comment = '',
    DateTime? time,
  })  : assert(
          id == null || id.isNotEmpty, // id: ''
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4(),
        time = time ?? DateTime.now();

  /// The unique identifier of the comment.
  ///
  /// Cannot be empty.
  final String id;

  /// The username for the comment
  ///
  /// Cannot be empty.
  final String username;

  /// The comment of the comment.
  ///
  /// Note that the comment may be empty.
  final String comment;

  /// The start time of the comment.
  ///
  /// Note that the date may be empty.
  final DateTime time;

  /// Returns a copy of this comment with the given values updated.
  ///
  /// {@macro comment}
  Comment copyWith({
    String? id,
    String? username,
    String? comment,
    DateTime? time,
  }) {
    return Comment(
      id: id ?? this.id,
      username: username ?? this.username,
      comment: comment ?? this.comment,
      time: time ?? this.time,
    );
  }

  /// Deserializes the given [JsonMap] into a [Comment].
  static Comment fromJson(JsonMap json) => _$CommentFromJson(json);

  /// Converts this [Comment] into a [JsonMap].
  JsonMap toJson() => _$CommentToJson(this);

  @override
  List<Object> get props => [
        id,
        username,
        comment,
        time,
      ];
}
