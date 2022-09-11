part of 'edit_log_bloc.dart';

abstract class EditLogEvent extends Equatable {
  const EditLogEvent();

  @override
  List<Object> get props => [];
}

class EditLogCommentsChanged extends EditLogEvent {
  const EditLogCommentsChanged(this.comments);

  final List<Comment> comments;

  @override
  List<Object> get props => [comments];
}

class EditLogIADLSChanged extends EditLogEvent {
  const EditLogIADLSChanged(this.iadls);

  final List<ADL> iadls;

  @override
  List<Object> get props => [iadls];
}

class EditLogBADLSChanged extends EditLogEvent {
  const EditLogBADLSChanged(this.badls);

  final List<ADL> badls;

  @override
  List<Object> get props => [badls];
}

class EditLogTodosChanged extends EditLogEvent {
  const EditLogTodosChanged(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
}

class EditLogSentimentChanged extends EditLogEvent {
  const EditLogSentimentChanged(this.sentiment);

  final String sentiment;

  @override
  List<Object> get props => [sentiment];
}

class EditLogCompletedChanged extends EditLogEvent {
  const EditLogCompletedChanged(this.completed);

  final DateTime completed;

  @override
  List<Object> get props => [completed];
}

class EditLogisCompletedChanged extends EditLogEvent {
  const EditLogisCompletedChanged(this.isCompleted);

  final bool isCompleted;

  @override
  List<Object> get props => [isCompleted];
}

class EditLogSubmitted extends EditLogEvent {
  const EditLogSubmitted();
}
