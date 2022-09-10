// // ignore_for_file: prefer_const_constructors
// import 'package:mocktail/mocktail.dart';
// import 'package:test/test.dart';
// import 'package:jobs_api/jobs_api.dart';
// import 'package:jobs_repository/jobs_repository.dart';

// class MockJobsApi extends Mock implements JobsApi {}

// class FakeJob extends Fake implements Job {}

// void main() {
//   group('JobsRepository', () {
//     late JobsApi api;

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

//     setUpAll(() {
//       registerFallbackValue(FakeJob());
//     });

//     setUp(() {
//       api = MockJobsApi();
//       when(() => api.getJobs()).thenAnswer((_) => Stream.value(jobs));
//       when(() => api.saveJob(any())).thenAnswer((_) async {});
//       when(() => api.deleteJob(any())).thenAnswer((_) async {});
//       when(
//         () => api.clearCompleted(),
//       ).thenAnswer((_) async => jobs.where((job) => job.isCompleted).length);
//       when(
//         () => api.completeAll(isCompleted: any(named: 'isCompleted')),
//       ).thenAnswer((_) async => 0);
//     });

//     JobsRepository createSubject() => JobsRepository(jobsApi: api);

//     group('constructor', () {
//       test('works properly', () {
//         expect(
//           createSubject,
//           returnsNormally,
//         );
//       });
//     });

//     group('getJobs', () {
//       test('makes correct api request', () {
//         final subject = createSubject();

//         expect(
//           subject.getJobs(),
//           isNot(throwsA(anything)),
//         );

//         verify(() => api.getJobs()).called(1);
//       });

//       test('returns stream of current list jobs', () {
//         expect(
//           createSubject().getJobs(),
//           emits(jobs),
//         );
//       });
//     });

//     group('saveJob', () {
//       test('makes correct api request', () {
//         final newJob = Job(
//           id: '4',
//           title: 'title 4',
//           description: 'description 4',
//         );

//         final subject = createSubject();

//         expect(subject.saveJob(newJob), completes);

//         verify(() => api.saveJob(newJob)).called(1);
//       });
//     });

//     group('deleteJob', () {
//       test('makes correct api request', () {
//         final subject = createSubject();

//         expect(subject.deleteJob(jobs[0].id), completes);

//         verify(() => api.deleteJob(jobs[0].id)).called(1);
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
