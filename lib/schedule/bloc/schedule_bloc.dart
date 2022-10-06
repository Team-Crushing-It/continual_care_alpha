import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:continual_care_alpha/schedule/schedule.dart';
import 'package:jobs_repository/jobs_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc({
    required JobsRepository jobsRepository,
  })  : _jobsRepository = jobsRepository,
        super(ScheduleState()) {
    on<ScheduleSubscriptionRequested>(_onSubscriptionRequested);
    on<ScheduleJobCompletionToggled>(_onJobCompletionToggled);
    on<ScheduleJobDeleted>(_onJobDeleted);
    on<ScheduleUndoDeletionRequested>(_onUndoDeletionRequested);
    on<ScheduleFilterChanged>(_onFilterChanged);
    on<ScheduleToggleAllRequested>(_onToggleAllRequested);
    on<ScheduleClearCompletedRequested>(_onClearCompletedRequested);
  }

  final JobsRepository _jobsRepository;

  Future<void> _onSubscriptionRequested(
    ScheduleSubscriptionRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(status: () => ScheduleStatus.loading));
    
    await emit.forEach<List<Job>>(
      _jobsRepository.getJobs('grouptest'),
      onData: (jobs) => state.copyWith(
        status: () => ScheduleStatus.success,
        jobs: () => jobs,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ScheduleStatus.failure,
      ),
    );
  }

  Future<void> _onJobCompletionToggled(
    ScheduleJobCompletionToggled event,
    Emitter<ScheduleState> emit,
  ) async {
    final newJob = event.job.copyWith(isCompleted: event.isCompleted);
    await _jobsRepository.saveJob(newJob);
  }

  Future<void> _onJobDeleted(
    ScheduleJobDeleted event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(lastDeletedJob: () => event.job));
    await _jobsRepository.deleteJob(event.job.id);
  }

  Future<void> _onUndoDeletionRequested(
    ScheduleUndoDeletionRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    assert(
      state.lastDeletedJob != null,
      'Last deleted job can not be null.',
    );

    final job = state.lastDeletedJob!;
    emit(state.copyWith(lastDeletedJob: () => null));
    await _jobsRepository.saveJob(job);
  }

  void _onFilterChanged(
    ScheduleFilterChanged event,
    Emitter<ScheduleState> emit,
  ) {
    emit(state.copyWith(
        filterBegin: () => event.filterBegin,
        filterEnd: () => event.filterEnd));
  }

  Future<void> _onToggleAllRequested(
    ScheduleToggleAllRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    final areAllCompleted = state.jobs.every((job) => job.isCompleted);
    await _jobsRepository.completeAll(isCompleted: !areAllCompleted);
  }

  Future<void> _onClearCompletedRequested(
    ScheduleClearCompletedRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    await _jobsRepository.clearCompleted();
  }
}
