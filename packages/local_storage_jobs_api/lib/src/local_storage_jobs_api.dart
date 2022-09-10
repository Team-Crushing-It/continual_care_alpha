import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jobs_api/jobs_api.dart';

/// {@template local_storage_jobs_api}
/// A Flutter implementation of the [JobsApi] that uses local storage.
/// {@endtemplate}
class LocalStorageJobsApi extends JobsApi {
  /// {@macro local_storage_jobs_api}
  LocalStorageJobsApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _jobStreamController = BehaviorSubject<List<Job>>.seeded(const []);

  /// The key used for storing the jobs locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kJobsCollectionKey = '__jobs_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final jobsJson = _getValue(kJobsCollectionKey);
    if (jobsJson != null) {
      final jobs = List<Map>.from(json.decode(jobsJson) as List)
          .map((jsonMap) => Job.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _jobStreamController.add(jobs);
    } else {
      _jobStreamController.add(const []);
    }
  }

  @override
  Stream<List<Job>> getJobs() => _jobStreamController.asBroadcastStream();

  @override
  Future<void> saveJob(Job job) {
    final jobs = [..._jobStreamController.value];
    final jobIndex = jobs.indexWhere((t) => t.id == job.id);
    if (jobIndex >= 0) {
      jobs[jobIndex] = job;
    } else {
      jobs.add(job);
    }

    _jobStreamController.add(jobs);
    return _setValue(kJobsCollectionKey, json.encode(jobs));
  }

  @override
  Future<void> deleteJob(String id) async {
    final jobs = [..._jobStreamController.value];
    final jobIndex = jobs.indexWhere((t) => t.id == id);
    if (jobIndex == -1) {
      throw JobNotFoundException();
    } else {
      jobs.removeAt(jobIndex);
      _jobStreamController.add(jobs);
      return _setValue(kJobsCollectionKey, json.encode(jobs));
    }
  }

  @override
  Future<int> clearCompleted() async {
    final jobs = [..._jobStreamController.value];
    final completedJobsAmount = jobs.where((t) => t.isCompleted).length;
    jobs.removeWhere((t) => t.isCompleted);
    _jobStreamController.add(jobs);
    await _setValue(kJobsCollectionKey, json.encode(jobs));
    return completedJobsAmount;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final jobs = [..._jobStreamController.value];
    final changedJobsAmount =
        jobs.where((t) => t.isCompleted != isCompleted).length;
    final newJobs = [
      for (final job in jobs) job.copyWith(isCompleted: isCompleted)
    ];
    _jobStreamController.add(newJobs);
    await _setValue(kJobsCollectionKey, json.encode(newJobs));
    return changedJobsAmount;
  }
}
