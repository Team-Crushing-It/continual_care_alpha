import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'adl.g.dart';

/// {@template adl}
/// A single adl item.
/// TODO update
/// Contains a list of [adl]s, [adl]s, adl's [id], in addition to the [location]
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [ADL]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class ADL extends Equatable {
  /// {@macro adl}
  ADL({
    String? id,
    this.name = '',
    this.isIndependent = false,
    required this.dependence,
    required this.independence,
  })  : assert(
          id == null || id.isNotEmpty, 
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the adl.
  ///
  /// Cannot be empty.
  final String id;

  /// The name for the adl
  ///
  /// Cannot be empty.
  final String name;

  /// The independence for the adl
  ///
  /// has to be filled manually

  final String independence;

  /// The dependence for the adl
  ///
  /// has to be filled manually

  final String dependence;

  /// Whether or not the adl is completed
  ///
  /// Note that the date may be empty.
  final bool isIndependent;

  /// Returns a copy of this adl with the given values updated.
  ///
  /// {@macro adl}
  ADL copyWith({
    String? id,
    String? name,
    bool? isIndependent,
    String? dependence,
    String? independence,
  }) {
    return ADL(
      id: id ?? this.id,
      name: name ?? this.name,
      isIndependent: isIndependent ?? this.isIndependent,
      dependence: dependence ?? this.dependence,
      independence: dependence ?? this.independence,
    );
  }

  /// Deserializes the given [JsonMap] into a [ADL].
  static ADL fromJson(JsonMap json) => _$ADLFromJson(json);

  /// Converts this [ADL] into a [JsonMap].
  JsonMap toJson() => _$ADLToJson(this);

  @override
  List<Object> get props => [id, name, isIndependent, dependence, independence];

  @override
  String toString() {
    return '$name: $isIndependent';
  }
}
