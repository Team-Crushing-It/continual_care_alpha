import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

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
    List<ADL>? iadls,
    List<ADL>? badls,
    this.cMood,
    this.iMood,
    this.location = '',
    DateTime? completed,
    DateTime? started,
  })  : assert(
          id == null || id.isNotEmpty, // id: ''
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4(),
        iadls = iadls ??
            [
              ADL(
                  name: 'Transportation',
                  independence:
                      'Completely manages transportation, either via driving or by organizing other transport',
                  dependence:
                      'Needs help in driving and organizing other means of transport'),
              ADL(
                name: 'Finances',
                independence:
                    'A conservator or a family member handles some or all the financials',
                dependence:
                    'Pays bills and manage financial assets without any help',
              ),
              ADL(
                name: 'Meals',
                independence:
                    'Completes everything required to get a meal on the table. It also covers shopping.',
                dependence:
                    'Assistance is needed in cooking, preparing, or shopping',
              ),
              ADL(
                name: 'Housecleaning',
                independence:
                    'Without help performs normal cleaning of areas such as kitchens, bathrooms, bedrooms',
                dependence: 'Needs help in performing normal cleaning',
              ),
              ADL(
                name: 'Communication',
                independence:
                    'Can self-manage telephone and mail - they are reachable in a timely manner',
                dependence:
                    'They are not reliable to communicate by phone or email',
              ),
              ADL(
                name: 'Medications',
                independence:
                    'Can obtain medications and take them without prompt',
                dependence:
                    'Needs prompting or assistance in obtaining and taking medication',
              )
            ],
        badls = badls ??
            [
              ADL(
                name: 'Bathing',
                independence:
                    'Bathes self completely or needs help in bathing only a single part of the body such as the back, genital area or disabled extremity.',
                dependence:
                    'Needs help with bathing more than one part of the body, getting in or out of the tub or shower. Requires total bathing',
              ),
              ADL(
                name: 'Dressing',
                independence:
                    'Gets clothes from closets and drawers and puts on clothes and outer garments complete with fasteners. May have help tying shoes.',
                dependence:
                    'Needs help with dressing self or needs to be completely dressed.',
              ),
              ADL(
                name: 'Toileting',
                independence:
                    'Goes to toilet, gets on and off, arranges clothes, cleans genital area without help.',
                dependence:
                    'Needs help transferring to the toilet, cleaning self or uses bedpan or commode.',
              ),
              ADL(
                name: 'Transferring',
                independence:
                    'Moves in and out of bed or chair unassisted. Mechanical transfer aids are acceptable',
                dependence:
                    'Needs help in moving from bed to chair or requires a complete transfer.',
              ),
              ADL(
                name: 'Continence',
                independence:
                    'Exercises complete self-control over urination and defecation.',
                dependence:
                    'Is partially or totally incontinent of bowel or bladder',
              ),
              ADL(
                name: 'Feeding',
                independence:
                    'Gets food from plate into mouth without help. Preparation of food may be done by another person.',
                dependence:
                    'Needs partial or total help with feeding or requires parenteral feeding.',
              ),
            ],
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

  /// The iadls on the log
  ///
  /// Note that the iadls may be empty.
  final List<ADL>? iadls;

  /// The badls on the log
  ///
  /// Note that the adls may be empty.
  final List<ADL>? badls;

  /// The mood of the caregiver.
  ///
  /// Note that the cMood may be empty.
  final Mood? cMood;

  /// The mood of the individual we are serving
  ///
  /// Note that the cMood may be empty.
  final Mood? iMood;

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
  List<Object?> get props => [
        id,
        comments,
        iadls,
        badls,
        cMood,
        iMood,
        location,
        completed,
      ];
}
