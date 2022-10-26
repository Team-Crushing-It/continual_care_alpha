part of 'log_bloc.dart';

enum LogStatus {
  initial,
  updated,
  loading,
  success,
  failure,
  caregiverCompleted,
  tasksCompleted,
  iadlsCompleted,
  badlsCompleted,
  commentsCompleted
}

enum PageStatus {
  initial,
  updated,
  loading,
  success,
  failure,
}

extension LogStatusX on LogStatus {
  bool get isLoadingOrSuccess => [
        LogStatus.loading,
        LogStatus.success,
      ].contains(this);

  bool get isUpdated => [
        PageStatus.updated,
      ].contains(this);
}

class LogState extends Equatable {
  LogState({
    this.status = LogStatus.tasksCompleted,
    this.pageStatus = PageStatus.initial,
    Log? initialLog,
    this.user = User.empty,
    this.comments = const [],
    this.tasks = const [],
    this.newTaskAction = '',
    this.iadls = const [],
    this.badls = const [],
    this.cMood = null,
    this.iMood = null,
    this.location = "",
    DateTime? completed,
    DateTime? started,
    this.isCompleted = false,
  })  : this.initialLog = Log(),
        this.completed = completed ?? DateTime.now(),
        this.started = started ?? DateTime.now();

  final LogStatus status;
  final PageStatus pageStatus;
  final Log initialLog;
  final User user;
  final List<Comment>? comments;
  final List<Task>? tasks;
  final String? newTaskAction;
  final List<ADL>? iadls;
  final List<ADL>? badls;
  final Mood? cMood;
  final Mood? iMood;
  final String? location;
  final DateTime? completed;
  final DateTime? started;
  final bool? isCompleted;

  // bool get isNewLog => initialLog == null;

  @override
  List<Object?> get props => [
        status,
        pageStatus,
        initialLog,
        comments,
        tasks,
        newTaskAction,
        user,
        iadls,
        badls,
        cMood,
        iMood,
        location,
        completed,
        started,
        isCompleted
      ];

  LogState copyWith({
    LogStatus? status,
    PageStatus? pageStatus,
    Log? initialLog,
    User? user,
    List<Comment>? comments,
    List<Task>? tasks,
    String? newTaskAction,
    List<ADL>? iadls,
    List<ADL>? badls,
    Mood? cMood,
    Mood? iMood,
    String? location,
    DateTime? completed,
    DateTime? started,
    bool? isCompleted,
  }) {
    return LogState(
      status: status ?? this.status,
      pageStatus: pageStatus ?? this.pageStatus,
      initialLog: initialLog ?? this.initialLog,
      user: user ?? this.user,
      comments: comments ?? this.comments,
      tasks: tasks ?? this.tasks,
      newTaskAction: newTaskAction ?? this.newTaskAction,
      iadls: iadls ?? this.iadls,
      badls: badls ?? this.badls,
      cMood: cMood ?? this.cMood,
      iMood: iMood ?? this.iMood,
      location: location ?? this.location,
      completed: completed ?? this.completed,
      started: started ?? this.started,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
