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
    this.lastItemOperation,
    this.status = LogStatus.initial,
    this.initialLog,
    this.user = User.empty,
    this.comments = const [],
    this.tasks = const [],
    this.iadls = const [],
    this.badls = const [],
    this.mood = "",
    DateTime? completed,
    this.isCompleted = false,
  }) : this.completed = completed ?? DateTime.now();

  final LogStatus status;
  final Log? initialLog;
  final dynamic lastItemOperation;
  final User user;
  final List<Comment>? comments;
  final List<Task>? tasks;
  final List<ADL>? iadls;
  final List<ADL>? badls;
  final String? mood;
  final DateTime? completed;
  final bool? isCompleted;

  bool get isNewLog => initialLog == null;

  @override
  List<Object?> get props => [
        status,
        lastItemOperation,
        initialLog,
        comments,
        tasks,
        user,
        iadls,
        badls,
        mood,
        completed,
        isCompleted
      ];

  LogState copyWith(
      {LogStatus? status,
      dynamic lastItemOperation,
      Log? initialLog,
      dynamic las,
      User? user,
      List<Comment>? comments,
      List<Task>? tasks,
      List<ADL>? iadls,
      List<ADL>? badls,
      String? mood,
      DateTime? completed,
      bool? isCompleted,}) {
    return LogState(
      status: status ?? this.status,
      lastItemOperation:lastItemOperation ?? this.lastItemOperation,
      initialLog: initialLog ?? this.initialLog,
      user: user ?? this.user,
      comments: comments ?? this.comments,
      tasks: tasks ?? this.tasks,
      iadls: iadls ?? this.iadls,
      badls: badls ?? this.badls,
      mood: mood ?? this.mood,
      completed: completed ?? this.completed,
      isCompleted: isCompleted ?? this.isCompleted,
      
    );
  }
}
