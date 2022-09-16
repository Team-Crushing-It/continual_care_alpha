import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobs_repository/jobs_repository.dart';
import 'package:logs_api/logs_api.dart';
import 'package:logs_repository/logs_repository.dart';

part 'home_overview_event.dart';
part 'home_overview_state.dart';

class HomeOverviewBloc extends Bloc<HomeOverviewEvent, HomeOverviewState> {
  HomeOverviewBloc({
    required JobsRepository jobsRepository,
    required LogsRepository logsRepository,
  })  : _jobsRepository = jobsRepository,
        _logsRepository = logsRepository,
        super(HomeOverviewState()) {
    on<HomeOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<HomeOverviewUpcomingJobRequested>(_onUpcomingJobRequested);
    on<HomeOverviewLogAdded>(_onLogAdded);
  }

  final JobsRepository _jobsRepository;
  final LogsRepository _logsRepository;

  Future<void> _onSubscriptionRequested(
      HomeOverviewEvent event, Emitter<HomeOverviewState> emit) async {
    await emit.forEach<List<Log>>(_logsRepository.getLogs(), onData: (logs) {
      return state.copyWith(logs: logs);
    });
  }

  Future<void> _onUpcomingJobRequested(
      HomeOverviewEvent event, Emitter<HomeOverviewState> emit) async {
    List<Job> jobs = await _jobsRepository.getJobs().first;
    jobs = jobs
        .where((element) => element.startTime.isAfter(DateTime.now()))
        .toList();
    jobs.sort(((a, b) => a.startTime.compareTo(b.startTime)));
    if (jobs.isNotEmpty) {
      final job = jobs.first;
      emit(state.copyWith(job: job));
    }
  }

  Future<void> _onLogAdded(
      HomeOverviewEvent event, Emitter<HomeOverviewState> emit) async {
    final log = Log(mood: "hello friend",badls: [
      ADL(name: "badl 1",isIndependent: false),
      ADL(name: "badl 2",isIndependent: true),
      ADL(name: "badl 3",isIndependent: false),
      ADL(name: "badl 4",isIndependent: true),
    ],iadls: [
      ADL(name: "iadl 1",isIndependent: false),
      ADL(name: "iadl 2",isIndependent: true),
      ADL(name: "iadl 3",isIndependent: false),
      ADL(name: "iadl 4",isIndependent: true),
    ]);
    _logsRepository.saveLog(log);
    final logs = await _logsRepository.getLogs().first;
    emit(state.copyWith(logs: logs));
  }
}
