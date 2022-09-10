// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:firestore_logs_api/firestore_logs_api.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:test/test.dart';
// import 'package:logs_api/logs_api.dart';

// void main() {
//   late FirebaseFirestore fakeFirestore;
//   late CollectionReference<Log> logsCollection;

//   group(
//     'FirestoreLogsApi',
//     () {
//       final logs = [
//         Log(
//           id: '1',
//           title: 'title 1',
//           description: 'description 1',
//         ),
//         Log(
//           id: '2',
//           title: 'title 2',
//           description: 'description 2',
//         ),
//         Log(
//           id: '3',
//           title: 'title 3',
//           description: 'description 3',
//         ),
//       ];

//       setUpAll(
//         () {
//           fakeFirestore = FakeFirebaseFirestore();

//           logsCollection = fakeFirestore.collection('logs').withConverter(
//                 fromFirestore: (snapshot, _) => Log.fromJson(snapshot.data()!),
//                 toFirestore: (log, _) => log.toJson(),
//               );

//           for (final log in logs) {
//             logsCollection.add(log);
//           }
//         },
//       );

//       FirestoreLogsApi createSubject() {
//         return FirestoreLogsApi(firestore: fakeFirestore);
//       }

//       group(
//         'constructor',
//         () {
//           test('can be instantiated', () {
//             expect(FirestoreLogsApi(firestore: fakeFirestore), isNotNull);
//           });

//           group(
//             'initializes the logs stream',
//             () {
//               test(
//                 'with existing logs if present',
//                 () {
//                   final subject = createSubject();

//                   expect(subject.getLogs(), emits(logs));
//                 },
//               );
//               test('with empty list if no logs present', () {
//                 fakeFirestore = FakeFirebaseFirestore();

//                 final subject = createSubject();

//                 expect(subject.getLogs(), emits(const <Log>[]));
//               });
//             },
//           );

//           group('saveLog', () {
//             test('saves new log', () {
//               final newLog = Log(
//                 id: '4',
//                 title: 'title 4',
//                 description: 'description 4',
//               );

//               final newLogs = [...logs, newLog];

//               final subject = createSubject();

//               expect(subject.saveLog(newLog), completes);

//               expect(subject.getLogs(), emitsThrough(newLogs));

//               // verify(
//               //   () => plugin.setString(
//               //     LocalStorageLogsApi.kLogsCollectionKey,
//               //     json.encode(newLogs),
//               //   ),
//               // ).called(1);
//             });

//             test('updates existing logs', () {
//               final updatedLog = Log(
//                 id: '1',
//                 title: 'new title 1',
//                 description: 'new description 1',
//                 isCompleted: true,
//               );
//               final newLogs = [updatedLog, ...logs.sublist(1)];

//               final subject = createSubject();

//               expect(subject.saveLog(updatedLog), completes);
//               expect(subject.getLogs(), emits(newLogs));

//               // verify(
//               //   () => plugin.setString(
//               //     LocalStorageLogsApi.kLogsCollectionKey,
//               //     json.encode(newLogs),
//               //   ),
//               // ).called(1);
//             });
//           });
//         },
//       );
//     },
//   );
// }
