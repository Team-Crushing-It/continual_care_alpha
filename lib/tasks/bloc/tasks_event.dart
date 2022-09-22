part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class TasksActionChanged extends TasksEvent {
  const TasksActionChanged(this.action);

  final String action;

  @override
  List<Object> get props => [action];
}

class TasksIsCompletedChanged extends TasksEvent {
  const TasksIsCompletedChanged(this.isCompleted, this.task);

  final bool isCompleted;
  final Task task;

  @override
  List<Object> get props => [isCompleted, task];
}

class TasksAdded extends TasksEvent {
  const TasksAdded(this.action);

  final String action;

  @override
  List<Object> get props => [action];
}

class TasksSubmitted extends TasksEvent {
  const TasksSubmitted();
}
