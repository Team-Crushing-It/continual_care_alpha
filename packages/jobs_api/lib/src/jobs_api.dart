import 'package:jobs_api/jobs_api.dart';

/// {@template jobs_api}
/// The interface for an API that provides access to a list of jobs.
/// {@endtemplate}
abstract class JobsApi {
  /// {@macro jobs_api}
  const JobsApi();

  /// Provides a [Stream] of all jobs.
  Stream<List<Job>> getJobs();

  /// Saves a [job].
  ///
  /// If a [job] with the same id already exists, it will be replaced.
  Future<void> saveJob(Job job);

  /// Deletes the job with the given id.
  ///
  /// If no job with the given id exists, a [JobNotFoundException] error is
  /// thrown.
  Future<void> deleteJob(String id);

  /// Deletes all completed jobs.
  ///
  /// Returns the number of deleted jobs.
  Future<int> clearCompleted();

  /// Sets the `isCompleted` state of all jobs to the given value.
  ///
  /// Returns the number of updated jobs.
  Future<int> completeAll({required bool isCompleted});
}

/// Error thrown when a [Job] with a given id is not found.
class JobNotFoundException implements Exception {}
