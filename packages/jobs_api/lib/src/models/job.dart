import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:jobs_api/jobs_api.dart';

part 'job.g.dart';

/// {@template job}
/// A single job item.
//TODO: Update this
/// //update
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Job]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class Job extends Equatable {
  /// {@macro job}
  Job({
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

  /// The unique identifier of the job.
  ///
  /// Cannot be empty.
  final String id;

  /// The client for the job
  ///
  /// Cannot be empty.
  final String client;

  /// The pay of the job.
  ///
  /// Note that the pay may be empty.
  final double pay;

  /// The start time of the job.
  ///
  /// Note that the date may be empty.
  final DateTime startTime;

  /// The end time of the job.
  ///
  /// Note that the date may be empty.
  final double duration;

  /// The location of the job.
  ///
  /// Note that the location may be empty.
  final String location;

  /// The coordinator of the job.
  ///
  /// Note that the coordinator may be empty.
  final User coordinator;

  /// The caregivers of the job.
  ///
  /// Note that the caregiver may be empty.
  final List<User> caregivers;

  /// The link of the job.
  ///
  /// Note that the link may be empty.
  final String link;

  /// The bool of whether or not the job is done
  ///
  /// Note that the link may be empty.
  final bool isCompleted;

  /// Returns a copy of this job with the given values updated.
  ///
  /// {@macro job}
  Job copyWith({
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
    return Job(
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

  /// Deserializes the given [JsonMap] into a [Job].
  static Job fromJson(JsonMap json) => _$JobFromJson(json);

  /// Converts this [Job] into a [JsonMap].
  JsonMap toJson() => _$JobToJson(this);

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
