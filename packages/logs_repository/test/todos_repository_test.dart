// // ignore_for_file: prefer_const_constructors
// import 'package:mocktail/mocktail.dart';
// import 'package:test/test.dart';
// import 'package:logs_api/logs_api.dart';
// import 'package:logs_repository/logs_repository.dart';

// class MockLogsApi extends Mock implements LogsApi {}

// class FakeLog extends Fake implements Log {}

// void main() {
//   group('LogsRepository', () {
//     late LogsApi api;

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

//     setUpAll(() {
//       registerFallbackValue(FakeLog());
//     });

//     setUp(() {
//       api = MockLogsApi();
//       when(() => api.getLogs()).thenAnswer((_) => Stream.value(logs));
//       when(() => api.saveLog(any())).thenAnswer((_) async {});
//       when(() => api.deleteLog(any())).thenAnswer((_) async {});
//       when(
//         () => api.clearCompleted(),
//       ).thenAnswer((_) async => logs.where((log) => log.isCompleted).length);
//       when(
//         () => api.completeAll(isCompleted: any(named: 'isCompleted')),
//       ).thenAnswer((_) async => 0);
//     });

//     LogsRepository createSubject() => LogsRepository(logsApi: api);

//     group('constructor', () {
//       test('works properly', () {
//         expect(
//           createSubject,
//           returnsNormally,
//         );
//       });
//     });

//     group('getLogs', () {
//       test('makes correct api request', () {
//         final subject = createSubject();

//         expect(
//           subject.getLogs(),
//           isNot(throwsA(anything)),
//         );

//         verify(() => api.getLogs()).called(1);
//       });

//       test('returns stream of current list logs', () {
//         expect(
//           createSubject().getLogs(),
//           emits(logs),
//         );
//       });
//     });

//     group('saveLog', () {
//       test('makes correct api request', () {
//         final newLog = Log(
//           id: '4',
//           title: 'title 4',
//           description: 'description 4',
//         );

//         final subject = createSubject();

//         expect(subject.saveLog(newLog), completes);

//         verify(() => api.saveLog(newLog)).called(1);
//       });
//     });

//     group('deleteLog', () {
//       test('makes correct api request', () {
//         final subject = createSubject();

//         expect(subject.deleteLog(logs[0].id), completes);

//         verify(() => api.deleteLog(logs[0].id)).called(1);
//       });
//     });

//     group('clearCompleted', () {
//       test('makes correct request', () {
//         final subject = createSubject();

//         expect(subject.clearCompleted(), completes);

//         verify(() => api.clearCompleted()).called(1);
//       });
//     });

//     group('completeAll', () {
//       test('makes correct request', () {
//         final subject = createSubject();

//         expect(subject.completeAll(isCompleted: true), completes);

//         verify(() => api.completeAll(isCompleted: true)).called(1);
//       });
//     });
//   });
// }
