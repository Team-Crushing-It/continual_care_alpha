import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
            newTaskAction: '',
            tasks: initialLog?.tasks ?? [],
            cMood: initialLog?.cMood ?? null,
            iMood: initialLog?.iMood ?? null,
            location: initialLog?.location ?? '',
            completed: initialLog?.completed ?? DateTime.now(),
            started: initialLog?.started ?? DateTime.now(),
          ),
        ) {
    on<LogStatusChanged>(_onStatusChanged);
    on<LogCommentsChanged>(_onCommentsChanged);
    on<LogIADLSChanged>(_onIADLSChanged);
    on<LogBADLSChanged>(_onBADLSChanged);
    on<LogTasksChanged>(_onTasksChanged);
    on<LogNewTaskActionChanged>(_onNewTaskActionChanged);
    on<LogNewTaskAdded>(_onNewTaskAdded);
    on<LogTaskUpdated>(_onTaskUpdated);
    on<LogCMoodChanged>(_onCMoodChanged);
    on<LogIMoodChanged>(_onIMoodChanged);
    on<LogLocationChanged>(_onLocationChanged);
    on<LogCompletedChanged>(_onCompletedChanged);
    on<LogStartedChanged>(_onStartedChanged);
    on<LogisCompletedChanged>(_onisCompletedChanged);
    on<LogSubmitted>(_onSubmitted);
  }

  final LogsRepository _logsRepository;
  final User _user;

  void _onStatusChanged(
    LogStatusChanged event,
    Emitter<LogState> emit,
  ) {
    emit(
      state.copyWith(
        status: event.status,
      ),
    );
  }

  void _onCommentsChanged(
    LogCommentsChanged event,
    Emitter<LogState> emit,
  ) {
    state.comments!.add(event.comment);
    emit(state.copyWith(
        comments: state.comments,
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
        badls: iadls, initialLog: state.initialLog!.copyWith(iadls: iadls)));
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
        badls: badls, initialLog: state.initialLog!.copyWith(badls: badls)));
    // _logsRepository.saveLog(state.initialLog!);
  }

  void _onNewTaskActionChanged(
    LogNewTaskActionChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(newTaskAction: event.action));
  }

  void _onNewTaskAdded(
    LogNewTaskAdded event,
    Emitter<LogState> emit,
  ) {
    // create a task model
    final newTask = Task(action: state.newTaskAction!);

    // add that task to the existing list
    final output = state.tasks!.map((e) => e).toList();

    output.add(newTask);

    // updating the list
    emit(state.copyWith(tasks: output, newTaskAction: ''));
  }

  void _onTaskUpdated(
    LogTaskUpdated event,
    Emitter<LogState> emit,
  ) {
    // copyWith new bool for isCompleted
    // update all the tasks

    final updatedTask =
        event.task.copyWith(isCompleted: !event.task.isCompleted);


    final newList = state.tasks!.map((task) {
      return task.id == event.task.id ? updatedTask : task;
    }).toList();

    emit(state.copyWith(tasks: newList));
  }

  void _onTasksChanged(
    LogTasksChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(tasks: event.tasks));
  }

  void _onCMoodChanged(
    LogCMoodChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(cMood: event.cMood));
  }

  void _onIMoodChanged(
    LogIMoodChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(iMood: event.iMood));
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

  void _onStartedChanged(
    LogStartedChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(status: LogStatus.updated, started: event.started));
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