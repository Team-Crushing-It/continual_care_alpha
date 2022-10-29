import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:jobs_repository/jobs_repository.dart';

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  LogBloc({
    required JobsRepository jobsRepository,
    required Log? initialLog,
    required Job job,
    required User user,
  })  : _jobsRepository = jobsRepository,
        _job = job,
        _user = user,
        super(
          LogState(
            initialLog: initialLog,
            user: user,
            comments: initialLog?.comments ?? [],
            iadls: initialLog?.iadls ?? [],
            badls: initialLog?.badls ?? [],
            newTaskAction: '',
            tasks: job.tasks,
            client: job.client,
            cMood: initialLog?.cMood ?? null,
            iMood: initialLog?.iMood ?? null,
            location: initialLog?.location ?? '',
            completed: initialLog?.completed ?? DateTime.now(),
            started: initialLog?.started ?? DateTime.now(),
          ),
        ) {
    /// LogLocationRequested(_onLogLocationRequested)

    on<LogStatusChanged>(_onStatusChanged);
    on<LogCommentsChanged>(_onCommentsChanged);
    on<LogIADLSChanged>(_onIADLSChanged);
    on<LogBADLSChanged>(_onBADLSChanged);
    on<LogNewTaskActionChanged>(_onNewTaskActionChanged);
    on<LogNewTaskAdded>(_onLogNewTaskAdded);
    on<LogTasksChanged>(_onTasksChanged);
    on<LogTaskUpdated>(_onTaskUpdated);
    on<LogCMoodChanged>(_onCMoodChanged);
    on<LogIMoodChanged>(_onIMoodChanged);
    on<LogLocationRequested>(_onLocationRequested);
    on<LogCompletedChanged>(_onCompletedChanged);
    on<LogStartedChanged>(_onStartedChanged);
    on<LogisCompletedChanged>(_onisCompletedChanged);
    on<LogSubmitted>(_onSubmitted);
  }

  final JobsRepository _jobsRepository;
  final User _user;
  final Job _job;

  void _onStatusChanged(
    LogStatusChanged event,
    Emitter<LogState> emit,
  ) {
    emit(
      state.copyWith(
        status: event.status,
        pageStatus: PageStatus.initial,
      ),
    );
  }

  void _onCommentsChanged(
    LogCommentsChanged event,
    Emitter<LogState> emit,
  ) {
    final output = state.comments!.map((e) {
      return e;
    }).toList()
      ..add(event.comment);

    emit(
      state.copyWith(
        comments: output,
      ),
    );
  }

  void _onIADLSChanged(
    LogIADLSChanged event,
    Emitter<LogState> emit,
  ) {
    // flip the the checkbox value in the adl
    // update the ADL in the list of ADL's
    // filter the list of ADL's for the one that matches the other one. Then replace it.

    // the filter mechanic
    final updatedList = state.iadls!.map((adl) {
      return adl.name == event.adl.name
          ? event.adl.copyWith(isIndependent: !event.adl.isIndependent)
          : adl;
    }).toList();

    emit(state.copyWith(iadls: updatedList));
  }

  void _onIADLSInitialized(
    LogIADLSInitialized event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(iadls: event.iadls));
  }

  void _onBADLSChanged(
    LogBADLSChanged event,
    Emitter<LogState> emit,
  ) {
    // the filter mechanic
    final updatedList = state.badls!.map((adl) {
      return adl.id == event.adl.id
          ? event.adl.copyWith(isIndependent: !event.adl.isIndependent)
          : adl;
    }).toList();

    emit(state.copyWith(badls: updatedList));
  }

  void _onBADLSInitialized(
    LogBADLSInitialized event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(badls: event.badls));
  }

  void _onNewTaskActionChanged(
    LogNewTaskActionChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(newTaskAction: event.action));
  }

  void _onLogNewTaskAdded(
    LogNewTaskAdded event,
    Emitter<LogState> emit,
  ) {
    // create a task model
    final newTask = Task(action: state.newTaskAction!);

    // add that task to the existing list
    final output = state.tasks!.map((e) => e).toList()..add(newTask);

    // updating the list
    emit(
      state.copyWith(
        tasks: output,
        newTaskAction: '',
      ),
    );

    // call something from the repository?
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

    emit(state.copyWith(
      pageStatus: PageStatus.updated,
      tasks: newList,
    ));
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
    emit(state.copyWith(cMood: event.cMood, pageStatus: PageStatus.updated));
  }

  void _onIMoodChanged(
    LogIMoodChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(iMood: event.iMood));
  }

  Future<void> _onLocationRequested(
    LogLocationRequested event,
    Emitter<LogState> emit,
  ) async {
    try {
      // get location from geo coordinates
      final location = await _jobsRepository.getLocation();
      print("location : $location");
      emit(state.copyWith(location: location));
    } on LocationPermissionNotGrantedException catch (e) {
      print(e);
    }
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

    final log = (state.initialLog).copyWith(
      comments: state.comments,
      iadls: state.iadls,
      badls: state.badls,
      location: state.location,
      completed: state.completed,
    );
    print('log: $log');

    final outputLogs = _job.logs..add(log);

    final output = _job.copyWith(logs: outputLogs);

    print('output: $output');

    try {
      await _jobsRepository.saveJob(output);
      emit(state.copyWith(status: LogStatus.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: LogStatus.failure));
    }
  }
}
