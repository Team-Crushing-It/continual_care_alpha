import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs_api/jobs_api.dart';

/// {@template firestore_jobs_api}
/// Firestore implementation for the Jobs example
/// {@endtemplate}
class FirestoreJobsApi implements JobsApi {
  /// {@macro firestore_jobs_api}
  FirestoreJobsApi({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// a converter method for maintaining type-safety
  late final jobsCollection =
      _firestore.collection('jobs').withConverter<Job>(
            fromFirestore: (snapshot, _) => Job.fromJson(snapshot.data()!),
            toFirestore: (job, _) => job.toJson(),
          );

  /// This stream orders the [Job]'s by the
  /// time they were created, and then converts
  /// them from a [DocumentSnapshot] into
  /// a [Job]
  @override
  Stream<List<Job>> getJobs() {
    return jobsCollection.orderBy('startTime').snapshots().map(
          (snapshot) => snapshot.docs.map((e) => e.data()).toList(),
        );
  }

  /// This method first checks whether or not a job exists
  /// If it doesn't, then we add a timestamp to the job in
  /// order to preserve the order they were added
  /// Else, we update the existing one
  @override
  Future<void> saveJob(Job newJob) async {
    final check = await jobsCollection.where('id', isEqualTo: newJob.id).get();

    if (check.docs.isEmpty) {
      // final output =
      //     job.copyWith(id: Timestamp.now().millisecondsSinceEpoch.toString());
      await jobsCollection.add(newJob);
    } else {
      final currentJobId = check.docs[0].reference.id;
      await jobsCollection.doc(currentJobId).update(newJob.toJson());
    }
  }

  /// This method first checks to see if the job
  /// exists, and if so it deletes it
  // TODO(fix): check out dismissiable bug

  @override
  Future<void> deleteJob(String id) async {
    final check = await jobsCollection.where('id', isEqualTo: id).get();

    if (check.docs.isEmpty) {
      throw JobNotFoundException();
    } else {
      final currentJobId = check.docs[0].reference.id;
      await jobsCollection.doc(currentJobId).delete();
    }
  }

  /// This method uses the Batch write api for
  /// executing multiple operations in a single call,
  /// which in this case is to delete all the jobs that
  /// are marked completed
  @override
  Future<int> clearCompleted() {
    final batch = _firestore.batch();
    return jobsCollection
        .where('isCompleted', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      final completedJobsAmount = querySnapshot.docs.length;
      for (final document in querySnapshot.docs) {
        batch.delete(document.reference);
      }
      batch.commit();
      return completedJobsAmount;
    });
  }

  /// This method uses the Batch write api for
  /// executing multiple operations in a single call,
  /// which in this case is to mark all the jobs as
  /// completed
  @override
  Future<int> completeAll({required bool isCompleted}) {
    final batch = _firestore.batch();
    return jobsCollection.get().then((querySnapshot) {
      final completedJobsAmount = querySnapshot.docs.length;
      for (final document in querySnapshot.docs) {
        final completedJob = document.data().copyWith(isCompleted: true);
        batch.update(document.reference, completedJob.toJson());
      }
      batch.commit();
      return completedJobsAmount;
    });
  }
}
