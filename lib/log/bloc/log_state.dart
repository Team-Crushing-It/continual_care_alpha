part of 'log_bloc.dart';

enum LogStatus { initial, updated, loading, success, failure }

extension LogStatusX on LogStatus {
  bool get isLoadingOrSuccess => [
        LogStatus.loading,
        LogStatus.success,
      ].contains(this);
}

class LogState extends Equatable {
  LogState({
    this.status = LogStatus.initial,
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

  final LogStatus status;
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

  LogState copyWith(
      {LogStatus? status,
      Log? initialLog,
      User? user,
      List<Comment>? comments,
      List<Todo>? todos,
      List<ADL>? iadls,
      List<ADL>? badls,
      String? sentiment,
      DateTime? completed,
      bool? isCompleted,}) {
    return LogState(
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
