part of 'edit_log_bloc.dart';

enum EditLogStatus { initial, updated, loading, success, failure }

extension EditLogStatusX on EditLogStatus {
  bool get isLoadingOrSuccess => [
        EditLogStatus.loading,
        EditLogStatus.success,
      ].contains(this);
}

class EditLogState extends Equatable {
  EditLogState({
    this.status = EditLogStatus.initial,
    this.initialLog,
    this.user = User.empty,
    this.comments = const [],
    this.todos = const [],
    this.iadls = const [],
    this.badls = const [],
    this.sentiment = "",
    DateTime? completed,
    this.isCompleted = false,
  }) : this.completed = completed ?? DateTime.now();

  final EditLogStatus status;
  final Log? initialLog;
  final User user;
  final List<Comment>? comments;
  final List<Todo>? todos;
  final List<ADL>? iadls;
  final List<ADL>? badls;
  final String? sentiment;
  final DateTime? completed;
  final bool? isCompleted;

  bool get isNewLog => initialLog == null;

  @override
  List<Object?> get props => [
        status,
        initialLog,
        comments,
        todos,
        user,
        iadls,
        badls,
        sentiment,
        completed,
        isCompleted
      ];

  EditLogState copyWith(
      {EditLogStatus? status,
      Log? initialLog,
      User? user,
      List<Comment>? comments,
      List<Todo>? todos,
      List<ADL>? iadls,
      List<ADL>? badls,
      String? sentiment,
      DateTime? completed,
      bool? isCompleted,}) {
    return EditLogState(
      status: status ?? this.status,
      initialLog: initialLog ?? this.initialLog,
      user: user ?? this.user,
      comments: comments ?? this.comments,
      todos: todos ?? this.todos,
      iadls: iadls ?? this.iadls,
      badls: badls ?? this.badls,
      sentiment: sentiment ?? this.sentiment,
      completed: completed ?? this.completed,
      isCompleted: isCompleted ?? this.isCompleted,
      
    );
  }
}
