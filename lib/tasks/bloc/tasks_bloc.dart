import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:jobs_repository/jobs_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({
    required JobsRepository jobsRepository,
    required List<Task>? initialTasks,
  })  : _jobsRepository = jobsRepository,
        super(
          TasksState(
            initialTasks: initialTasks,
            // action: initialTasks?.action ?? '',
            // isCompleted: initialTask?.isCompleted ?? false,
          ),
        ) {
    on<TasksActionChanged>(_onActionChanged);
    on<TasksIsCompletedChanged>(_onIsCompletedChanged);
    on<TasksAdded>(_onAdded);
    on<TasksSubmitted>(_onSubmitted);
  }

  final JobsRepository _jobsRepository;

  void _onActionChanged(
    TasksActionChanged event,
    Emitter<TasksState> emit,
  ) {
    emit(state.copyWith(action: event.action));
  }

  void _onIsCompletedChanged(
    TasksIsCompletedChanged event,
    Emitter<TasksState> emit,
  ) {
    emit(state.copyWith(isCompleted: event.isCompleted));
  }

    void _onAdded(
    TasksAdded event,
    Emitter<TasksState> emit,
  ) {
    // emit(state.copyWith(isCompleted: event.isCompleted));
  }

  Future<void> _onSubmitted(
    TasksSubmitted event,
    Emitter<TasksState> emit,
  ) async {
    emit(state.copyWith(status: TasksStatus.loading));
    // final todo = (state.initialTodo ?? Todo(title: '')).copyWith(
    //   title: state.title,
    //   description: state.description,
    // );

    try {
      // await _todosRepository.saveTodo(todo);
      emit(state.copyWith(status: TasksStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }
}
