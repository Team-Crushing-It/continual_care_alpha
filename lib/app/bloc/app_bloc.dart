import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppGetGroup>(_onGetGroup);
    on<AppUnassignedGroup>(_onUnassignedGroup);
    on<AppAssignedGroup>(_onAssignedGroup);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  void _onGetGroup(AppGetGroup event, Emitter<AppState> emit) async {
    final group = await _authenticationRepository.getUserGroup();

    emit(state.copyWith(status: AppStatus.initialized, group: group));
  }

  void _onUnassignedGroup(
      AppUnassignedGroup event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.unassigned));
  }

  void _onAssignedGroup(AppAssignedGroup event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.assigned));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
