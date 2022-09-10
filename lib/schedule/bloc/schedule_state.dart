part of 'schedule_bloc.dart';

enum ScheduleStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  ScheduleState({
    this.status = ScheduleStatus.initial,
    this.jobs = const [],
    this.filter = JobsViewFilter.all,
    this.lastDeletedJob,
    DateTime? filterBegin,
    DateTime? filterEnd,
  })  : this.filterBegin = filterBegin ??
            DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                .subtract(new Duration(days: DateTime.now().weekday - 1)),
        this.filterEnd = filterEnd ??
            DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                .add(Duration(days: (DateTime.now().weekday - 8).abs()));

  final ScheduleStatus status;
  final List<Job> jobs;
  final JobsViewFilter filter;
  final Job? lastDeletedJob;
  final DateTime? filterBegin;
  final DateTime? filterEnd;

  Iterable<Job> get filteredJobs =>
      filter.applyAll(jobs, filterBegin, filterEnd);

  ScheduleState copyWith({
    ScheduleStatus Function()? status,
    List<Job> Function()? jobs,
    JobsViewFilter Function()? filter,
    Job? Function()? lastDeletedJob,
    DateTime Function()? filterBegin,
    DateTime Function()? filterEnd,
  }) {
    return ScheduleState(
      status: status != null ? status() : this.status,
      jobs: jobs != null ? jobs() : this.jobs,
      filter: filter != null ? filter() : this.filter,
      lastDeletedJob:
          lastDeletedJob != null ? lastDeletedJob() : this.lastDeletedJob,
      filterBegin: filterBegin != null ? filterBegin() : this.filterBegin,
      filterEnd: filterEnd != null ? filterEnd() : this.filterEnd,
    );
  }

  @override
  List<Object?> get props => [
        status,
        jobs,
        filter,
        lastDeletedJob,
        filterBegin,
        filterEnd,
      ];
}
