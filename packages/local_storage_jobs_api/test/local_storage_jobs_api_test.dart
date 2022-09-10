// // ignore_for_file: prefer_const_constructors
// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:local_storage_jobs_api/local_storage_jobs_api.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:jobs_api/jobs_api.dart';

// class MockSharedPreferences extends Mock implements SharedPreferences {}

// void main() {
//   group('LocalStorageJobsApi', () {
//     late SharedPreferences plugin;

//     final jobs = [
//       Job(
//         id: '1',
//         title: 'title 1',
//         description: 'description 1',
//       ),
//       Job(
//         id: '2',
//         title: 'title 2',
//         description: 'description 2',
//       ),
//       Job(
//         id: '3',
//         title: 'title 3',
//         description: 'description 3',
//         isCompleted: true,
//       ),
//     ];

//     setUp(() {
//       plugin = MockSharedPreferences();
//       when(() => plugin.getString(any())).thenReturn(json.encode(jobs));
//       when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
//     });

//     LocalStorageJobsApi createSubject() {
//       return LocalStorageJobsApi(
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

//       group('initializes the jobs stream', () {
//         test('with existing jobs if present', () {
//           final subject = createSubject();

//           expect(subject.getJobs(), emits(jobs));
//           verify(
//             () => plugin.getString(
//               LocalStorageJobsApi.kJobsCollectionKey,
//             ),
//           ).called(1);
//         });

//         test('with empty list if no jobs present', () {
//           when(() => plugin.getString(any())).thenReturn(null);

//           final subject = createSubject();

//           expect(subject.getJobs(), emits(const <Job>[]));
//           verify(
//             () => plugin.getString(
//               LocalStorageJobsApi.kJobsCollectionKey,
//             ),
//           ).called(1);
//         });
//       });
//     });

//     test('getJobs returns stream of current list jobs', () {
//       expect(
//         createSubject().getJobs(),
//         emits(jobs),
//       );
//     });

//     group('saveJob', () {
//       test('saves new jobs', () {
//         final newJob = Job(
//           id: '4',
//           title: 'title 4',
//           description: 'description 4',
//         );

//         final newJobs = [...jobs, newJob];

//         final subject = createSubject();

//         expect(subject.saveJob(newJob), completes);
//         expect(subject.getJobs(), emits(newJobs));

//         verify(
//           () => plugin.setString(
//             LocalStorageJobsApi.kJobsCollectionKey,
//             json.encode(newJobs),
//           ),
//         ).called(1);
//       });

//       test('updates existing jobs', () {
//         final updatedJob = Job(
//           id: '1',
//           title: 'new title 1',
//           description: 'new description 1',
//           isCompleted: true,
//         );
//         final newJobs = [updatedJob, ...jobs.sublist(1)];

//         final subject = createSubject();

//         expect(subject.saveJob(updatedJob), completes);
//         expect(subject.getJobs(), emits(newJobs));

//         verify(
//           () => plugin.setString(
//             LocalStorageJobsApi.kJobsCollectionKey,
//             json.encode(newJobs),
//           ),
//         ).called(1);
//       });
//     });

//     group('deleteJob', () {
//       test('deletes existing jobs', () {
//         final newJobs = jobs.sublist(1);

//         final subject = createSubject();

//         expect(subject.deleteJob(jobs[0].id), completes);
//         expect(subject.getJobs(), emits(newJobs));

//         verify(
//           () => plugin.setString(
//             LocalStorageJobsApi.kJobsCollectionKey,
//             json.encode(newJobs),
//           ),
//         ).called(1);
//       });

//       test(
//         'throws JobNotFoundException if job '
//         'with provided id is not found',
//         () {
//           final subject = createSubject();

//           expect(
//             () => subject.deleteJob('non-existing-id'),
//             throwsA(isA<JobNotFoundException>()),
//           );
//         },
//       );
//     });

//     group('clearCompleted', () {
//       test('deletes all completed jobs', () {
//         final newJobs = jobs.where((job) => !job.isCompleted).toList();
//         final deletedJobsAmount = jobs.length - newJobs.length;

//         final subject = createSubject();

//         expect(
//           subject.clearCompleted(),
//           completion(equals(deletedJobsAmount)),
//         );
//         expect(subject.getJobs(), emits(newJobs));

//         verify(
//           () => plugin.setString(
//             LocalStorageJobsApi.kJobsCollectionKey,
//             json.encode(newJobs),
//           ),
//         ).called(1);
//       });
//     });

//     group('completeAll', () {
//       test('sets isCompleted on all jobs to provided value', () {
//         final newJobs =
//             jobs.map((job) => job.copyWith(isCompleted: true)).toList();
//         final changedJobsAmount =
//             jobs.where((job) => !job.isCompleted).length;

//         final subject = createSubject();

//         expect(
//           subject.completeAll(isCompleted: true),
//           completion(equals(changedJobsAmount)),
//         );
//         expect(subject.getJobs(), emits(newJobs));

//         verify(
//           () => plugin.setString(
//             LocalStorageJobsApi.kJobsCollectionKey,
//             json.encode(newJobs),
//           ),
//         ).called(1);
//       });
//     });
//   });
// }
