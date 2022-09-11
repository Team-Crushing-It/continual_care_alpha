part of 'home_overview_bloc.dart';

class HomeOverviewState extends Equatable {
  const HomeOverviewState({
    this.job,
    this.logs,
  });

  final Job? job;
  final List<Log>? logs;

  @override
  List<Object?> get props => [job, logs];

  HomeOverviewState copyWith({
    Job? job,
    List<Log>? logs,
  }) {
    return HomeOverviewState(
      job: job ?? this.job,
      logs: logs ?? this.logs,
    );
  }
}