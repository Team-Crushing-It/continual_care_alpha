// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:firestore_jobs_api/firestore_jobs_api.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:test/test.dart';
// import 'package:jobs_api/jobs_api.dart';

// void main() {
//   late FirebaseFirestore fakeFirestore;
//   late CollectionReference<Job> jobsCollection;

//   group(
//     'FirestoreJobsApi',
//     () {
//       final jobs = [
//         Job(
//           id: '1',
//           title: 'title 1',
//           description: 'description 1',
//         ),
//         Job(
//           id: '2',
//           title: 'title 2',
//           description: 'description 2',
//         ),
//         Job(
//           id: '3',
//           title: 'title 3',
//           description: 'description 3',
//         ),
//       ];

//       setUpAll(
//         () {
//           fakeFirestore = FakeFirebaseFirestore();

//           jobsCollection = fakeFirestore.collection('jobs').withConverter(
//                 fromFirestore: (snapshot, _) => Job.fromJson(snapshot.data()!),
//                 toFirestore: (job, _) => job.toJson(),
//               );

//           for (final job in jobs) {
//             jobsCollection.add(job);
//           }
//         },
//       );

//       FirestoreJobsApi createSubject() {
//         return FirestoreJobsApi(firestore: fakeFirestore);
//       }

//       group(
//         'constructor',
//         () {
//           test('can be instantiated', () {
//             expect(FirestoreJobsApi(firestore: fakeFirestore), isNotNull);
//           });

//           group(
//             'initializes the jobs stream',
//             () {
//               test(
//                 'with existing jobs if present',
//                 () {
//                   final subject = createSubject();

//                   expect(subject.getJobs(), emits(jobs));
//                 },
//               );
//               test('with empty list if no jobs present', () {
//                 fakeFirestore = FakeFirebaseFirestore();

//                 final subject = createSubject();

//                 expect(subject.getJobs(), emits(const <Job>[]));
//               });
//             },
//           );

//           group('saveJob', () {
//             test('saves new job', () {
//               final newJob = Job(
//                 id: '4',
//                 title: 'title 4',
//                 description: 'description 4',
//               );

//               final newJobs = [...jobs, newJob];

//               final subject = createSubject();

//               expect(subject.saveJob(newJob), completes);

//               expect(subject.getJobs(), emitsThrough(newJobs));

//               // verify(
//               //   () => plugin.setString(
//               //     LocalStorageJobsApi.kJobsCollectionKey,
//               //     json.encode(newJobs),
//               //   ),
//               // ).called(1);
//             });

//             test('updates existing jobs', () {
//               final updatedJob = Job(
//                 id: '1',
//                 title: 'new title 1',
//                 description: 'new description 1',
//                 isCompleted: true,
//               );
//               final newJobs = [updatedJob, ...jobs.sublist(1)];

//               final subject = createSubject();

//               expect(subject.saveJob(updatedJob), completes);
//               expect(subject.getJobs(), emits(newJobs));

//               // verify(
//               //   () => plugin.setString(
//               //     LocalStorageJobsApi.kJobsCollectionKey,
//               //     json.encode(newJobs),
//               //   ),
//               // ).called(1);
//             });
//           });
//         },
//       );
//     },
//   );
// }
