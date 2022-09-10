part of 'home_overview_cubit.dart';

class HomeOverviewState extends Equatable {
  const HomeOverviewState({
    this.job,
    this.logs,
  });

  final Job? job;
  final List<Log>? logs;

  @override
  List<Object?> get props => [job, logs];
}
