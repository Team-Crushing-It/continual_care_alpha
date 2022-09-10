part of 'home_overview_cubit.dart';

class HomeOverviewState extends Equatable {
  const HomeOverviewState({this.job });
  final Job? job;
  @override
  List<Object?> get props => [job];
}

