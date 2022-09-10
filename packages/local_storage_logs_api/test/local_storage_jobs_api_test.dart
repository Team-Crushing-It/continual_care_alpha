// // ignore_for_file: prefer_const_constructors
// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:local_storage_logs_api/local_storage_logs_api.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:logs_api/logs_api.dart';

// class MockSharedPreferences extends Mock implements SharedPreferences {}

// void main() {
//   group('LocalStorageLogsApi', () {
//     late SharedPreferences plugin;

//     final logs = [
//       Log(
//         id: '1',
//         title: 'title 1',
//         description: 'description 1',
//       ),
//       Log(
//         id: '2',
//         title: 'title 2',
//         description: 'description 2',
//       ),
//       Log(
//         id: '3',
//         title: 'title 3',
//         description: 'description 3',
//         isCompleted: true,
//       ),
//     ];

//     setUp(() {
//       plugin = MockSharedPreferences();
//       when(() => plugin.getString(any())).thenReturn(json.encode(logs));
//       when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
//     });

//     LocalStorageLogsApi createSubject() {
//       return LocalStorageLogsApi(
//         plugin: plugin,
//       );
//     }

//     group('constructor', () {
//       test('works properly', () {
//         expect(
//           createSubject,
//           returnsNormally,
//         );
//       });

//       group('initializes the logs stream', () {
//         test('with existing logs if present', () {
//           final subject = createSubject();

//           expect(subject.getLogs(), emits(logs));
//           verify(
//             () => plugin.getString(
//               LocalStorageLogsApi.kLogsCollectionKey,
//             ),
//           ).called(1);
//         });

//         test('with empty list if no logs present', () {
//           when(() => plugin.getString(any())).thenReturn(null);

//           final subject = createSubject();

//           expect(subject.getLogs(), emits(const <Log>[]));
//           verify(
//             () => plugin.getString(
//               LocalStorageLogsApi.kLogsCollectionKey,
//             ),
//           ).called(1);
//         });
//       });
//     });

//     test('getLogs returns stream of current list logs', () {
//       expect(
//         createSubject().getLogs(),
//         emits(logs),
//       );
//     });

//     group('saveLog', () {
//       test('saves new logs', () {
//         final newLog = Log(
//           id: '4',
//           title: 'title 4',
//           description: 'description 4',
//         );

//         final newLogs = [...logs, newLog];

//         final subject = createSubject();

//         expect(subject.saveLog(newLog), completes);
//         expect(subject.getLogs(), emits(newLogs));

//         verify(
//           () => plugin.setString(
//             LocalStorageLogsApi.kLogsCollectionKey,
//             json.encode(newLogs),
//           ),
//         ).called(1);
//       });

//       test('updates existing logs', () {
//         final updatedLog = Log(
//           id: '1',
//           title: 'new title 1',
//           description: 'new description 1',
//           isCompleted: true,
//         );
//         final newLogs = [updatedLog, ...logs.sublist(1)];

//         final subject = createSubject();

//         expect(subject.saveLog(updatedLog), completes);
//         expect(subject.getLogs(), emits(newLogs));

//         verify(
//           () => plugin.setString(
//             LocalStorageLogsApi.kLogsCollectionKey,
//             json.encode(newLogs),
//           ),
//         ).called(1);
//       });
//     });

//     group('deleteLog', () {
//       test('deletes existing logs', () {
//         final newLogs = logs.sublist(1);

//         final subject = createSubject();

//         expect(subject.deleteLog(logs[0].id), completes);
//         expect(subject.getLogs(), emits(newLogs));

//         verify(
//           () => plugin.setString(
//             LocalStorageLogsApi.kLogsCollectionKey,
//             json.encode(newLogs),
//           ),
//         ).called(1);
//       });

//       test(
//         'throws LogNotFoundException if log '
//         'with provided id is not found',
//         () {
//           final subject = createSubject();

//           expect(
//             () => subject.deleteLog('non-existing-id'),
//             throwsA(isA<LogNotFoundException>()),
//           );
//         },
//       );
//     });

//     group('clearCompleted', () {
//       test('deletes all completed logs', () {
//         final newLogs = logs.where((log) => !log.isCompleted).toList();
//         final deletedLogsAmount = logs.length - newLogs.length;

//         final subject = createSubject();

//         expect(
//           subject.clearCompleted(),
//           completion(equals(deletedLogsAmount)),
//         );
//         expect(subject.getLogs(), emits(newLogs));

//         verify(
//           () => plugin.setString(
//             LocalStorageLogsApi.kLogsCollectionKey,
//             json.encode(newLogs),
//           ),
//         ).called(1);
//       });
//     });

//     group('completeAll', () {
//       test('sets isCompleted on all logs to provided value', () {
//         final newLogs =
//             logs.map((log) => log.copyWith(isCompleted: true)).toList();
//         final changedLogsAmount =
//             logs.where((log) => !log.isCompleted).length;

//         final subject = createSubject();

//         expect(
//           subject.completeAll(isCompleted: true),
//           completion(equals(changedLogsAmount)),
//         );
//         expect(subject.getLogs(), emits(newLogs));

//         verify(
//           () => plugin.setString(
//             LocalStorageLogsApi.kLogsCollectionKey,
//             json.encode(newLogs),
//           ),
//         ).called(1);
//       });
//     });
//   });
// }
