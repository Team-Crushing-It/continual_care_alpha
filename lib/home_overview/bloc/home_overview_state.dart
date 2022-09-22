part of 'home_overview_bloc.dart';

class HomeOverviewState extends Equatable {
  const HomeOverviewState({this.upcomingJob, this.priorJob, this.jobs});

  final Job? upcomingJob;
  final Job? priorJob;
  final List<Job>? jobs;

  @override
  List<Object?> get props => [
        upcomingJob,
        priorJob,
        jobs,
      ];

  HomeOverviewState copyWith({
    Job? upcomingJob,
    Job? priorJob,
    List<Job>? jobs,
  }) {
    return HomeOverviewState(
      upcomingJob: upcomingJob ?? this.upcomingJob,
      priorJob: priorJob ?? this.priorJob,
      jobs: jobs ?? this.jobs,
    );
  }
}
