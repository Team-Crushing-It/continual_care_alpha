part of 'home_overview_bloc.dart';

class HomeOverviewState extends Equatable {
  const HomeOverviewState({
    this.upcomingJob,
    this.recentJob,
    this.jobs,
  });

  final Job? upcomingJob;
  final Job? recentJob;
  final List<Job>? jobs;

  @override
  List<Object?> get props => [
        upcomingJob,
        recentJob,
        jobs,
      ];

  HomeOverviewState copyWith({
    Job? upcomingJob,
    Job? recentJob,
    List<Job>? jobs,
  }) {
    return HomeOverviewState(
      upcomingJob: upcomingJob ?? this.upcomingJob,
      recentJob: recentJob ?? this.recentJob,
      jobs: jobs ?? this.jobs,
    );
  }
}
