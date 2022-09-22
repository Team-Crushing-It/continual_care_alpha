import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobs_repository/jobs_repository.dart';

part 'home_overview_event.dart';
part 'home_overview_state.dart';

class HomeOverviewBloc extends Bloc<HomeOverviewEvent, HomeOverviewState> {
  HomeOverviewBloc({
    required JobsRepository jobsRepository,
  })  : _jobsRepository = jobsRepository,
        super(HomeOverviewState()) {
    on<HomeOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<HomeOverviewUpcomingJobRequested>(_onUpcomingJobRequested);
  }

  final JobsRepository _jobsRepository;

  Future<void> _onSubscriptionRequested(
      HomeOverviewEvent event, Emitter<HomeOverviewState> emit) async {
    await emit.forEach<List<Job>>(_jobsRepository.getJobs(), onData: (jobs) {
      return state.copyWith(jobs: jobs);
    });
  }

  Future<void> _onUpcomingJobRequested(
      HomeOverviewEvent event, Emitter<HomeOverviewState> emit) async {
    List<Job> jobs = await _jobsRepository.getJobs().first;
    jobs = jobs
        .where((element) => element.startTime.isAfter(DateTime.now()))
        .toList();
    jobs.sort(((a, b) => a.startTime.compareTo(b.startTime)));
    if (jobs.isNotEmpty) {
      final upcomingJob = jobs.first;
      emit(state.copyWith(upcomingJob: upcomingJob));
    }
  }
}
