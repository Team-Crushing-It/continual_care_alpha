part of 'edit_job_bloc.dart';

abstract class EditJobEvent extends Equatable {
  const EditJobEvent();

  @override
  List<Object> get props => [];
}

class EditJobClientChanged extends EditJobEvent {
  const EditJobClientChanged(this.client);

  final String client;

  @override
  List<Object> get props => [client];
}

class EditJobPayChanged extends EditJobEvent {
  const EditJobPayChanged(this.pay);

  final double pay;

  @override
  List<Object> get props => [pay];
}

class EditJobStartTimeChanged extends EditJobEvent {
  const EditJobStartTimeChanged(this.startTime);

  final DateTime startTime;

  @override
  List<Object> get props => [startTime];
}

class EditJobDurationChanged extends EditJobEvent {
  const EditJobDurationChanged(this.duration);

  final double duration;

  @override
  List<Object> get props => [duration];
}


class EditJobLocationChanged extends EditJobEvent {
  const EditJobLocationChanged(this.location);

  final String location;

  @override
  List<Object> get props => [location];
}

class EditJobCoordinatorChanged extends EditJobEvent {
  const EditJobCoordinatorChanged(this.coordinator);

  final User coordinator;

  @override
  List<Object> get props => [coordinator];
}

class EditJobCaregiversChanged extends EditJobEvent {
  const EditJobCaregiversChanged(this.caregivers);

  final List<User> caregivers;

  @override
  List<Object> get props => [caregivers];
}


class EditJobLinkChanged extends EditJobEvent {
  const EditJobLinkChanged(this.link);

  final String link;

  @override
  List<Object> get props => [link];
}

class EditJobisCompletedChanged extends EditJobEvent {
  const EditJobisCompletedChanged(this.isCompleted);

  final bool isCompleted;

  @override
  List<Object> get props => [isCompleted];
}

class EditJobSubmitted extends EditJobEvent {
  const EditJobSubmitted();
}
