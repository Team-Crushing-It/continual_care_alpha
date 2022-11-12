part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  initialized,
  unauthenticated,
  unassigned,
  assigned
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
    this.group = '',
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;
  final String group;

  @override
  List<Object> get props => [status, user, group];

   AppState copyWith({
    AppStatus? status,
    User? user,
    String? group,
  }) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
      group: group ?? this.group,
    );
  }
}
