part of 'home_cubit.dart';

enum CurrentHomePage { overview, schedule, alert }


class HomeState extends Equatable {
  const HomeState({
    this.page = CurrentHomePage.schedule,
  });

  final CurrentHomePage page;

  @override
  List<Object> get props => [page];
}
