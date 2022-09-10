import 'package:logs_api/logs_api.dart';

/// {@template logs_api}
/// The interface for an API that provides access to a list of logs.
/// {@endtemplate}
abstract class LogsApi {
  /// {@macro logs_api}
  const LogsApi();

  /// Provides a [Stream] of all logs.
  Stream<List<Log>> getLogs();

  /// Saves a [log].
  ///
  /// If a [log] with the same id already exists, it will be replaced.
  Future<void> saveLog(Log log);

  /// Deletes the log with the given id.
  ///
  /// If no log with the given id exists, a [LogNotFoundException] error is
  /// thrown.
  Future<void> deleteLog(String id);
}

/// Error thrown when a [Log] with a given id is not found.
class LogNotFoundException implements Exception {}
