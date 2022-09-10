import 'package:jobs_api/jobs_api.dart';

/// {@template jobs_repository}
/// A repository that handles job related requests.
/// {@endtemplate}
class JobsRepository {
  /// {@macro jobs_repository}
  const JobsRepository({
    required JobsApi jobsApi,
  }) : _jobsApi = jobsApi;

  final JobsApi _jobsApi;

  /// Provides a [Stream] of all jobs.
  Stream<List<Job>> getJobs() => _jobsApi.getJobs();

  /// Saves a [job].
  ///
  /// If a [job] with the same id already exists, it will be replaced.
  Future<void> saveJob(Job job) => _jobsApi.saveJob(job);

  /// Deletes the job with the given id.
  ///
  /// If no job with the given id exists, a [JobNotFoundException] error is
  /// thrown.
  Future<void> deleteJob(String id) => _jobsApi.deleteJob(id);

  /// Deletes all completed jobs.
  ///
  /// Returns the number of deleted jobs.
  Future<int> clearCompleted() => _jobsApi.clearCompleted();

  /// Sets the `isCompleted` state of all jobs to the given value.
  ///
  /// Returns the number of updated jobs.
  Future<int> completeAll({required bool isCompleted}) =>
      _jobsApi.completeAll(isCompleted: isCompleted);
}
