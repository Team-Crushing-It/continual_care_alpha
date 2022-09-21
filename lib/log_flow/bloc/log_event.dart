part of 'log_bloc.dart';

abstract class LogEvent extends Equatable {
  const LogEvent();

  @override
  List<Object> get props => [];
}

class LogStatusChanged extends LogEvent {
  const LogStatusChanged(this.status);

  final LogStatus status;

  @override
  List<Object> get props => [status];
}

class LogCommentsChanged extends LogEvent {
  const LogCommentsChanged(this.comment);

  final Comment comment;

  @override
  List<Object> get props => [comment];
}

class LogIADLSChanged extends LogEvent {
  const LogIADLSChanged(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class LogBADLSChanged extends LogEvent {
  const LogBADLSChanged(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class LogNewTaskActionChanged extends LogEvent {
  const LogNewTaskActionChanged(this.action);

  final String action;

  @override
  List<Object> get props => [action];
}

class LogNewTaskAdded extends LogEvent {
  const LogNewTaskAdded();
}

class LogTasksChanged extends LogEvent {
  const LogTasksChanged(this.tasks);

  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];
}

class LogTaskUpdated extends LogEvent {
  const LogTaskUpdated(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class LogCMoodChanged extends LogEvent {
  const LogCMoodChanged(this.cMood);

  final Mood cMood;

  @override
  List<Object> get props => [cMood];
}

class LogIMoodChanged extends LogEvent {
  const LogIMoodChanged(this.iMood);

  final Mood iMood;

  @override
  List<Object> get props => [iMood];
}

class LogLocationChanged extends LogEvent {
  const LogLocationChanged(this.location);

  final String location;

  @override
  List<Object> get props => [location];
}

class LogCompletedChanged extends LogEvent {
  const LogCompletedChanged(this.completed);

  final DateTime completed;

  @override
  List<Object> get props => [completed];
}

class LogStartedChanged extends LogEvent {
  const LogStartedChanged(this.started);

  final DateTime started;

  @override
  List<Object> get props => [started];
}

class LogisCompletedChanged extends LogEvent {
  const LogisCompletedChanged(this.isCompleted);

  final bool isCompleted;

  @override
  List<Object> get props => [isCompleted];
}

class LogSubmitted extends LogEvent {
  const LogSubmitted();
}
