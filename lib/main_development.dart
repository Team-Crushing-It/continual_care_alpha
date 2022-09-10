import 'package:authentication_repository/authentication_repository.dart';
import 'package:continual_care_alpha/app/app.dart';
import 'package:continual_care_alpha/firebase_options.dart';
import 'package:firestore_jobs_api/firestore_jobs_api.dart';
import 'package:firestore_logs_api/firestore_logs_api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs_repository/jobs_repository.dart';
import 'package:logs_repository/logs_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  final jobsApi = FirestoreJobsApi(firestore: FirebaseFirestore.instance);
  final jobsRepository = JobsRepository(jobsApi: jobsApi);
  final logsApi = FirestoreLogsApi(firestore: FirebaseFirestore.instance);
  final logsRepository = LogsRepository(logsApi: logsApi);

  return runApp(
    App(
      authenticationRepository: authenticationRepository,
      jobsRepository: jobsRepository,
    ),
  );
}
