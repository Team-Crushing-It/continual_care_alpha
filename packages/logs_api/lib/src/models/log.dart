import 'package:equatable/equatable.dart';
import 'package:logs_api/logs_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:logs_api/logs_api.dart';

part 'log.g.dart';

/// {@template log}
/// A single log item.
//TODO: Update this
/// //update
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
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
    this.client = '',
    this.pay = 0,
    DateTime? startTime,
    this.duration = 0,
    this.location = '',
    this.coordinator = User.empty,
    this.caregivers = const [User.empty],
    this.link = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty, // id: ''
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4(),
        startTime = startTime ?? DateTime.now();

  /// The unique identifier of the log.
  ///
  /// Cannot be empty.
  final String id;

  /// The client for the log
  ///
  /// Cannot be empty.
  final String client;

  /// The pay of the log.
  ///
  /// Note that the pay may be empty.
  final double pay;

  /// The start time of the log.
  ///
  /// Note that the date may be empty.
  final DateTime startTime;

  /// The end time of the log.
  ///
  /// Note that the date may be empty.
  final double duration;

  /// The location of the log.
  ///
  /// Note that the location may be empty.
  final String location;

  /// The coordinator of the log.
  ///
  /// Note that the coordinator may be empty.
  final User coordinator;

  /// The caregivers of the log.
  ///
  /// Note that the caregiver may be empty.
  final List<User> caregivers;

  /// The link of the log.
  ///
  /// Note that the link may be empty.
  final String link;

  /// The bool of whether or not the log is done
  ///
  /// Note that the link may be empty.
  final bool isCompleted;

  /// Returns a copy of this log with the given values updated.
  ///
  /// {@macro log}
  Log copyWith({
    String? id,
    String? client,
    double? pay,
    DateTime? startTime,
    double? duration,
    String? location,
    User? coordinator,
    List<User>? caregivers,
    String? link,
    bool? isCompleted,
  }) {
    return Log(
      id: id ?? this.id,
      client: client ?? this.client,
      pay: pay ?? this.pay,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
      location: location ?? this.location,
      coordinator: coordinator ?? this.coordinator,
      caregivers: caregivers ?? this.caregivers,
      link: link ?? this.link,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Deserializes the given [JsonMap] into a [Log].
  static Log fromJson(JsonMap json) => _$LogFromJson(json);

  /// Converts this [Log] into a [JsonMap].
  JsonMap toJson() => _$LogToJson(this);

  @override
  List<Object> get props => [
        id,
        client,
        startTime,
        duration,
        pay,
        location,
        coordinator,
        caregivers,
        link,
        isCompleted
      ];
}
