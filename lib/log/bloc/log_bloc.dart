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
            todos: initialLog?.todos ?? [],
            sentiment: initialLog?.sentiment ?? '',
            completed: initialLog?.completed ?? DateTime.now(),
          ),
        ) {
    on<LogCommentsChanged>(_onCommentsChanged);
    on<LogIADLSChanged>(_onIADLSChanged);
    on<LogBADLSChanged>(_onBADLSChanged);
    on<LogTodosChanged>(_onTodosChanged);
    on<LogSentimentChanged>(_onSentimentChanged);
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
    emit(state.copyWith(comments: event.comments));
  }

  void _onIADLSChanged(
    LogIADLSChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(iadls: event.iadls));
  }

  void _onBADLSChanged(
    LogBADLSChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(badls: event.badls));
  }

  void _onTodosChanged(
    LogTodosChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(todos: event.todos));
  }

  void _onSentimentChanged(
    LogSentimentChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(sentiment: event.sentiment));
  }

  void _onCompletedChanged(
    LogCompletedChanged event,
    Emitter<LogState> emit,
  ) {
    emit(state.copyWith(
        status: LogStatus.updated, completed: event.completed));
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
      todos: state.todos,
      sentiment: state.sentiment,
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
