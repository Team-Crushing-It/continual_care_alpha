import 'package:logs_api/logs_api.dart';

/// {@template logs_repository}
/// A repository that handles log related requests.
/// {@endtemplate}
class LogsRepository {
  /// {@macro logs_repository}
  const LogsRepository({
    required LogsApi logsApi,
  }) : _logsApi = logsApi;

  final LogsApi _logsApi;

  /// Provides a [Stream] of all logs.
  Stream<List<Log>> getLogs() => _logsApi.getLogs();

  /// Saves a [log].
  ///
  /// If a [log] with the same id already exists, it will be replaced.
  Future<void> saveLog(Log log) => _logsApi.saveLog(log);

  /// Deletes the log with the given id.
  ///
  /// If no log with the given id exists, a [LogNotFoundException] error is
  /// thrown.
  Future<void> deleteLog(String id) => _logsApi.deleteLog(id);

  /// Deletes all completed logs.
  ///
  /// Returns the number of deleted logs.
  Future<int> clearCompleted() => _logsApi.clearCompleted();

  /// Sets the `isCompleted` state of all logs to the given value.
  ///
  /// Returns the number of updated logs.
  Future<int> completeAll({required bool isCompleted}) =>
      _logsApi.completeAll(isCompleted: isCompleted);
}
