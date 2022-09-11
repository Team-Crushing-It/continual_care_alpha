part of 'home_overview_bloc.dart';

abstract class HomeOverviewEvent extends Equatable {
  const HomeOverviewEvent();

  @override
  List<Object?> get props => [];
}

class HomeOverviewSubscriptionRequested extends HomeOverviewEvent {}

class HomeOverviewUpcomingJobRequested extends HomeOverviewEvent {}

class HomeOverviewLogAdded extends HomeOverviewEvent {
  const HomeOverviewLogAdded({ this.job});
  final Job? job;

  @override
  List<Object?> get props => [job];
}
