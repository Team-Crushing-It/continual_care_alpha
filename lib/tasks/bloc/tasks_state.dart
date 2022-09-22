part of 'tasks_bloc.dart';

enum TasksStatus { initial, loading, success, failure }

extension TasksStatusX on TasksStatus {
  bool get isLoadingOrSuccess => [
        TasksStatus.loading,
        TasksStatus.success,
      ].contains(this);
}

class TasksState extends Equatable {
  const TasksState({
    this.status = TasksStatus.initial,
    this.initialTasks,
    this.action = '',
    this.isCompleted = false,
  });

  final TasksStatus status;
  final List<Task>? initialTasks;
  final String action;
  final bool isCompleted;

  bool get isNewTask => initialTasks == null;

  TasksState copyWith({
    TasksStatus? status,
    List<Task>? initialTasks,
    String? action,
    bool? isCompleted,
  }) {
    return TasksState(
      status: status ?? this.status,
      initialTasks: initialTasks ?? this.initialTasks,
      action: action ?? this.action,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [status, initialTasks, action, isCompleted];
}
