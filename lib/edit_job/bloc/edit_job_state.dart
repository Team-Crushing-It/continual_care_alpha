part of 'edit_job_bloc.dart';

enum EditJobStatus { initial, updated, loading, success, failure }

extension EditJobStatusX on EditJobStatus {
  bool get isLoadingOrSuccess => [
        EditJobStatus.loading,
        EditJobStatus.success,
      ].contains(this);
}

class EditJobState extends Equatable {
  EditJobState({
    this.status = EditJobStatus.initial,
    this.initialJob,
    this.client = '',
    this.pay = 0,
    DateTime? startTime,
    this.duration = 0,
    this.location = '',
    this.coordinator = User.empty,
    this.caregivers = const [User.empty],
    this.link = '',
    this.isCompleted = false,
  }) : this.startTime = startTime ?? DateTime.now();

  final EditJobStatus status;
  final Job? initialJob;
  final String? client;
  final double pay;
  final DateTime startTime;
  final double duration;
  final String location;
  final User coordinator;
  final List<User> caregivers;
  final String link;
  final bool isCompleted;

  bool get isNewJob => initialJob == null;

  EditJobState copyWith({
    EditJobStatus? status,
    Job? initialJob,
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
    return EditJobState(
      status: status ?? this.status,
      initialJob: initialJob ?? this.initialJob,
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

  @override
  List<Object?> get props => [
        status,
        initialJob,
        client,
        pay,
        startTime,
        duration,
        location,
        coordinator,
        caregivers,
        link
      ];
}
