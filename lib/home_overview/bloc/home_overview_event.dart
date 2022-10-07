part of 'home_overview_bloc.dart';

abstract class HomeOverviewEvent extends Equatable {
  const HomeOverviewEvent();

  @override
  List<Object?> get props => [];
}

class HomeOverviewSubscriptionRequested extends HomeOverviewEvent {
  // @visibleForTesting
  const HomeOverviewSubscriptionRequested(this.group);

  final String group;

  @override
  List<Object> get props => [group];
}



