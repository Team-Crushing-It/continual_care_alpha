part of 'log_bloc.dart';

abstract class LogEvent extends Equatable {
  const LogEvent();

  @override
  List<Object> get props => [];
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

class LogTasksChanged extends LogEvent {
  const LogTasksChanged(this.tasks);

  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];
}

class LogSentimentChanged extends LogEvent {
  const LogSentimentChanged(this.sentiment);

  final String sentiment;

  @override
  List<Object> get props => [sentiment];
}

class LogCompletedChanged extends LogEvent {
  const LogCompletedChanged(this.completed);

  final DateTime completed;

  @override
  List<Object> get props => [completed];
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
