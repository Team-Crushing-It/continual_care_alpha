import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:jobs_repository/jobs_repository.dart';

part 'edit_job_event.dart';
part 'edit_job_state.dart';

class EditJobBloc extends Bloc<EditJobEvent, EditJobState> {
  EditJobBloc({
    required JobsRepository jobsRepository,
    required Job? initialJob,
    required User coordinator,
  })  : _jobsRepository = jobsRepository,
        _coordinator = coordinator,
        super(
          EditJobState(
            initialJob: initialJob,
            client: initialJob?.client ?? '',
            startTime: initialJob?.startTime ?? DateTime.now(),
            duration: initialJob?.duration ?? 0,
            pay: initialJob?.pay ?? 0,
            location: initialJob?.location ?? '',
            coordinator: initialJob?.coordinator ?? coordinator,
            caregivers: initialJob?.caregivers ?? [User.empty],
            link: initialJob?.link ?? '',
            isCompleted: initialJob?.isCompleted ?? false,
          ),
        ) {
    on<EditJobClientChanged>(_onClientChanged);
    on<EditJobPayChanged>(_onPayChanged);
    on<EditJobStartTimeChanged>(_onStartTimeChanged);
    on<EditJobDurationChanged>(_onDurationChanged);
    on<EditJobLocationChanged>(_onLocationChanged);
    on<EditJobCoordinatorChanged>(_onCoordinatorChanged);
    on<EditJobCaregiversChanged>(_onCaregiversChanged);
    on<EditJobLinkChanged>(_onLinkChanged);
    on<EditJobisCompletedChanged>(_onisCompletedChanged);
    on<EditJobSubmitted>(_onSubmitted);
  }

  final JobsRepository _jobsRepository;
  final User _coordinator;

  void _onClientChanged(
    EditJobClientChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(client: event.client));
  }

  void _onPayChanged(
    EditJobPayChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(pay: event.pay));
  }

  void _onStartTimeChanged(
    EditJobStartTimeChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(
        status: EditJobStatus.updated, startTime: event.startTime));
  }

  void _onDurationChanged(
    EditJobDurationChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(duration: event.duration));
  }

  void _onLocationChanged(
    EditJobLocationChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(location: event.location));
  }

  void _onCoordinatorChanged(
    EditJobCoordinatorChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(coordinator: event.coordinator));
  }

  void _onCaregiversChanged(
    EditJobCaregiversChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(caregivers: event.caregivers));
  }

  void _onLinkChanged(
    EditJobLinkChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(link: event.link));
  }

  void _onisCompletedChanged(
    EditJobisCompletedChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(isCompleted: event.isCompleted));
  }

  Future<void> _onSubmitted(
    EditJobSubmitted event,
    Emitter<EditJobState> emit,
  ) async {
    emit(state.copyWith(status: EditJobStatus.loading));

    final job = (state.initialJob ?? Job()).copyWith(
      client: state.client,
      startTime: state.startTime,
      duration: state.duration,
      pay: state.pay,
      location: state.location,
      coordinator: _coordinator,
      caregivers: state.caregivers,
      link: state.link,
      isCompleted: state.isCompleted,
    );
    print('job: $job');
    try {
      await _jobsRepository.saveJob(job);
      emit(state.copyWith(status: EditJobStatus.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: EditJobStatus.failure));
    }
  }
}
