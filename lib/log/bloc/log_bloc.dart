import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:logs_api/logs_api.dart';
import 'package:logs_repository/logs_repository.dart';

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  LogBloc({
    required LogsRepository logsRepository,
    required Log? initialLog,
    required User user,
  })  : _logsRepository = logsRepository,
        _user = user,
        super(
          LogState(
            initialLog: initialLog,
            user: user,
            comments: initialLog?.comments ?? [],
            iadls: initialLog?.iadls ?? [],
            badls: initialLog?.badls ?? [],
            tasks: initialLog?.tasks ?? [],
            location: initialLog?.location ?? '',
            completed: initialLog?.completed ?? DateTime.now(),
          ),
        ) {
    print(initialLog!.badls.length);
    on<LogCommentsChanged>(_onCommentsChanged);
    on<LogIADLSChanged>(_onIADLSChanged);
    on<LogBADLSChanged>(_onBADLSChanged);
    on<LogTasksChanged>(_onTasksChanged);
    on<LogLocationChanged>(_onLocationChanged);
    on<LogCompletedChanged>(_onCompletedChanged);
    on<LogisCompletedChanged>(_onisCompletedChanged);
    on<LogSubmitted>(_onSubmitted);
  }

  final LogsRepository _logsRepository;
  final User _user;

  void _onCommentsChanged(
    LogCommentsChanged event,
    Emitter<LogState> emit,
  ) {
    state.comments!.add(event.comment);
    emit(state.copyWith(
        comments: state.comments,
        lastItemOperation: event.comment,
        initialLog: state.initialLog!.copyWith(comments: state.comments)));
  }

  void _onIADLSChanged(
    LogIADLSChanged event,
    Emitter<LogState> emit,
  ) {
    List<ADL>? iadls = state.iadls;
    final previousADL = iadls![event.index];
    iadls[event.index] =
        previousADL.copyWith(isIndependent: !(previousADL.isIndependent));
    emit(state.copyWith(
        badls: iadls,
        lastItemOperation: iadls[event.index],
        initialLog: state.initialLog!.copyWith(iadls: iadls)));
    // _logsRepository.saveLog(state.initialLog!);
  }

  void _onBADLSChanged(
    LogBADLSChanged event,
    Emitter<LogState> emit,
  ) {
    List<ADL>? badls = state.badls;
    final previousADL = badls![event.index];
    badls[event.index] =
        previousADL.copyWith(isIndependent: !(previousADL.isIndependent));
    emit(state.copyWith(
        badls: badls,
        lastItemOperation: badls[event.index],
        initialLog: state.initialLog!.copyWith(badls: badls)));
    // _logsRepository.saveLog(state.initialLog!);
  }

  void _onTasksChanged(
    LogTasksChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(tasks: event.tasks));
  }

  void _onLocationChanged(
    LogLocationChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(location: event.location));
  }

  void _onCompletedChanged(
    LogCompletedChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(status: LogStatus.updated, completed: event.completed));
  }

  void _onisCompletedChanged(
    LogisCompletedChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(isCompleted: event.isCompleted));
  }

  Future<void> _onSubmitted(
    LogSubmitted event,
    Emitter<LogState> emit,
  ) async {
    emit(state.copyWith(status: LogStatus.loading));

    final log = (state.initialLog ?? Log()).copyWith(
      comments: state.comments,
      iadls: state.iadls,
      badls: state.badls,
      tasks: state.tasks,
      location: state.location,
      completed: state.completed,
    );
    print('log: $log');
    try {
      await _logsRepository.saveLog(log);
      emit(state.copyWith(status: LogStatus.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: LogStatus.failure));
    }
  }
}
