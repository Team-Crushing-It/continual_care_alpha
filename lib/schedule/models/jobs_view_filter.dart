import 'package:jobs_repository/jobs_repository.dart';

enum JobsViewFilter { all, rangeWeek }

extension JobsViewFilterX on JobsViewFilter {
  // bool apply(Job job) {
  //   switch (this) {
  //     case JobsViewFilter.all:
  //       return true;
  //     case JobsViewFilter.rangeWeek:
  //       {
  //         // if job is after filterBeing
  //         // and if job is before filterEnd
  //         // return a boolean
  //         return !job.isCompleted;

  //       }

  //   }
  // }

  Iterable<Job> applyAll(
      Iterable<Job> jobs, DateTime? filterBegin, DateTime? filterEnd) {
    return jobs.where((job) {
      return job.startTime.isAfter(filterBegin!) &&
          job.startTime.isBefore(filterEnd!);
    });
  }
}
