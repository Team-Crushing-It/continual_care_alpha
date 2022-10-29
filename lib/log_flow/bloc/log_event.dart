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

class LogIADLSInitialized extends LogEvent {
  LogIADLSInitialized();
  final List<ADL> iadls = [
    ADL(
        name: "Transportation",
        independence:
            "Completely manages transportation, either via driving or by organizing other transport",
        dependence:
            "Needs help in driving and organizing other means of transport"),
    ADL(
      name: "Finances",
      independence:
          "A conservator or a family member handles some or all the financials",
      dependence: "Pays bills and manage financial assets without any help",
    ),
    ADL(
      name: "Meals",
      independence:
          "Completes everything required to get a meal on the table. It also covers shopping.",
      dependence: "Assistance is needed in cooking, preparing, or shopping",
    ),
    ADL(
      name: "Housecleaning",
      independence:
          "Without help performs normal cleaning of areas such as kitchens, bathrooms, bedrooms",
      dependence: "Needs help in performing normal cleaning",
    ),
    ADL(
      name: "Communication",
      independence:
          "Can self-manage telephone and mail - they are reachable in a timely manner",
      dependence: "They are not reliable to communicate by phone or email",
    ),
    ADL(
      name: "Medications",
      independence: "Can obtain medications and take them without prompt",
      dependence:
          "Needs prompting or assistance in obtaining and taking medication",
    ),
  ];

  @override
  List<Object> get props => [iadls];
}

class LogIADLSChanged extends LogEvent {
  const LogIADLSChanged(this.adl);

  final ADL adl;

  @override
  List<Object> get props => [adl];
}

class LogBADLSInitialized extends LogEvent {
  LogBADLSInitialized();
  final List<ADL> badls = [
    ADL(
      name: "Bathing",
      independence:
          "Bathes self completely or needs help in bathing only a single part of the body such as the back, genital area or disabled extremity.",
      dependence:
          "Needs help with bathing more than one part of the\nbody, getting in or out of the tub or shower. Requires total bathing",
    ),
    ADL(
      name: "Dressing",
      independence:
          "Gets clothes from closets and drawers and puts on clothes and outer garments complete with fasteners. May have help tying shoes.",
      dependence:
          "Needs help with\ndressing self or needs to be\ncompletely dressed.",
    ),
    ADL(
      name: "Toileting",
      independence:
          "Goes to toilet, gets on and off, arranges clothes, cleans genital area without help.",
      dependence:
          "Needs help transferring to the toilet, cleaning self or uses bedpan or commode.",
    ),
    ADL(
      name: "Transferring",
      independence:
          "Moves in and out of bed or chair unassisted. Mechanical transfer aids are acceptable",
      dependence:
          "Needs help in moving from bed to chair or requires a complete transfer.",
    ),
    ADL(
      name: "Continence",
      independence:
          "Exercises complete self-control over urination and defecation.",
      dependence: "Is partially or totally incontinent of bowel or bladder",
    ),
    ADL(
      name: "Feeding",
      independence:
          "Gets food from plate into mouth without help. Preparation of food may be done by another person.",
      dependence:
          "Needs partial or total help with feeding or requires parenteral feeding.",
    ),
  ];

  @override
  List<Object> get props => [badls];
}

class LogBADLSChanged extends LogEvent {
  const LogBADLSChanged(this.adl);

  final ADL adl;

  @override
  List<Object> get props => [adl];
}

class LogNewTaskActionChanged extends LogEvent {
  const LogNewTaskActionChanged(this.action);

  final String action;

  @override
  List<Object> get props => [action];
}

class LogNewTaskAdded extends LogEvent {}

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

class LogLocationRequested extends LogEvent {}

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
