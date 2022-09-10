import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:jobs_repository/jobs_repository.dart';
import 'package:logs_repository/logs_repository.dart';

part 'home_overview_state.dart';

class HomeOverviewCubit extends Cubit<HomeOverviewState> {
  HomeOverviewCubit({
    required JobsRepository jobsRepository,
    required LogsRepository logsRepository,
  })  : _jobsRepository = jobsRepository,
        _logsRepository = logsRepository,
        super(HomeOverviewState());

  final JobsRepository _jobsRepository;
  final LogsRepository _logsRepository;

  void getUpcoming() async {
    List<Job> jobs = await _jobsRepository.getJobs().first;
    jobs = jobs
        .where((element) => element.startTime.isAfter(DateTime.now()))
        .toList();
    jobs.sort(((a, b) => a.startTime.compareTo(b.startTime)));
    if (jobs.isNotEmpty) {
      final job = jobs.first;
      emit(HomeOverviewState(job: job));
    }
  }

  //get logs

  //Add log
  void addLog() async {
    _logsRepository.saveLog(log);
  }
}
