import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logs_api/logs_api.dart';

/// {@template local_storage_Logs_api}
/// A Flutter implementation of the [LogsApi] that uses local storage.
/// {@endtemplate}
class LocalStorageLogsApi extends LogsApi {
  /// {@macro local_storage_Logs_api}
  LocalStorageLogsApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _LogstreamController = BehaviorSubject<List<Log>>.seeded(const []);

  /// The key used for storing the logs locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kLogsCollectionKey = '__Logs_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final LogsJson = _getValue(kLogsCollectionKey);
    if (LogsJson != null) {
      final logs = List<Map>.from(json.decode(LogsJson) as List)
          .map((jsonMap) => Log.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _LogstreamController.add(logs);
    } else {
      _LogstreamController.add(const []);
    }
  }

  @override
  Stream<List<Log>> getLogs() => _LogstreamController.asBroadcastStream();

  @override
  Future<void> saveLog(Log log) {
    final logs = [..._LogstreamController.value];
    final logIndex = logs.indexWhere((t) => t.id == log.id);
    if (logIndex >= 0) {
      logs[logIndex] = log;
    } else {
      logs.add(log);
    }

    _LogstreamController.add(logs);
    return _setValue(kLogsCollectionKey, json.encode(logs));
  }

  @override
  Future<void> deleteLog(String id) async {
    final logs = [..._LogstreamController.value];
    final logIndex = logs.indexWhere((t) => t.id == id);
    if (logIndex == -1) {
      throw LogNotFoundException();
    } else {
      logs.removeAt(logIndex);
      _LogstreamController.add(logs);
      return _setValue(kLogsCollectionKey, json.encode(logs));
    }
  }

  @override
  Future<int> clearCompleted() async {
    final logs = [..._LogstreamController.value];
    final completedLogsAmount = logs.where((t) => t.isCompleted).length;
    logs.removeWhere((t) => t.isCompleted);
    _LogstreamController.add(logs);
    await _setValue(kLogsCollectionKey, json.encode(logs));
    return completedLogsAmount;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final logs = [..._LogstreamController.value];
    final changedLogsAmount =
        logs.where((t) => t.isCompleted != isCompleted).length;
    final newLogs = [
      for (final log in logs) log.copyWith(isCompleted: isCompleted)
    ];
    _LogstreamController.add(newLogs);
    await _setValue(kLogsCollectionKey, json.encode(newLogs));
    return changedLogsAmount;
  }
}
