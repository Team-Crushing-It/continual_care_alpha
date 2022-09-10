import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logs_api/logs_api.dart';

/// {@template firestore_logs_api}
/// Firestore implementation for the Logs example
/// {@endtemplate}
class FirestoreLogsApi implements LogsApi {
  /// {@macro firestore_logs_api}
  FirestoreLogsApi({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// a converter method for maintaining type-safety
  late final logsCollection =
      _firestore.collection('logs').withConverter<Log>(
            fromFirestore: (snapshot, _) => Log.fromJson(snapshot.data()!),
            toFirestore: (log, _) => log.toJson(),
          );

  /// This stream orders the [Log]'s by the
  /// time they were created, and then converts
  /// them from a [DocumentSnapshot] into
  /// a [Log]
  @override
  Stream<List<Log>> getLogs() {
    return logsCollection.orderBy('startTime').snapshots().map(
          (snapshot) => snapshot.docs.map((e) => e.data()).toList(),
        );
  }

  /// This method first checks whether or not a log exists
  /// If it doesn't, then we add a timestamp to the log in
  /// order to preserve the order they were added
  /// Else, we update the existing one
  @override
  Future<void> saveLog(Log newLog) async {
    final check = await logsCollection.where('id', isEqualTo: newLog.id).get();

    if (check.docs.isEmpty) {
      // final output =
      //     log.copyWith(id: Timestamp.now().millisecondsSinceEpoch.toString());
      await logsCollection.add(newLog);
    } else {
      final currentLogId = check.docs[0].reference.id;
      await logsCollection.doc(currentLogId).update(newLog.toJson());
    }
  }

  /// This method first checks to see if the log
  /// exists, and if so it deletes it
  // TODO(fix): check out dismissiable bug

  @override
  Future<void> deleteLog(String id) async {
    final check = await logsCollection.where('id', isEqualTo: id).get();

    if (check.docs.isEmpty) {
      throw LogNotFoundException();
    } else {
      final currentLogId = check.docs[0].reference.id;
      await logsCollection.doc(currentLogId).delete();
    }
  }

  /// This method uses the Batch write api for
  /// executing multiple operations in a single call,
  /// which in this case is to delete all the logs that
  /// are marked completed
  @override
  Future<int> clearCompleted() {
    final batch = _firestore.batch();
    return logsCollection
        .where('isCompleted', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      final completedLogsAmount = querySnapshot.docs.length;
      for (final document in querySnapshot.docs) {
        batch.delete(document.reference);
      }
      batch.commit();
      return completedLogsAmount;
    });
  }

  /// This method uses the Batch write api for
  /// executing multiple operations in a single call,
  /// which in this case is to mark all the logs as
  /// completed
  @override
  Future<int> completeAll({required bool isCompleted}) {
    final batch = _firestore.batch();
    return logsCollection.get().then((querySnapshot) {
      final completedLogsAmount = querySnapshot.docs.length;
      for (final document in querySnapshot.docs) {
        final completedLog = document.data().copyWith(isCompleted: true);
        batch.update(document.reference, completedLog.toJson());
      }
      batch.commit();
      return completedLogsAmount;
    });
  }
}
