import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logs_api/logs_api.dart';
import 'package:logs_repository/logs_repository.dart';

part 'edit_log_event.dart';
part 'edit_log_state.dart';

class EditLogBloc extends Bloc<EditLogEvent, EditLogState> {
  EditLogBloc({
    required LogsRepository logsRepository,
    required Log? initialLog,
    required User user,
  })  : _logsRepository = logsRepository,
        _user = user,
        super(
          EditLogState(
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
    on<EditLogCommentsChanged>(_onCommentsChanged);
    on<EditLogIADLSChanged>(_onIADLSChanged);
    on<EditLogBADLSChanged>(_onBADLSChanged);
    on<EditLogTodosChanged>(_onTodosChanged);
    on<EditLogSentimentChanged>(_onSentimentChanged);
    on<EditLogCompletedChanged>(_onCompletedChanged);
    on<EditLogisCompletedChanged>(_onisCompletedChanged);
    on<EditLogSubmitted>(_onSubmitted);
  }

  final LogsRepository _logsRepository;
  final User _user;

  void _onCommentsChanged(
    EditLogCommentsChanged event,
    Emitter<EditLogState> emit,
  ) {
    emit(state.copyWith(comments: event.comments));
  }

  void _onIADLSChanged(
    EditLogIADLSChanged event,
    Emitter<EditLogState> emit,
  ) {
    emit(state.copyWith(iadls: event.iadls));
  }

  void _onBADLSChanged(
    EditLogBADLSChanged event,
    Emitter<EditLogState> emit,
  ) {
    emit(state.copyWith(badls: event.badls));
  }

  void _onTodosChanged(
    EditLogTodosChanged event,
    Emitter<EditLogState> emit,
  ) {
    emit(state.copyWith(todos: event.todos));
  }

  void _onSentimentChanged(
    EditLogSentimentChanged event,
    Emitter<EditLogState> emit,
  ) {
    emit(state.copyWith(sentiment: event.sentiment));
  }

  void _onCompletedChanged(
    EditLogCompletedChanged event,
    Emitter<EditLogState> emit,
  ) {
    emit(state.copyWith(
        status: EditLogStatus.updated, completed: event.completed));
  }

  void _onisCompletedChanged(
    EditLogisCompletedChanged event,
    Emitter<EditLogState> emit,
  ) {
    emit(state.copyWith(isCompleted: event.isCompleted));
  }

  Future<void> _onSubmitted(
    EditLogSubmitted event,
    Emitter<EditLogState> emit,
  ) async {
    emit(state.copyWith(status: EditLogStatus.loading));

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
      emit(state.copyWith(status: EditLogStatus.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: EditLogStatus.failure));
    }
  }
}
