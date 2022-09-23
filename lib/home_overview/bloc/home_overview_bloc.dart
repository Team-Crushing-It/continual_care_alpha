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
  }

  final JobsRepository _jobsRepository;

  Future<void> _onSubscriptionRequested(
      HomeOverviewEvent event, Emitter<HomeOverviewState> emit) async {
    await emit.forEach<List<Job>>(_jobsRepository.getJobs(), onData: (jobs) {
      // this is used to determine the upcoming job
      final upcomingJobs = jobs
          .where((element) => element.startTime.isAfter(DateTime.now()))
          .toList();
      upcomingJobs.sort(((a, b) => a.startTime.compareTo(b.startTime)));

      final upcomingJob = upcomingJobs.first;

      // this is used to determine the most recent job
      final recentJobs = jobs
          .where((element) => element.startTime.isBefore(DateTime.now()))
          .toList();
      recentJobs.sort(((a, b) => b.startTime.compareTo(a.startTime)));

      final recentJob = recentJobs.first;

      return state.copyWith(
        jobs: jobs,
        upcomingJob: upcomingJob,
        recentJob: recentJob,
      );
    });
  }
}
