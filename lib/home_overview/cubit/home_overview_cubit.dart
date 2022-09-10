import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:jobs_repository/jobs_repository.dart';

part 'home_overview_state.dart';

class HomeOverviewCubit extends Cubit<HomeOverviewState> {
  HomeOverviewCubit({required JobsRepository repository})
      : _repository = repository,
        super(HomeOverviewState());
  final JobsRepository _repository;

  void getUpcoming() async {
    List<Job> jobs = await _repository.getJobs().first;
    jobs = jobs.where((element) => element.startTime.isAfter(DateTime.now())).toList();
    jobs.sort(((a, b) => a.startTime.compareTo(b.startTime)));
    final job = jobs.first;
    emit(HomeOverviewState(job: job));
  }
}
