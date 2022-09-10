import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care_alpha/schedule/schedule.dart';

@visibleForTesting
enum ScheduleOption { toggleAll, clearCompleted }

class ScheduleOptionsButton extends StatelessWidget {
  const ScheduleOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {

    final jobs = context.select((ScheduleBloc bloc) => bloc.state.jobs);
    final hasJobs = jobs.isNotEmpty;
    final completedJobsAmount = jobs.where((job) => job.isCompleted).length;

    return PopupMenuButton<ScheduleOption>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      tooltip: 'l10n.jobsOverviewOptionsTooltip,',
      onSelected: (options) {
        switch (options) {
          case ScheduleOption.toggleAll:
            context
                .read<ScheduleBloc>()
                .add(const ScheduleToggleAllRequested());
            break;
          case ScheduleOption.clearCompleted:
            context
                .read<ScheduleBloc>()
                .add(const ScheduleClearCompletedRequested());
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: ScheduleOption.toggleAll,
            enabled: hasJobs,
            child: Text(
              completedJobsAmount == jobs.length
                  ? 'l10n.jobsOverviewOptionsMarkAllIncomplete'
                  : 'l10n.jobsOverviewOptionsMarkAllComplete,',
            ),
          ),
          PopupMenuItem(
            value: ScheduleOption.clearCompleted,
            enabled: hasJobs && completedJobsAmount > 0,
            child: Text('l10n.jobsOverviewOptionsClearCompleted'),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
